# AI usage

This app was built end-to-end in a pair-programming session with **Claude
(Claude Code, Sonnet 4.5, later Sonnet 5)**, from architecture through
implementation, testing, and this document. Used for: reading the brief
(including the PDF), architecture decisions (with sign-off sought before
each one — see below), writing all Dart source and tests, debugging
failing test runs, a self-review pass against a written list of
corrections after an initial build, and researching current package APIs
against a January 2026 knowledge cutoff for a September 2026 build
(several packages had shipped breaking changes since).

## A structured correction pass, not just one build

After the initial build, I wrote a plain-text list of 10 concrete
corrections — things the first pass got wrong or
under-built: transaction pagination instead of a fixed last-10 list,
connectivity that only counts mobile/Wi-Fi as "online" (the initial
`connectivity_plus` wrapper treated *any* non-`none` result as online),
live currency-formatted amount entry, a persisted language setting,
replacing `dart_mappable` with plain `Equatable` classes now that no
model does its own JSON parsing, removing `StatefulWidget` wrapper
classes that existed only to host a `BlocSignalProvider`. I
had Claude work through the list item by item rather than accepting a
single "done" — for each one I checked the actual diff, not just the
claim, which is how the currency-formatter regression below was caught.

## Concrete prompts and what came back

**1. "How should the offline queue persist locally?"** — Claude's first
instinct was Hive. I said Hive is too old; it researched current
maintenance status, found Hive and Isar are both community-maintained
forks of abandoned projects, and came back recommending Drift (SQLite,
actively maintained, gives a DB-level `UNIQUE` constraint for the
idempotency-key guarantee). That became the actual design.

**2. "use get_it for DI and move everything in app/ to core/"** — a
mid-build architecture change. Claude re-homed the composition root
(`AppServices` class → `core/di/service_locator.dart` using `get_it`
singletons), the router, and the bottom-tab shell into `core/`, and
updated every screen that had been threading a services object through
constructors to call `getIt<T>()` directly instead — a net simplification
(several constructors lost a required parameter) rather than pure
churn.

**3. "Widget tests for Send Money and Contribute" — debugging a hung test
run.** `flutter test` on the first widget test hung indefinitely with no
output. Claude bisected it methodically: isolated the exact tapped
sequence with print-instrumented copies, found the test *body* completed
every assertion but the test harness never reported completion, then
proved the specific cause — `db.watchQueue().first` (opening a live Drift
`.watch()` stream inside `testWidgets`, even just to await its first
value) leaves something that the widget-test harness's finalisation
checks can't get past — by swapping it for a one-shot query
(`AppDatabase.allQueuedActions()`, added for exactly this) and watching
the same test go from a 60-second hang to instant. That fix is now the
documented pattern across all three widget test files.

**4. "I think you should use the currency_text_input_formatter package
instead."** — Claude's first live-formatting attempt was a hand-rolled
`_KoboInputFormatter` that assumed `TextEditingController` edits are
always an incremental single-character append, which broke under
`tester.enterText` (bulk replacement, not incremental typing) in the
widget tests. I pushed back and asked for the package instead of a
second hand-rolled fix. Claude researched the package's own source before
wiring it in, found `getUnformattedValue()`/`getDouble()` both divide by
a power of 10 and hand back a `double` — exactly the float-drift risk
this app is built to avoid — and instead derived the kobo value from the
formatter's own *formatted display string*, re-parsed through the
existing pure-integer `parseNairaInputToKobo()`. That decision is
documented on `AmountField` itself, not just here.

## A case where AI output was wrong, and how I caught it

While wiring up `bloc_signals_flutter` (the state-management package
specified for this project), I fetched its README to learn the
`BuildContext` extension API and got back a plausible-looking usage
example:

> "Subscribe to full state emissions... `final count = context.
> watch<CounterCubit>();`"

I built every screen around that — `context.watch<WalletCubit>()`
returning the *state* directly. It compiled fine for a while, but running
`flutter analyze` after wiring the last screen surfaced real type errors:
`The getter 'outcome' isn't defined for the type 'SendMoneyCubit'`. The
summarised doc was wrong (or I'd over-trusted a paraphrase of it): I went
and read the actual installed package source
(`~/.pub-cache/.../bloc_signal_provider.dart`) and found `context.
watch<T>()` returns the **cubit itself** (still correctly registers a
rebuild dependency, just hands back the container, not its value) — the
call that actually returns the state on rebuild is `context.value<T,
S>()`, a different method with two type parameters. I fixed every
callsite across the wallet and save modules to use `context.value<Cubit,
State>()`.

The reason this is a "risky if unchecked" category of AI mistake, not just
a fixable typo: it compiled and ran until the very last screen was wired,
so a less careful pass — or one that stopped at "the analyzer's clean now"
without re-reading the actual behaviour — could easily have shipped it if
`WalletCubit`'s state and the cubit type happened to expose similarly-named
fields by coincidence. The fix: never trust a fetched summary of a
package's API surface for anything load-bearing — verify against the
installed source once real usage starts producing errors, and prefer
reading generated/source code directly over a WebFetch paraphrase when the
package is niche enough that little else has been written about it (this
one was days old on pub.dev at the time).

## A design risk I deliberately checked myself, not just AI-generated

The brief specifically calls out "an offline-queue design that can replay
an action twice" as a common AI-generated risk. The design that's actually
in this repo avoids the most common version of that bug — *minting a new
idempotency key on every retry* — by generating the key exactly once, at
the moment the user taps confirm (`SendMoneyCubit.submit()` /
`ContributeCubit.submit()`), and persisting the same `QueuedAction`
(key included) for every subsequent replay attempt. I stress-tested this
specifically rather than assuming it: `test/unit/
sync_queue_service_test.dart` has a case that races two concurrent
`drain()` calls against the same row, and `integration_test/
offline_queue_sync_test.dart` kills and restarts the `AppDatabase`/
`SyncQueueService` mid-flow against the same on-disk file to prove a
restart can't cause a double-send either. Both pass — but the point of
listing this here is that "the AI's queue design might replay twice" isn't
a hypothetical for this codebase, it's the specific failure mode the test
suite was built to catch, because it's exactly the risk this document is
asking about.
