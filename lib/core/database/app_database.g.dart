// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $QueuedActionRowsTable extends QueuedActionRows
    with TableInfo<$QueuedActionRowsTable, QueuedActionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QueuedActionRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionTypeMeta = const VerificationMeta(
    'actionType',
  );
  @override
  late final GeneratedColumn<String> actionType = GeneratedColumn<String>(
    'action_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipientMeta = const VerificationMeta(
    'recipient',
  );
  @override
  late final GeneratedColumn<String> recipient = GeneratedColumn<String>(
    'recipient',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _narrationMeta = const VerificationMeta(
    'narration',
  );
  @override
  late final GeneratedColumn<String> narration = GeneratedColumn<String>(
    'narration',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalNameMeta = const VerificationMeta(
    'goalName',
  );
  @override
  late final GeneratedColumn<String> goalName = GeneratedColumn<String>(
    'goal_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextRetryAtMeta = const VerificationMeta(
    'nextRetryAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextRetryAt = GeneratedColumn<DateTime>(
    'next_retry_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idempotencyKey,
    actionType,
    recipient,
    narration,
    goalId,
    goalName,
    amount,
    status,
    attempts,
    createdAt,
    lastAttemptAt,
    nextRetryAt,
    errorMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'queued_action_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<QueuedActionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('action_type')) {
      context.handle(
        _actionTypeMeta,
        actionType.isAcceptableOrUnknown(data['action_type']!, _actionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_actionTypeMeta);
    }
    if (data.containsKey('recipient')) {
      context.handle(
        _recipientMeta,
        recipient.isAcceptableOrUnknown(data['recipient']!, _recipientMeta),
      );
    }
    if (data.containsKey('narration')) {
      context.handle(
        _narrationMeta,
        narration.isAcceptableOrUnknown(data['narration']!, _narrationMeta),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('goal_name')) {
      context.handle(
        _goalNameMeta,
        goalName.isAcceptableOrUnknown(data['goal_name']!, _goalNameMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('next_retry_at')) {
      context.handle(
        _nextRetryAtMeta,
        nextRetryAt.isAcceptableOrUnknown(
          data['next_retry_at']!,
          _nextRetryAtMeta,
        ),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idempotencyKey};
  @override
  QueuedActionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QueuedActionRow(
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      actionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_type'],
      )!,
      recipient: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient'],
      ),
      narration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}narration'],
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      goalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_name'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      nextRetryAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_retry_at'],
      ),
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
    );
  }

  @override
  $QueuedActionRowsTable createAlias(String alias) {
    return $QueuedActionRowsTable(attachedDatabase, alias);
  }
}

class QueuedActionRow extends DataClass implements Insertable<QueuedActionRow> {
  final String idempotencyKey;
  final String actionType;
  final String? recipient;
  final String? narration;
  final String? goalId;
  final String? goalName;
  final int amount;
  final String status;
  final int attempts;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  final DateTime? nextRetryAt;
  final String? errorMessage;
  const QueuedActionRow({
    required this.idempotencyKey,
    required this.actionType,
    this.recipient,
    this.narration,
    this.goalId,
    this.goalName,
    required this.amount,
    required this.status,
    required this.attempts,
    required this.createdAt,
    this.lastAttemptAt,
    this.nextRetryAt,
    this.errorMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['action_type'] = Variable<String>(actionType);
    if (!nullToAbsent || recipient != null) {
      map['recipient'] = Variable<String>(recipient);
    }
    if (!nullToAbsent || narration != null) {
      map['narration'] = Variable<String>(narration);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    if (!nullToAbsent || goalName != null) {
      map['goal_name'] = Variable<String>(goalName);
    }
    map['amount'] = Variable<int>(amount);
    map['status'] = Variable<String>(status);
    map['attempts'] = Variable<int>(attempts);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || nextRetryAt != null) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  QueuedActionRowsCompanion toCompanion(bool nullToAbsent) {
    return QueuedActionRowsCompanion(
      idempotencyKey: Value(idempotencyKey),
      actionType: Value(actionType),
      recipient: recipient == null && nullToAbsent
          ? const Value.absent()
          : Value(recipient),
      narration: narration == null && nullToAbsent
          ? const Value.absent()
          : Value(narration),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      goalName: goalName == null && nullToAbsent
          ? const Value.absent()
          : Value(goalName),
      amount: Value(amount),
      status: Value(status),
      attempts: Value(attempts),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      nextRetryAt: nextRetryAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextRetryAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory QueuedActionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QueuedActionRow(
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      actionType: serializer.fromJson<String>(json['actionType']),
      recipient: serializer.fromJson<String?>(json['recipient']),
      narration: serializer.fromJson<String?>(json['narration']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      goalName: serializer.fromJson<String?>(json['goalName']),
      amount: serializer.fromJson<int>(json['amount']),
      status: serializer.fromJson<String>(json['status']),
      attempts: serializer.fromJson<int>(json['attempts']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      nextRetryAt: serializer.fromJson<DateTime?>(json['nextRetryAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'actionType': serializer.toJson<String>(actionType),
      'recipient': serializer.toJson<String?>(recipient),
      'narration': serializer.toJson<String?>(narration),
      'goalId': serializer.toJson<String?>(goalId),
      'goalName': serializer.toJson<String?>(goalName),
      'amount': serializer.toJson<int>(amount),
      'status': serializer.toJson<String>(status),
      'attempts': serializer.toJson<int>(attempts),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'nextRetryAt': serializer.toJson<DateTime?>(nextRetryAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  QueuedActionRow copyWith({
    String? idempotencyKey,
    String? actionType,
    Value<String?> recipient = const Value.absent(),
    Value<String?> narration = const Value.absent(),
    Value<String?> goalId = const Value.absent(),
    Value<String?> goalName = const Value.absent(),
    int? amount,
    String? status,
    int? attempts,
    DateTime? createdAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<DateTime?> nextRetryAt = const Value.absent(),
    Value<String?> errorMessage = const Value.absent(),
  }) => QueuedActionRow(
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    actionType: actionType ?? this.actionType,
    recipient: recipient.present ? recipient.value : this.recipient,
    narration: narration.present ? narration.value : this.narration,
    goalId: goalId.present ? goalId.value : this.goalId,
    goalName: goalName.present ? goalName.value : this.goalName,
    amount: amount ?? this.amount,
    status: status ?? this.status,
    attempts: attempts ?? this.attempts,
    createdAt: createdAt ?? this.createdAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    nextRetryAt: nextRetryAt.present ? nextRetryAt.value : this.nextRetryAt,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
  );
  QueuedActionRow copyWithCompanion(QueuedActionRowsCompanion data) {
    return QueuedActionRow(
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      actionType: data.actionType.present
          ? data.actionType.value
          : this.actionType,
      recipient: data.recipient.present ? data.recipient.value : this.recipient,
      narration: data.narration.present ? data.narration.value : this.narration,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      goalName: data.goalName.present ? data.goalName.value : this.goalName,
      amount: data.amount.present ? data.amount.value : this.amount,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      nextRetryAt: data.nextRetryAt.present
          ? data.nextRetryAt.value
          : this.nextRetryAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QueuedActionRow(')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('actionType: $actionType, ')
          ..write('recipient: $recipient, ')
          ..write('narration: $narration, ')
          ..write('goalId: $goalId, ')
          ..write('goalName: $goalName, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idempotencyKey,
    actionType,
    recipient,
    narration,
    goalId,
    goalName,
    amount,
    status,
    attempts,
    createdAt,
    lastAttemptAt,
    nextRetryAt,
    errorMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QueuedActionRow &&
          other.idempotencyKey == this.idempotencyKey &&
          other.actionType == this.actionType &&
          other.recipient == this.recipient &&
          other.narration == this.narration &&
          other.goalId == this.goalId &&
          other.goalName == this.goalName &&
          other.amount == this.amount &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.nextRetryAt == this.nextRetryAt &&
          other.errorMessage == this.errorMessage);
}

class QueuedActionRowsCompanion extends UpdateCompanion<QueuedActionRow> {
  final Value<String> idempotencyKey;
  final Value<String> actionType;
  final Value<String?> recipient;
  final Value<String?> narration;
  final Value<String?> goalId;
  final Value<String?> goalName;
  final Value<int> amount;
  final Value<String> status;
  final Value<int> attempts;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime?> nextRetryAt;
  final Value<String?> errorMessage;
  final Value<int> rowid;
  const QueuedActionRowsCompanion({
    this.idempotencyKey = const Value.absent(),
    this.actionType = const Value.absent(),
    this.recipient = const Value.absent(),
    this.narration = const Value.absent(),
    this.goalId = const Value.absent(),
    this.goalName = const Value.absent(),
    this.amount = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QueuedActionRowsCompanion.insert({
    required String idempotencyKey,
    required String actionType,
    this.recipient = const Value.absent(),
    this.narration = const Value.absent(),
    this.goalId = const Value.absent(),
    this.goalName = const Value.absent(),
    required int amount,
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    required DateTime createdAt,
    this.lastAttemptAt = const Value.absent(),
    this.nextRetryAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : idempotencyKey = Value(idempotencyKey),
       actionType = Value(actionType),
       amount = Value(amount),
       createdAt = Value(createdAt);
  static Insertable<QueuedActionRow> custom({
    Expression<String>? idempotencyKey,
    Expression<String>? actionType,
    Expression<String>? recipient,
    Expression<String>? narration,
    Expression<String>? goalId,
    Expression<String>? goalName,
    Expression<int>? amount,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? nextRetryAt,
    Expression<String>? errorMessage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (actionType != null) 'action_type': actionType,
      if (recipient != null) 'recipient': recipient,
      if (narration != null) 'narration': narration,
      if (goalId != null) 'goal_id': goalId,
      if (goalName != null) 'goal_name': goalName,
      if (amount != null) 'amount': amount,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (nextRetryAt != null) 'next_retry_at': nextRetryAt,
      if (errorMessage != null) 'error_message': errorMessage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QueuedActionRowsCompanion copyWith({
    Value<String>? idempotencyKey,
    Value<String>? actionType,
    Value<String?>? recipient,
    Value<String?>? narration,
    Value<String?>? goalId,
    Value<String?>? goalName,
    Value<int>? amount,
    Value<String>? status,
    Value<int>? attempts,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime?>? nextRetryAt,
    Value<String?>? errorMessage,
    Value<int>? rowid,
  }) {
    return QueuedActionRowsCompanion(
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      actionType: actionType ?? this.actionType,
      recipient: recipient ?? this.recipient,
      narration: narration ?? this.narration,
      goalId: goalId ?? this.goalId,
      goalName: goalName ?? this.goalName,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      errorMessage: errorMessage ?? this.errorMessage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<String>(actionType.value);
    }
    if (recipient.present) {
      map['recipient'] = Variable<String>(recipient.value);
    }
    if (narration.present) {
      map['narration'] = Variable<String>(narration.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (goalName.present) {
      map['goal_name'] = Variable<String>(goalName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (nextRetryAt.present) {
      map['next_retry_at'] = Variable<DateTime>(nextRetryAt.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueuedActionRowsCompanion(')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('actionType: $actionType, ')
          ..write('recipient: $recipient, ')
          ..write('narration: $narration, ')
          ..write('goalId: $goalId, ')
          ..write('goalName: $goalName, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('nextRetryAt: $nextRetryAt, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedTransactionRowsTable extends CachedTransactionRows
    with TableInfo<$CachedTransactionRowsTable, CachedTransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedTransactionRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _counterpartyMeta = const VerificationMeta(
    'counterparty',
  );
  @override
  late final GeneratedColumn<String> counterparty = GeneratedColumn<String>(
    'counterparty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountKoboMeta = const VerificationMeta(
    'amountKobo',
  );
  @override
  late final GeneratedColumn<int> amountKobo = GeneratedColumn<int>(
    'amount_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    direction,
    counterparty,
    amountKobo,
    createdAt,
    status,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_transaction_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedTransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('counterparty')) {
      context.handle(
        _counterpartyMeta,
        counterparty.isAcceptableOrUnknown(
          data['counterparty']!,
          _counterpartyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_counterpartyMeta);
    }
    if (data.containsKey('amount_kobo')) {
      context.handle(
        _amountKoboMeta,
        amountKobo.isAcceptableOrUnknown(data['amount_kobo']!, _amountKoboMeta),
      );
    } else if (isInserting) {
      context.missing(_amountKoboMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedTransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedTransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      counterparty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}counterparty'],
      )!,
      amountKobo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_kobo'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $CachedTransactionRowsTable createAlias(String alias) {
    return $CachedTransactionRowsTable(attachedDatabase, alias);
  }
}

class CachedTransactionRow extends DataClass
    implements Insertable<CachedTransactionRow> {
  final String id;
  final String direction;
  final String counterparty;
  final int amountKobo;
  final DateTime createdAt;
  final String status;
  final String? note;
  const CachedTransactionRow({
    required this.id,
    required this.direction,
    required this.counterparty,
    required this.amountKobo,
    required this.createdAt,
    required this.status,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['direction'] = Variable<String>(direction);
    map['counterparty'] = Variable<String>(counterparty);
    map['amount_kobo'] = Variable<int>(amountKobo);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  CachedTransactionRowsCompanion toCompanion(bool nullToAbsent) {
    return CachedTransactionRowsCompanion(
      id: Value(id),
      direction: Value(direction),
      counterparty: Value(counterparty),
      amountKobo: Value(amountKobo),
      createdAt: Value(createdAt),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory CachedTransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedTransactionRow(
      id: serializer.fromJson<String>(json['id']),
      direction: serializer.fromJson<String>(json['direction']),
      counterparty: serializer.fromJson<String>(json['counterparty']),
      amountKobo: serializer.fromJson<int>(json['amountKobo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'direction': serializer.toJson<String>(direction),
      'counterparty': serializer.toJson<String>(counterparty),
      'amountKobo': serializer.toJson<int>(amountKobo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
    };
  }

  CachedTransactionRow copyWith({
    String? id,
    String? direction,
    String? counterparty,
    int? amountKobo,
    DateTime? createdAt,
    String? status,
    Value<String?> note = const Value.absent(),
  }) => CachedTransactionRow(
    id: id ?? this.id,
    direction: direction ?? this.direction,
    counterparty: counterparty ?? this.counterparty,
    amountKobo: amountKobo ?? this.amountKobo,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
  );
  CachedTransactionRow copyWithCompanion(CachedTransactionRowsCompanion data) {
    return CachedTransactionRow(
      id: data.id.present ? data.id.value : this.id,
      direction: data.direction.present ? data.direction.value : this.direction,
      counterparty: data.counterparty.present
          ? data.counterparty.value
          : this.counterparty,
      amountKobo: data.amountKobo.present
          ? data.amountKobo.value
          : this.amountKobo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedTransactionRow(')
          ..write('id: $id, ')
          ..write('direction: $direction, ')
          ..write('counterparty: $counterparty, ')
          ..write('amountKobo: $amountKobo, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    direction,
    counterparty,
    amountKobo,
    createdAt,
    status,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedTransactionRow &&
          other.id == this.id &&
          other.direction == this.direction &&
          other.counterparty == this.counterparty &&
          other.amountKobo == this.amountKobo &&
          other.createdAt == this.createdAt &&
          other.status == this.status &&
          other.note == this.note);
}

class CachedTransactionRowsCompanion
    extends UpdateCompanion<CachedTransactionRow> {
  final Value<String> id;
  final Value<String> direction;
  final Value<String> counterparty;
  final Value<int> amountKobo;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<String?> note;
  final Value<int> rowid;
  const CachedTransactionRowsCompanion({
    this.id = const Value.absent(),
    this.direction = const Value.absent(),
    this.counterparty = const Value.absent(),
    this.amountKobo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedTransactionRowsCompanion.insert({
    required String id,
    required String direction,
    required String counterparty,
    required int amountKobo,
    required DateTime createdAt,
    required String status,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       direction = Value(direction),
       counterparty = Value(counterparty),
       amountKobo = Value(amountKobo),
       createdAt = Value(createdAt),
       status = Value(status);
  static Insertable<CachedTransactionRow> custom({
    Expression<String>? id,
    Expression<String>? direction,
    Expression<String>? counterparty,
    Expression<int>? amountKobo,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (direction != null) 'direction': direction,
      if (counterparty != null) 'counterparty': counterparty,
      if (amountKobo != null) 'amount_kobo': amountKobo,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedTransactionRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? direction,
    Value<String>? counterparty,
    Value<int>? amountKobo,
    Value<DateTime>? createdAt,
    Value<String>? status,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return CachedTransactionRowsCompanion(
      id: id ?? this.id,
      direction: direction ?? this.direction,
      counterparty: counterparty ?? this.counterparty,
      amountKobo: amountKobo ?? this.amountKobo,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (counterparty.present) {
      map['counterparty'] = Variable<String>(counterparty.value);
    }
    if (amountKobo.present) {
      map['amount_kobo'] = Variable<int>(amountKobo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedTransactionRowsCompanion(')
          ..write('id: $id, ')
          ..write('direction: $direction, ')
          ..write('counterparty: $counterparty, ')
          ..write('amountKobo: $amountKobo, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WalletCacheRowsTable extends WalletCacheRows
    with TableInfo<$WalletCacheRowsTable, WalletCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletCacheRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceKoboMeta = const VerificationMeta(
    'balanceKobo',
  );
  @override
  late final GeneratedColumn<int> balanceKobo = GeneratedColumn<int>(
    'balance_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountNumberMeta = const VerificationMeta(
    'accountNumber',
  );
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
    'account_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerNameMeta = const VerificationMeta(
    'ownerName',
  );
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
    'owner_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    balanceKobo,
    accountNumber,
    ownerName,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallet_cache_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalletCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('balance_kobo')) {
      context.handle(
        _balanceKoboMeta,
        balanceKobo.isAcceptableOrUnknown(
          data['balance_kobo']!,
          _balanceKoboMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_balanceKoboMeta);
    }
    if (data.containsKey('account_number')) {
      context.handle(
        _accountNumberMeta,
        accountNumber.isAcceptableOrUnknown(
          data['account_number']!,
          _accountNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountNumberMeta);
    }
    if (data.containsKey('owner_name')) {
      context.handle(
        _ownerNameMeta,
        ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerNameMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalletCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalletCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      balanceKobo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_kobo'],
      )!,
      accountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_number'],
      )!,
      ownerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_name'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WalletCacheRowsTable createAlias(String alias) {
    return $WalletCacheRowsTable(attachedDatabase, alias);
  }
}

class WalletCacheRow extends DataClass implements Insertable<WalletCacheRow> {
  final int id;
  final int balanceKobo;
  final String accountNumber;
  final String ownerName;
  final DateTime updatedAt;
  const WalletCacheRow({
    required this.id,
    required this.balanceKobo,
    required this.accountNumber,
    required this.ownerName,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['balance_kobo'] = Variable<int>(balanceKobo);
    map['account_number'] = Variable<String>(accountNumber);
    map['owner_name'] = Variable<String>(ownerName);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WalletCacheRowsCompanion toCompanion(bool nullToAbsent) {
    return WalletCacheRowsCompanion(
      id: Value(id),
      balanceKobo: Value(balanceKobo),
      accountNumber: Value(accountNumber),
      ownerName: Value(ownerName),
      updatedAt: Value(updatedAt),
    );
  }

  factory WalletCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalletCacheRow(
      id: serializer.fromJson<int>(json['id']),
      balanceKobo: serializer.fromJson<int>(json['balanceKobo']),
      accountNumber: serializer.fromJson<String>(json['accountNumber']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'balanceKobo': serializer.toJson<int>(balanceKobo),
      'accountNumber': serializer.toJson<String>(accountNumber),
      'ownerName': serializer.toJson<String>(ownerName),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WalletCacheRow copyWith({
    int? id,
    int? balanceKobo,
    String? accountNumber,
    String? ownerName,
    DateTime? updatedAt,
  }) => WalletCacheRow(
    id: id ?? this.id,
    balanceKobo: balanceKobo ?? this.balanceKobo,
    accountNumber: accountNumber ?? this.accountNumber,
    ownerName: ownerName ?? this.ownerName,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WalletCacheRow copyWithCompanion(WalletCacheRowsCompanion data) {
    return WalletCacheRow(
      id: data.id.present ? data.id.value : this.id,
      balanceKobo: data.balanceKobo.present
          ? data.balanceKobo.value
          : this.balanceKobo,
      accountNumber: data.accountNumber.present
          ? data.accountNumber.value
          : this.accountNumber,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalletCacheRow(')
          ..write('id: $id, ')
          ..write('balanceKobo: $balanceKobo, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('ownerName: $ownerName, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, balanceKobo, accountNumber, ownerName, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalletCacheRow &&
          other.id == this.id &&
          other.balanceKobo == this.balanceKobo &&
          other.accountNumber == this.accountNumber &&
          other.ownerName == this.ownerName &&
          other.updatedAt == this.updatedAt);
}

class WalletCacheRowsCompanion extends UpdateCompanion<WalletCacheRow> {
  final Value<int> id;
  final Value<int> balanceKobo;
  final Value<String> accountNumber;
  final Value<String> ownerName;
  final Value<DateTime> updatedAt;
  const WalletCacheRowsCompanion({
    this.id = const Value.absent(),
    this.balanceKobo = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WalletCacheRowsCompanion.insert({
    this.id = const Value.absent(),
    required int balanceKobo,
    required String accountNumber,
    required String ownerName,
    required DateTime updatedAt,
  }) : balanceKobo = Value(balanceKobo),
       accountNumber = Value(accountNumber),
       ownerName = Value(ownerName),
       updatedAt = Value(updatedAt);
  static Insertable<WalletCacheRow> custom({
    Expression<int>? id,
    Expression<int>? balanceKobo,
    Expression<String>? accountNumber,
    Expression<String>? ownerName,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (balanceKobo != null) 'balance_kobo': balanceKobo,
      if (accountNumber != null) 'account_number': accountNumber,
      if (ownerName != null) 'owner_name': ownerName,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WalletCacheRowsCompanion copyWith({
    Value<int>? id,
    Value<int>? balanceKobo,
    Value<String>? accountNumber,
    Value<String>? ownerName,
    Value<DateTime>? updatedAt,
  }) {
    return WalletCacheRowsCompanion(
      id: id ?? this.id,
      balanceKobo: balanceKobo ?? this.balanceKobo,
      accountNumber: accountNumber ?? this.accountNumber,
      ownerName: ownerName ?? this.ownerName,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (balanceKobo.present) {
      map['balance_kobo'] = Variable<int>(balanceKobo.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletCacheRowsCompanion(')
          ..write('id: $id, ')
          ..write('balanceKobo: $balanceKobo, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('ownerName: $ownerName, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SavingsGoalRowsTable extends SavingsGoalRows
    with TableInfo<$SavingsGoalRowsTable, SavingsGoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsGoalRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAmountKoboMeta = const VerificationMeta(
    'targetAmountKobo',
  );
  @override
  late final GeneratedColumn<int> targetAmountKobo = GeneratedColumn<int>(
    'target_amount_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAmountKoboMeta = const VerificationMeta(
    'savedAmountKobo',
  );
  @override
  late final GeneratedColumn<int> savedAmountKobo = GeneratedColumn<int>(
    'saved_amount_kobo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    targetAmountKobo,
    savedAmountKobo,
    targetDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings_goal_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavingsGoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_amount_kobo')) {
      context.handle(
        _targetAmountKoboMeta,
        targetAmountKobo.isAcceptableOrUnknown(
          data['target_amount_kobo']!,
          _targetAmountKoboMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetAmountKoboMeta);
    }
    if (data.containsKey('saved_amount_kobo')) {
      context.handle(
        _savedAmountKoboMeta,
        savedAmountKobo.isAcceptableOrUnknown(
          data['saved_amount_kobo']!,
          _savedAmountKoboMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_savedAmountKoboMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    } else if (isInserting) {
      context.missing(_targetDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavingsGoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingsGoalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      targetAmountKobo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_amount_kobo'],
      )!,
      savedAmountKobo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saved_amount_kobo'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SavingsGoalRowsTable createAlias(String alias) {
    return $SavingsGoalRowsTable(attachedDatabase, alias);
  }
}

class SavingsGoalRow extends DataClass implements Insertable<SavingsGoalRow> {
  final String id;
  final String name;
  final int targetAmountKobo;
  final int savedAmountKobo;
  final DateTime targetDate;
  final DateTime createdAt;
  const SavingsGoalRow({
    required this.id,
    required this.name,
    required this.targetAmountKobo,
    required this.savedAmountKobo,
    required this.targetDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['target_amount_kobo'] = Variable<int>(targetAmountKobo);
    map['saved_amount_kobo'] = Variable<int>(savedAmountKobo);
    map['target_date'] = Variable<DateTime>(targetDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SavingsGoalRowsCompanion toCompanion(bool nullToAbsent) {
    return SavingsGoalRowsCompanion(
      id: Value(id),
      name: Value(name),
      targetAmountKobo: Value(targetAmountKobo),
      savedAmountKobo: Value(savedAmountKobo),
      targetDate: Value(targetDate),
      createdAt: Value(createdAt),
    );
  }

  factory SavingsGoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingsGoalRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      targetAmountKobo: serializer.fromJson<int>(json['targetAmountKobo']),
      savedAmountKobo: serializer.fromJson<int>(json['savedAmountKobo']),
      targetDate: serializer.fromJson<DateTime>(json['targetDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'targetAmountKobo': serializer.toJson<int>(targetAmountKobo),
      'savedAmountKobo': serializer.toJson<int>(savedAmountKobo),
      'targetDate': serializer.toJson<DateTime>(targetDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SavingsGoalRow copyWith({
    String? id,
    String? name,
    int? targetAmountKobo,
    int? savedAmountKobo,
    DateTime? targetDate,
    DateTime? createdAt,
  }) => SavingsGoalRow(
    id: id ?? this.id,
    name: name ?? this.name,
    targetAmountKobo: targetAmountKobo ?? this.targetAmountKobo,
    savedAmountKobo: savedAmountKobo ?? this.savedAmountKobo,
    targetDate: targetDate ?? this.targetDate,
    createdAt: createdAt ?? this.createdAt,
  );
  SavingsGoalRow copyWithCompanion(SavingsGoalRowsCompanion data) {
    return SavingsGoalRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      targetAmountKobo: data.targetAmountKobo.present
          ? data.targetAmountKobo.value
          : this.targetAmountKobo,
      savedAmountKobo: data.savedAmountKobo.present
          ? data.savedAmountKobo.value
          : this.savedAmountKobo,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoalRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmountKobo: $targetAmountKobo, ')
          ..write('savedAmountKobo: $savedAmountKobo, ')
          ..write('targetDate: $targetDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    targetAmountKobo,
    savedAmountKobo,
    targetDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingsGoalRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.targetAmountKobo == this.targetAmountKobo &&
          other.savedAmountKobo == this.savedAmountKobo &&
          other.targetDate == this.targetDate &&
          other.createdAt == this.createdAt);
}

class SavingsGoalRowsCompanion extends UpdateCompanion<SavingsGoalRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> targetAmountKobo;
  final Value<int> savedAmountKobo;
  final Value<DateTime> targetDate;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SavingsGoalRowsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.targetAmountKobo = const Value.absent(),
    this.savedAmountKobo = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsGoalRowsCompanion.insert({
    required String id,
    required String name,
    required int targetAmountKobo,
    required int savedAmountKobo,
    required DateTime targetDate,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       targetAmountKobo = Value(targetAmountKobo),
       savedAmountKobo = Value(savedAmountKobo),
       targetDate = Value(targetDate),
       createdAt = Value(createdAt);
  static Insertable<SavingsGoalRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? targetAmountKobo,
    Expression<int>? savedAmountKobo,
    Expression<DateTime>? targetDate,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (targetAmountKobo != null) 'target_amount_kobo': targetAmountKobo,
      if (savedAmountKobo != null) 'saved_amount_kobo': savedAmountKobo,
      if (targetDate != null) 'target_date': targetDate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsGoalRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? targetAmountKobo,
    Value<int>? savedAmountKobo,
    Value<DateTime>? targetDate,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SavingsGoalRowsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmountKobo: targetAmountKobo ?? this.targetAmountKobo,
      savedAmountKobo: savedAmountKobo ?? this.savedAmountKobo,
      targetDate: targetDate ?? this.targetDate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetAmountKobo.present) {
      map['target_amount_kobo'] = Variable<int>(targetAmountKobo.value);
    }
    if (savedAmountKobo.present) {
      map['saved_amount_kobo'] = Variable<int>(savedAmountKobo.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoalRowsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('targetAmountKobo: $targetAmountKobo, ')
          ..write('savedAmountKobo: $savedAmountKobo, ')
          ..write('targetDate: $targetDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QueuedActionRowsTable queuedActionRows = $QueuedActionRowsTable(
    this,
  );
  late final $CachedTransactionRowsTable cachedTransactionRows =
      $CachedTransactionRowsTable(this);
  late final $WalletCacheRowsTable walletCacheRows = $WalletCacheRowsTable(
    this,
  );
  late final $SavingsGoalRowsTable savingsGoalRows = $SavingsGoalRowsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    queuedActionRows,
    cachedTransactionRows,
    walletCacheRows,
    savingsGoalRows,
  ];
}

typedef $$QueuedActionRowsTableCreateCompanionBuilder =
    QueuedActionRowsCompanion Function({
      required String idempotencyKey,
      required String actionType,
      Value<String?> recipient,
      Value<String?> narration,
      Value<String?> goalId,
      Value<String?> goalName,
      required int amount,
      Value<String> status,
      Value<int> attempts,
      required DateTime createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> nextRetryAt,
      Value<String?> errorMessage,
      Value<int> rowid,
    });
typedef $$QueuedActionRowsTableUpdateCompanionBuilder =
    QueuedActionRowsCompanion Function({
      Value<String> idempotencyKey,
      Value<String> actionType,
      Value<String?> recipient,
      Value<String?> narration,
      Value<String?> goalId,
      Value<String?> goalName,
      Value<int> amount,
      Value<String> status,
      Value<int> attempts,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> nextRetryAt,
      Value<String?> errorMessage,
      Value<int> rowid,
    });

class $$QueuedActionRowsTableFilterComposer
    extends Composer<_$AppDatabase, $QueuedActionRowsTable> {
  $$QueuedActionRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipient => $composableBuilder(
    column: $table.recipient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get narration => $composableBuilder(
    column: $table.narration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalName => $composableBuilder(
    column: $table.goalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QueuedActionRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $QueuedActionRowsTable> {
  $$QueuedActionRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipient => $composableBuilder(
    column: $table.recipient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get narration => $composableBuilder(
    column: $table.narration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalName => $composableBuilder(
    column: $table.goalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QueuedActionRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QueuedActionRowsTable> {
  $$QueuedActionRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recipient =>
      $composableBuilder(column: $table.recipient, builder: (column) => column);

  GeneratedColumn<String> get narration =>
      $composableBuilder(column: $table.narration, builder: (column) => column);

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get goalName =>
      $composableBuilder(column: $table.goalName, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextRetryAt => $composableBuilder(
    column: $table.nextRetryAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );
}

class $$QueuedActionRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QueuedActionRowsTable,
          QueuedActionRow,
          $$QueuedActionRowsTableFilterComposer,
          $$QueuedActionRowsTableOrderingComposer,
          $$QueuedActionRowsTableAnnotationComposer,
          $$QueuedActionRowsTableCreateCompanionBuilder,
          $$QueuedActionRowsTableUpdateCompanionBuilder,
          (
            QueuedActionRow,
            BaseReferences<
              _$AppDatabase,
              $QueuedActionRowsTable,
              QueuedActionRow
            >,
          ),
          QueuedActionRow,
          PrefetchHooks Function()
        > {
  $$QueuedActionRowsTableTableManager(
    _$AppDatabase db,
    $QueuedActionRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QueuedActionRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QueuedActionRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QueuedActionRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> actionType = const Value.absent(),
                Value<String?> recipient = const Value.absent(),
                Value<String?> narration = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> goalName = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QueuedActionRowsCompanion(
                idempotencyKey: idempotencyKey,
                actionType: actionType,
                recipient: recipient,
                narration: narration,
                goalId: goalId,
                goalName: goalName,
                amount: amount,
                status: status,
                attempts: attempts,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                nextRetryAt: nextRetryAt,
                errorMessage: errorMessage,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idempotencyKey,
                required String actionType,
                Value<String?> recipient = const Value.absent(),
                Value<String?> narration = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<String?> goalName = const Value.absent(),
                required int amount,
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> nextRetryAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QueuedActionRowsCompanion.insert(
                idempotencyKey: idempotencyKey,
                actionType: actionType,
                recipient: recipient,
                narration: narration,
                goalId: goalId,
                goalName: goalName,
                amount: amount,
                status: status,
                attempts: attempts,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                nextRetryAt: nextRetryAt,
                errorMessage: errorMessage,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QueuedActionRowsTable, QueuedActionRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $QueuedActionRowsTable,
                    QueuedActionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QueuedActionRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QueuedActionRowsTable,
      QueuedActionRow,
      $$QueuedActionRowsTableFilterComposer,
      $$QueuedActionRowsTableOrderingComposer,
      $$QueuedActionRowsTableAnnotationComposer,
      $$QueuedActionRowsTableCreateCompanionBuilder,
      $$QueuedActionRowsTableUpdateCompanionBuilder,
      (
        QueuedActionRow,
        BaseReferences<_$AppDatabase, $QueuedActionRowsTable, QueuedActionRow>,
      ),
      QueuedActionRow,
      PrefetchHooks Function()
    >;
typedef $$CachedTransactionRowsTableCreateCompanionBuilder =
    CachedTransactionRowsCompanion Function({
      required String id,
      required String direction,
      required String counterparty,
      required int amountKobo,
      required DateTime createdAt,
      required String status,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$CachedTransactionRowsTableUpdateCompanionBuilder =
    CachedTransactionRowsCompanion Function({
      Value<String> id,
      Value<String> direction,
      Value<String> counterparty,
      Value<int> amountKobo,
      Value<DateTime> createdAt,
      Value<String> status,
      Value<String?> note,
      Value<int> rowid,
    });

class $$CachedTransactionRowsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedTransactionRowsTable> {
  $$CachedTransactionRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get counterparty => $composableBuilder(
    column: $table.counterparty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountKobo => $composableBuilder(
    column: $table.amountKobo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedTransactionRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedTransactionRowsTable> {
  $$CachedTransactionRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get counterparty => $composableBuilder(
    column: $table.counterparty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountKobo => $composableBuilder(
    column: $table.amountKobo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedTransactionRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedTransactionRowsTable> {
  $$CachedTransactionRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get counterparty => $composableBuilder(
    column: $table.counterparty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountKobo => $composableBuilder(
    column: $table.amountKobo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$CachedTransactionRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedTransactionRowsTable,
          CachedTransactionRow,
          $$CachedTransactionRowsTableFilterComposer,
          $$CachedTransactionRowsTableOrderingComposer,
          $$CachedTransactionRowsTableAnnotationComposer,
          $$CachedTransactionRowsTableCreateCompanionBuilder,
          $$CachedTransactionRowsTableUpdateCompanionBuilder,
          (
            CachedTransactionRow,
            BaseReferences<
              _$AppDatabase,
              $CachedTransactionRowsTable,
              CachedTransactionRow
            >,
          ),
          CachedTransactionRow,
          PrefetchHooks Function()
        > {
  $$CachedTransactionRowsTableTableManager(
    _$AppDatabase db,
    $CachedTransactionRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedTransactionRowsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CachedTransactionRowsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedTransactionRowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String> counterparty = const Value.absent(),
                Value<int> amountKobo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedTransactionRowsCompanion(
                id: id,
                direction: direction,
                counterparty: counterparty,
                amountKobo: amountKobo,
                createdAt: createdAt,
                status: status,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String direction,
                required String counterparty,
                required int amountKobo,
                required DateTime createdAt,
                required String status,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedTransactionRowsCompanion.insert(
                id: id,
                direction: direction,
                counterparty: counterparty,
                amountKobo: amountKobo,
                createdAt: createdAt,
                status: status,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $CachedTransactionRowsTable,
                    CachedTransactionRow
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedTransactionRowsTable,
                    CachedTransactionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedTransactionRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedTransactionRowsTable,
      CachedTransactionRow,
      $$CachedTransactionRowsTableFilterComposer,
      $$CachedTransactionRowsTableOrderingComposer,
      $$CachedTransactionRowsTableAnnotationComposer,
      $$CachedTransactionRowsTableCreateCompanionBuilder,
      $$CachedTransactionRowsTableUpdateCompanionBuilder,
      (
        CachedTransactionRow,
        BaseReferences<
          _$AppDatabase,
          $CachedTransactionRowsTable,
          CachedTransactionRow
        >,
      ),
      CachedTransactionRow,
      PrefetchHooks Function()
    >;
typedef $$WalletCacheRowsTableCreateCompanionBuilder =
    WalletCacheRowsCompanion Function({
      Value<int> id,
      required int balanceKobo,
      required String accountNumber,
      required String ownerName,
      required DateTime updatedAt,
    });
typedef $$WalletCacheRowsTableUpdateCompanionBuilder =
    WalletCacheRowsCompanion Function({
      Value<int> id,
      Value<int> balanceKobo,
      Value<String> accountNumber,
      Value<String> ownerName,
      Value<DateTime> updatedAt,
    });

class $$WalletCacheRowsTableFilterComposer
    extends Composer<_$AppDatabase, $WalletCacheRowsTable> {
  $$WalletCacheRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balanceKobo => $composableBuilder(
    column: $table.balanceKobo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalletCacheRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletCacheRowsTable> {
  $$WalletCacheRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balanceKobo => $composableBuilder(
    column: $table.balanceKobo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalletCacheRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletCacheRowsTable> {
  $$WalletCacheRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get balanceKobo => $composableBuilder(
    column: $table.balanceKobo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WalletCacheRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletCacheRowsTable,
          WalletCacheRow,
          $$WalletCacheRowsTableFilterComposer,
          $$WalletCacheRowsTableOrderingComposer,
          $$WalletCacheRowsTableAnnotationComposer,
          $$WalletCacheRowsTableCreateCompanionBuilder,
          $$WalletCacheRowsTableUpdateCompanionBuilder,
          (
            WalletCacheRow,
            BaseReferences<
              _$AppDatabase,
              $WalletCacheRowsTable,
              WalletCacheRow
            >,
          ),
          WalletCacheRow,
          PrefetchHooks Function()
        > {
  $$WalletCacheRowsTableTableManager(
    _$AppDatabase db,
    $WalletCacheRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletCacheRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletCacheRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletCacheRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> balanceKobo = const Value.absent(),
                Value<String> accountNumber = const Value.absent(),
                Value<String> ownerName = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WalletCacheRowsCompanion(
                id: id,
                balanceKobo: balanceKobo,
                accountNumber: accountNumber,
                ownerName: ownerName,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int balanceKobo,
                required String accountNumber,
                required String ownerName,
                required DateTime updatedAt,
              }) => WalletCacheRowsCompanion.insert(
                id: id,
                balanceKobo: balanceKobo,
                accountNumber: accountNumber,
                ownerName: ownerName,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WalletCacheRowsTable, WalletCacheRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WalletCacheRowsTable,
                    WalletCacheRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalletCacheRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletCacheRowsTable,
      WalletCacheRow,
      $$WalletCacheRowsTableFilterComposer,
      $$WalletCacheRowsTableOrderingComposer,
      $$WalletCacheRowsTableAnnotationComposer,
      $$WalletCacheRowsTableCreateCompanionBuilder,
      $$WalletCacheRowsTableUpdateCompanionBuilder,
      (
        WalletCacheRow,
        BaseReferences<_$AppDatabase, $WalletCacheRowsTable, WalletCacheRow>,
      ),
      WalletCacheRow,
      PrefetchHooks Function()
    >;
typedef $$SavingsGoalRowsTableCreateCompanionBuilder =
    SavingsGoalRowsCompanion Function({
      required String id,
      required String name,
      required int targetAmountKobo,
      required int savedAmountKobo,
      required DateTime targetDate,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SavingsGoalRowsTableUpdateCompanionBuilder =
    SavingsGoalRowsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> targetAmountKobo,
      Value<int> savedAmountKobo,
      Value<DateTime> targetDate,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SavingsGoalRowsTableFilterComposer
    extends Composer<_$AppDatabase, $SavingsGoalRowsTable> {
  $$SavingsGoalRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetAmountKobo => $composableBuilder(
    column: $table.targetAmountKobo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get savedAmountKobo => $composableBuilder(
    column: $table.savedAmountKobo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavingsGoalRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavingsGoalRowsTable> {
  $$SavingsGoalRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetAmountKobo => $composableBuilder(
    column: $table.targetAmountKobo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get savedAmountKobo => $composableBuilder(
    column: $table.savedAmountKobo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavingsGoalRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavingsGoalRowsTable> {
  $$SavingsGoalRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get targetAmountKobo => $composableBuilder(
    column: $table.targetAmountKobo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get savedAmountKobo => $composableBuilder(
    column: $table.savedAmountKobo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SavingsGoalRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavingsGoalRowsTable,
          SavingsGoalRow,
          $$SavingsGoalRowsTableFilterComposer,
          $$SavingsGoalRowsTableOrderingComposer,
          $$SavingsGoalRowsTableAnnotationComposer,
          $$SavingsGoalRowsTableCreateCompanionBuilder,
          $$SavingsGoalRowsTableUpdateCompanionBuilder,
          (
            SavingsGoalRow,
            BaseReferences<
              _$AppDatabase,
              $SavingsGoalRowsTable,
              SavingsGoalRow
            >,
          ),
          SavingsGoalRow,
          PrefetchHooks Function()
        > {
  $$SavingsGoalRowsTableTableManager(
    _$AppDatabase db,
    $SavingsGoalRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingsGoalRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingsGoalRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingsGoalRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> targetAmountKobo = const Value.absent(),
                Value<int> savedAmountKobo = const Value.absent(),
                Value<DateTime> targetDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsGoalRowsCompanion(
                id: id,
                name: name,
                targetAmountKobo: targetAmountKobo,
                savedAmountKobo: savedAmountKobo,
                targetDate: targetDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int targetAmountKobo,
                required int savedAmountKobo,
                required DateTime targetDate,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SavingsGoalRowsCompanion.insert(
                id: id,
                name: name,
                targetAmountKobo: targetAmountKobo,
                savedAmountKobo: savedAmountKobo,
                targetDate: targetDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SavingsGoalRowsTable, SavingsGoalRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SavingsGoalRowsTable,
                    SavingsGoalRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavingsGoalRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavingsGoalRowsTable,
      SavingsGoalRow,
      $$SavingsGoalRowsTableFilterComposer,
      $$SavingsGoalRowsTableOrderingComposer,
      $$SavingsGoalRowsTableAnnotationComposer,
      $$SavingsGoalRowsTableCreateCompanionBuilder,
      $$SavingsGoalRowsTableUpdateCompanionBuilder,
      (
        SavingsGoalRow,
        BaseReferences<_$AppDatabase, $SavingsGoalRowsTable, SavingsGoalRow>,
      ),
      SavingsGoalRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QueuedActionRowsTableTableManager get queuedActionRows =>
      $$QueuedActionRowsTableTableManager(_db, _db.queuedActionRows);
  $$CachedTransactionRowsTableTableManager get cachedTransactionRows =>
      $$CachedTransactionRowsTableTableManager(_db, _db.cachedTransactionRows);
  $$WalletCacheRowsTableTableManager get walletCacheRows =>
      $$WalletCacheRowsTableTableManager(_db, _db.walletCacheRows);
  $$SavingsGoalRowsTableTableManager get savingsGoalRows =>
      $$SavingsGoalRowsTableTableManager(_db, _db.savingsGoalRows);
}
