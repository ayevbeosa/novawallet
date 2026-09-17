import 'dart:math';

import 'package:novawallet/core/backend/novapay_exceptions.dart';
import 'package:novawallet/core/sync/queued_action.dart';
import 'package:novawallet/modules/save/data/models/savings_goal.dart';
import 'package:novawallet/modules/wallet/data/models/transaction_entry.dart';
import 'package:novawallet/modules/wallet/data/models/wallet_snapshot.dart';

/// Stands in for the real NovaPay backend (NIBSS NIP rails, NovaSave
/// ledger). No real network calls happen here.
///
/// Two things a real backend would do that this fake also does, because
/// they are exactly what makes the offline-queue replay safe:
/// 1. Simulated latency + an injectable failure rate, so the sync queue's
///    retry/backoff path is exercisable without touching real infra.
/// 2. Its own idempotency-key ledger (`_processedSendKeys` /
///    `_processedContributionKeys`) — a second line of defence. Even if a
///    bug somehow replayed the same action twice from the client, this
///    fake backend recognises the key and returns the original result
///    instead of debiting the wallet a second time.
class FakeNovaPayApi {
  FakeNovaPayApi({
    this.simulatedLatency = const Duration(milliseconds: 700),
    this.failureRate = 0.0,
    Random? random,
  }) : _random = random ?? Random() {
    _seed();
  }

  Duration simulatedLatency;

  /// Probability (0..1) that a submit call throws [NovaPayServerException]
  /// after "reaching" the server — simulates a NIP settlement hiccup while
  /// the device is online, distinct from being offline outright.
  double failureRate;

  final Random _random;

  late int _balance;
  late final String accountNumber;
  late final String ownerName;
  final List<TransactionEntry> _transactions = [];
  final Map<String, SavingsGoal> _goals = {};
  final Map<String, TransactionEntry> _processedSendKeys = {};
  final Map<String, SavingsGoal> _processedContributionKeys = {};

  void _seed() {
    accountNumber = '2103457821';
    ownerName = 'Ayevbeosa Iyamu';
    _balance = 18234050; // ₦182,340.50
    final now = DateTime.now();
    _transactions.addAll([
      TransactionEntry(
        id: 'seed-1',
        transactionType: TransactionType.credit,
        beneficiary: 'Diaspora remittance — UK',
        amount: 8500000,
        createdAt: now.subtract(const Duration(hours: 3)),
        status: TransactionStatus.completed,
        narration: 'Inbound NIP transfer',
      ),
      TransactionEntry(
        id: 'seed-2',
        transactionType: TransactionType.debit,
        beneficiary: 'Ikeja Electric — bill payment',
        amount: 1250000,
        createdAt: now.subtract(const Duration(hours: 9)),
        status: TransactionStatus.completed,
      ),
      TransactionEntry(
        id: 'seed-3',
        transactionType: TransactionType.debit,
        beneficiary: 'Chidinma Okafor',
        amount: 500000,
        createdAt: now.subtract(const Duration(days: 1, hours: 2)),
        status: TransactionStatus.completed,
        narration: 'P2P transfer',
      ),
      TransactionEntry(
        id: 'seed-4',
        transactionType: TransactionType.debit,
        beneficiary: 'MTN — airtime top-up',
        amount: 200000,
        createdAt: now.subtract(const Duration(days: 2)),
        status: TransactionStatus.completed,
      ),
      TransactionEntry(
        id: 'seed-5',
        transactionType: TransactionType.credit,
        beneficiary: 'NovaBiz settlement — Iyamu Stores',
        amount: 3400000,
        createdAt: now.subtract(const Duration(days: 3, hours: 5)),
        status: TransactionStatus.completed,
      ),
    ]);
    _goals['goal-1'] = SavingsGoal(
      id: 'goal-1',
      name: 'Japa fund',
      targetAmount: 250000000,
      savedAmount: 92500000,
      targetDate: now.add(const Duration(days: 200)),
      createdAt: now.subtract(const Duration(days: 40)),
    );
    _goals['goal-2'] = SavingsGoal(
      id: 'goal-2',
      name: 'New generator',
      targetAmount: 45000000,
      savedAmount: 12000000,
      targetDate: now.add(const Duration(days: 60)),
      createdAt: now.subtract(const Duration(days: 15)),
    );
  }

  Future<WalletSnapshot> fetchWallet() async {
    await _delay();
    return WalletSnapshot(
      balance: _balance,
      accountNumber: accountNumber,
      accountName: ownerName,
      updatedAt: DateTime.now(),
    );
  }

  Future<List<TransactionEntry>> fetchTransactions() async {
    await _delay();
    final sorted = [..._transactions]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  Future<List<SavingsGoal>> fetchGoals() async {
    await _delay();
    return _goals.values.toList();
  }

  Future<SavingsGoal> createGoal(SavingsGoal goal) async {
    await _delay();
    _goals[goal.id] = goal;
    return goal;
  }

  /// Idempotent: replaying the same [SendMoneyAction.idempotencyKey] returns
  /// the original result instead of debiting the wallet again.
  Future<TransactionEntry> submitSendMoney(SendMoneyAction action) async {
    await _delay();
    final cached = _processedSendKeys[action.idempotencyKey];
    if (cached != null) return cached;

    _maybeThrowServerError();

    if (action.amount > _balance) throw InsufficientFundsException();

    _balance -= action.amount;
    final tx = TransactionEntry(
      id: action.idempotencyKey,
      transactionType: TransactionType.debit,
      beneficiary: action.recipient,
      amount: action.amount,
      createdAt: DateTime.now(),
      status: TransactionStatus.completed,
      narration: action.narration,
    );
    _transactions.insert(0, tx);
    _processedSendKeys[action.idempotencyKey] = tx;
    return tx;
  }

  /// Idempotent for the same reason as [submitSendMoney].
  Future<SavingsGoal> submitContribution(ContributeGoalAction action) async {
    await _delay();
    final cached = _processedContributionKeys[action.idempotencyKey];
    if (cached != null) return cached;

    _maybeThrowServerError();

    final goal = _goals[action.goalId];
    if (goal == null) throw GoalNotFoundException();
    if (action.amount > _balance) throw InsufficientFundsException();

    _balance -= action.amount;
    final tx = TransactionEntry(
      id: action.idempotencyKey,
      transactionType: TransactionType.debit,
      beneficiary: 'NovaSave — ${action.goalName}',
      amount: action.amount,
      createdAt: DateTime.now(),
      status: TransactionStatus.completed,
      narration: 'Savings contribution',
    );
    _transactions.insert(0, tx);

    final updated = goal.copyWith(savedAmount: goal.savedAmount + action.amount);
    _goals[action.goalId] = updated;
    _processedContributionKeys[action.idempotencyKey] = updated;
    return updated;
  }

  void _maybeThrowServerError() {
    if (failureRate > 0 && _random.nextDouble() < failureRate) {
      throw NovaPayServerException('Simulated NIP settlement timeout');
    }
  }

  Future<void> _delay() {
    if (simulatedLatency == Duration.zero) return Future.value();
    return Future.delayed(simulatedLatency);
  }
}
