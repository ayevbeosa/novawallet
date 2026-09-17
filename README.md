# NovaWallet Mobile — Send & Save

FirstBank NovaPay take-home: a Flutter app covering two journeys — sending
money from NovaWallet, and contributing to a NovaSave goal — built around
the brief's real subject: what happens when the network isn't reliable.

## Running it

Targeted against **Flutter 3.44.8 / Dart 3.12.2** (stable channel).

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # dart_mappable + drift codegen
flutter gen-l10n                                            # only needed if you edit lib/core/l10n/*.arb
flutter run
```

That's the single command path (`flutter run`) once codegen has run once —
codegen output is checked in under `lib/**/*.g.dart` / `*.mapper.dart` /
`lib/core/l10n/generated/`, so a plain `flutter pub get && flutter run` is
enough for a normal checkout.

### Tests

```bash
flutter test test/unit         # Money math, offline-queue engine (21 tests)
flutter test test/widget       # Send Money + NovaSave contribution flows (6 tests)
flutter test integration_test  # offline-queue-then-sync, on a device/emulator (2 tests)
```

All three suites were run and passed against an Android emulator
(`Pixel 9`, API 36) and via the host-process `flutter test` runner during
development — see **Test rigor** below for why they're split the way they
are.

## Architecture

Module-first layout:

```
lib/
  core/                     shared infrastructure — no dependency on modules/
    money/                  Money value type + Naira-input parser (kobo-exact)
    connectivity/           ConnectivityService (connectivity_plus wrapper)
    storage/                AppDatabase (Drift) — offline queue + cache tables
    sync/                   QueuedAction model + SyncQueueService (the drain engine)
    backend/                FakeNovaPayApi — the fake backend ("you own how you fake it")
    secure/                 SecureSessionStore (flutter_secure_storage)
    notifications/          LocalNotificationService
    theme/, widgets/        cyberpunk design system shared by both modules
    di/                     get_it composition root
    router/, shell/, app/   go_router config, bottom-nav shell, root MaterialApp widget
  modules/
    wallet/
      data/{models,repositories}/     WalletSnapshot, TransactionEntry, WalletRepository
      presentation/{cubits,screens,components}/
    save/
      data/{models,repositories}/     SavingsGoal, SaveRepository
      presentation/{cubits,screens,components}/
  main.dart
```

**Why this split:** `core` owns anything genuinely shared (the queue
engine, storage, connectivity, design system) and never imports from
`modules/*`. Each module owns its domain models and the mapping between
those models and Drift's generated row/companion types — `AppDatabase`
itself only ever speaks in Drift's own types (see
`core/storage/app_database.dart`'s doc comment), so it has zero
compile-time knowledge of `WalletSnapshot` or `SavingsGoal`. The one
exception is `core/backend/fake_novapay_api.dart`, which *does* import
both modules' models — a fake backend client is realistically going to
speak in the app's domain vocabulary, the same way a real API client's
response DTOs would. That's a deliberate, documented trade-off, not an
oversight.

### State management — `bloc_signals` / `bloc_signals_flutter`

Every screen's state is a `CubitSignal<State>` (synchronous `emit`, no
`Stream` overhead) provided via `BlocSignalProvider` and read with
`context.read<Cubit>()` (no rebuild) / `context.value<Cubit, State>()`
(rebuild on state change). Long-lived cubits (`WalletCubit`,
`SaveGoalsCubit`, `SyncStatusCubit`) are provided once at the shell level;
per-flow cubits (`SendMoneyCubit`, `ContributeCubit`, `CreateGoalCubit`)
are scoped to their screen/sheet and torn down with it, which is also what
guarantees an idempotency key is only ever minted once per attempt (see
below).

### Models — `dart_mappable`

`TransactionEntry`, `WalletSnapshot`, `SavingsGoal`, and the queue's
`QueuedAction` sealed hierarchy (`SendMoneyAction` / `ContributeGoalAction`)
are `dart_mappable` classes — immutable, with generated `copyWith`/
`toJson`/`fromJson`. `QueuedAction`'s JSON form is what gets persisted as
the queue row's `payloadJson`, so replaying a queued action after an app
restart means decoding exactly the same typed object that was enqueued,
not re-deriving it from something else.

### Dependency injection — `get_it`

One composition root (`core/di/service_locator.dart`, `setupServiceLocator()`)
registers every singleton once at startup. Screens call `getIt<T>()`
directly inside their `BlocSignalProvider.create` callbacks rather than
threading a services object through every widget constructor.

### Money — kobo-exact, always

`Money` (`core/money/money.dart`) wraps an `int` number of kobo. Every
arithmetic operation, the `format()` display path, and
`progressTowards()` (goal completion %) stay in integer space — `format()`
splits Naira/kobo with `~/` and `%`, never by dividing to a `double`.
`parseNairaInputToKobo()` parses what the user types the same way: string
splitting and `int.parse`, never `double.parse`. The only place a `double`
touches money at all is `Money.fromNaira()`, used solely for seed data in
tests — documented on the constructor as exactly that, not part of the
runtime path. See `test/unit/money_test.dart` for the drift cases this is
designed to defend against (10,000 additions of 1 kobo, 1/3-of-a-target
progress, etc.).

### Offline queue & sync — the actual point of this take-home

**Design:** every Send/Contribute goes through the same local queue,
online or offline — there is no separate "online path". `WalletRepository.
sendMoney()` / `SaveRepository.contribute()` mint an idempotency key
(`uuid.v4()`), build a `QueuedAction`, and call
`AppDatabase.enqueueAction()`. When online, `SyncQueueService` drains that
queue in well under a second, so the UX is indistinguishable from a direct
call — but the correctness guarantees (persistence, idempotency,
no-double-send) are uniform regardless of connectivity, instead of being a
special case that's easy to under-test.

**Exactly-once, end to end:**

1. **Insert once.** `idempotencyKey` is the queue table's primary key
   (`InsertMode.insertOrIgnore`) — even a UI bug that calls "enqueue" twice
   for the same attempt produces one row, not two.
2. **Drain once at a time.** A `_draining` single-flight guard means a
   reconnect event, an app-resume check, and a manual pull-to-refresh can
   never drain concurrently and double-process a row.
3. **Status survives the process.** A row's status (`pending` → `syncing`
   → `synced` / `failed`) is persisted in SQLite, not held in memory. An
   app kill mid-sync leaves a `syncing` row that the next launch correctly
   treats as *not yet confirmed* and retries — and the fake backend's own
   idempotency ledger (`FakeNovaPayApi._processedSendKeys` /
   `_processedContributionKeys`, keyed the same way a real backend's
   idempotency-key handling would be) means even that retry can't debit
   twice. This is the two-line-of-defence story `integration_test/
   offline_queue_sync_test.dart` exercises directly, restarting the
   `AppDatabase`/`SyncQueueService` against the same on-disk SQLite file.
4. **A dropped connection re-queues, it doesn't retry in a loop.** Every
   backend call races against a `ConnectivityService.onStatusChange`
   event firing `false` (`SyncQueueService._raceConnectivityLoss`), so
   toggling airplane mode *mid-request* behaves like a genuinely dropped
   request. That failure sets the row back to `pending` and stops the
   *whole* drain pass — it waits for the next explicit trigger (reconnect,
   a new item queued, app start, or a 30s reconciliation tick) instead of
   spinning.
5. **A business failure backs off, then gives up loudly.** A simulated
   NIP/server error burns a retry attempt and sets `nextRetryAt` with
   exponential backoff (`2^attempts` seconds); after `maxSyncAttempts` (5)
   the row becomes terminally `failed` and surfaces a manual "Retry" in
   the transaction list / goal card instead of retrying forever.
   Insufficient-funds / goal-not-found failures go straight to `failed` —
   retrying without the user doing something about it (topping up) can't
   help.
6. **Online sends still settle fast.** `SyncQueueService.start()` also
   subscribes to `AppDatabase.watchQueue()` and drains on every queue
   change (in addition to connectivity transitions and the periodic
   tick) — otherwise a send made while already online would sit `pending`
   for up to 30 seconds waiting for the reconciliation timer. This is the
   one bug I found in my own design while writing `test/unit/
   sync_queue_service_test.dart` — see `AI_USAGE.md`.

**Displayed balance / goal progress is a pure derived value, never an
optimistic mutation.** `WalletRepository.watch()` combines the confirmed
wallet cache row with the *live* queue (`Rx.combineLatest3`) and computes
`displayBalanceKobo = confirmed - sum(pending sends)` fresh on every
emission — same pattern in `SaveRepository` for goal progress. The moment
a queued row flips to `synced`, it drops out of the "pending" sum in the
same instant `WalletRepository.refresh()` (triggered by `SyncQueueService.
onActionSynced`, wired in the DI composition root) updates the confirmed
cache with the new server balance. There is no code path where a
contribution can be counted twice, because it's never counted *in place* —
it's recomputed from the two sources of truth every time either changes.

### Navigation — `go_router`

Four routes (`/`, `/send`, `/save/create`, `/save/:goalId`) plus a local
`IndexedStack` for the Wallet/NovaSave bottom-tab shell (`core/shell/
app_shell.dart`) — a `StatefulShellRoute` wasn't worth the extra
complexity for two tabs on this timeline.

## Hard constraints — how each is met

| Constraint | Where |
|---|---|
| Kobo-integer money, no float drift | `core/money/money.dart`, `money_input_parser.dart` |
| Queue survives restart, no double-send | `AppDatabase` (SQLite-backed), `SyncQueueService`, `integration_test/offline_queue_sync_test.dart` |
| Accessible with a screen reader | `Semantics` on balance, transaction rows, step indicators, buttons, date picker, progress bar (`core/widgets/*`, screen files) |
| Font-scale doesn't break layout | Balance figure wrapped in `FittedBox`; flexible `Row`/`Column`/`Flexible` layouts, no fixed-height text containers |
| `ListView.builder` for large lists | `SliverList.builder` on the transaction list and goal list |
| No sensitive data in plain `SharedPreferences` | `SecureSessionStore` (`flutter_secure_storage`, AES-GCM + RSA-OAEP key wrapping by default in v11) |

## Stretch goals attempted

Per the brief's own framing ("intentionally more than can be gold-plated"),
these were prioritised over golden tests / a biometric stub, which were
cut:

- **Local notification on sync** — `LocalNotificationService`, fired from
  `SyncQueueService.onActionSynced` (wired in the DI composition root).
  Demoable: queue a send offline, background the app, reconnect, see the
  notification.
- **Localization scaffold (English + Yoruba)** — `lib/core/l10n/
  app_en.arb` / `app_yo.arb`, wired into `MaterialApp.router` and used
  throughout the Send Money screen (step titles, field labels, buttons,
  the pending/sent outcome text). NovaSave and the wallet home screen are
  still English-only, as scoped.

## Trade-offs & documented assumptions

- **Goal creation is not queued offline.** Only Send and Contribute are
  called out in the brief's offline-behaviour row, and creating a goal
  moves no money — it writes straight to the local cache (always
  available) and best-effort mirrors to the fake backend. A real backend
  would need this queued too if goal IDs had to be server-assigned before
  a contribution could reference them; the fake backend accepts
  client-generated UUIDs, so this doesn't bite here.
- **`AmountField` truncates a third decimal digit rather than rejecting
  it** (documented on `parseNairaInputToKobo`) — simplest reasonable
  behaviour for a numeric keypad; a banking-grade input would likely
  reject instead.
- **`very_good_analysis`'s `public_member_api_docs` and
  `lines_longer_than_80_chars` are disabled** (see `analysis_options.
  yaml`) — mandatory dartdoc on every public getter produces boilerplate,
  not clarity, and directly conflicts with commenting only the non-obvious
  *why*; the 80-column wrap was traded for readable named-parameter call
  sites. Every other `very_good_analysis` rule is left on, including
  `avoid_catches_without_on_clauses` and `cancel_subscriptions`, both of
  which caught real things while building this (see `AI_USAGE.md`).
- **No biometric-confirmation stub, no golden tests.** Cut in favour of
  the two stretch goals above, per explicit scope prioritisation early in
  the build.
- **`SyncQueueService`'s reconciliation tick is 30 seconds.** A safety net
  for a business-failure backoff window elapsing while the device stays
  online the whole time (no reconnect transition to trigger a drain
  otherwise) — chosen as "coarse enough to never look like polling,
  frequent enough nothing waits long."

## Test rigor

- **Unit (`test/unit/`, 21 tests):** `Money`/`parseNairaInputToKobo`
  (float-drift cases), and `SyncQueueService` in isolation — exactly-once
  replay, double-enqueue dedup, offline/reconnect, a connectivity drop
  *mid-request*, business-failure backoff to a terminal `failed` state,
  and two concurrent `drain()` calls racing on the same row.
- **Widget (`test/widget/`, 6 tests):** the Send Money and NovaSave
  contribution flows end to end against a real in-memory `AppDatabase` and
  zero-latency `FakeNovaPayApi` — happy path, validation, and the offline
  outcome message. Deliberately *don't* run a live `SyncQueueService`
  inside these (see the comment at the top of `send_money_flow_test.dart`
  for why — a live Drift `.watch()` stream left open for the test body
  prevents the widget-test harness from finalising cleanly).
- **Integration (`integration_test/`, 2 tests):** the actual offline-queue-
  then-restart-then-sync scenario against a real on-disk SQLite file and a
  real Android emulator — this is the test that would catch a regression
  in the exactly-once guarantee that unit tests, working against a fresh
  in-memory DB each time, structurally can't.
