// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'queued_action.dart';

class QueuedActionStatusMapper extends EnumMapper<QueuedActionStatus> {
  QueuedActionStatusMapper._();

  static QueuedActionStatusMapper? _instance;
  static QueuedActionStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QueuedActionStatusMapper._());
    }
    return _instance!;
  }

  static QueuedActionStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  QueuedActionStatus decode(dynamic value) {
    switch (value) {
      case r'pending':
        return QueuedActionStatus.pending;
      case r'syncing':
        return QueuedActionStatus.syncing;
      case r'synced':
        return QueuedActionStatus.synced;
      case r'failed':
        return QueuedActionStatus.failed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(QueuedActionStatus self) {
    switch (self) {
      case QueuedActionStatus.pending:
        return r'pending';
      case QueuedActionStatus.syncing:
        return r'syncing';
      case QueuedActionStatus.synced:
        return r'synced';
      case QueuedActionStatus.failed:
        return r'failed';
    }
  }
}

extension QueuedActionStatusMapperExtension on QueuedActionStatus {
  String toValue() {
    QueuedActionStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<QueuedActionStatus>(this) as String;
  }
}

class QueuedActionMapper extends ClassMapperBase<QueuedAction> {
  QueuedActionMapper._();

  static QueuedActionMapper? _instance;
  static QueuedActionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = QueuedActionMapper._());
      SendMoneyActionMapper.ensureInitialized();
      ContributeGoalActionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'QueuedAction';

  static String _$idempotencyKey(QueuedAction v) => v.idempotencyKey;
  static const Field<QueuedAction, String> _f$idempotencyKey = Field(
    'idempotencyKey',
    _$idempotencyKey,
  );
  static DateTime _$createdAt(QueuedAction v) => v.createdAt;
  static const Field<QueuedAction, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<QueuedAction> fields = const {
    #idempotencyKey: _f$idempotencyKey,
    #createdAt: _f$createdAt,
  };

  static QueuedAction _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'QueuedAction',
      'type',
      '${data.value['type']}',
    );
  }

  @override
  final Function instantiate = _instantiate;

  static QueuedAction fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<QueuedAction>(map);
  }

  static QueuedAction fromJson(String json) {
    return ensureInitialized().decodeJson<QueuedAction>(json);
  }
}

mixin QueuedActionMappable {
  String toJson();
  Map<String, dynamic> toMap();
  QueuedActionCopyWith<QueuedAction, QueuedAction, QueuedAction> get copyWith;
}

abstract class QueuedActionCopyWith<$R, $In extends QueuedAction, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? idempotencyKey, DateTime? createdAt});
  QueuedActionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SendMoneyActionMapper extends SubClassMapperBase<SendMoneyAction> {
  SendMoneyActionMapper._();

  static SendMoneyActionMapper? _instance;
  static SendMoneyActionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SendMoneyActionMapper._());
      QueuedActionMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'SendMoneyAction';

  static String _$idempotencyKey(SendMoneyAction v) => v.idempotencyKey;
  static const Field<SendMoneyAction, String> _f$idempotencyKey = Field(
    'idempotencyKey',
    _$idempotencyKey,
  );
  static DateTime _$createdAt(SendMoneyAction v) => v.createdAt;
  static const Field<SendMoneyAction, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String _$recipient(SendMoneyAction v) => v.recipient;
  static const Field<SendMoneyAction, String> _f$recipient = Field(
    'recipient',
    _$recipient,
  );
  static int _$amount(SendMoneyAction v) => v.amount;
  static const Field<SendMoneyAction, int> _f$amount = Field(
    'amount',
    _$amount,
  );
  static String? _$narration(SendMoneyAction v) => v.narration;
  static const Field<SendMoneyAction, String> _f$narration = Field(
    'narration',
    _$narration,
    opt: true,
  );

  @override
  final MappableFields<SendMoneyAction> fields = const {
    #idempotencyKey: _f$idempotencyKey,
    #createdAt: _f$createdAt,
    #recipient: _f$recipient,
    #amount: _f$amount,
    #narration: _f$narration,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'send_money';
  @override
  late final ClassMapperBase superMapper =
      QueuedActionMapper.ensureInitialized();

  static SendMoneyAction _instantiate(DecodingData data) {
    return SendMoneyAction(
      idempotencyKey: data.dec(_f$idempotencyKey),
      createdAt: data.dec(_f$createdAt),
      recipient: data.dec(_f$recipient),
      amount: data.dec(_f$amount),
      narration: data.dec(_f$narration),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SendMoneyAction fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SendMoneyAction>(map);
  }

  static SendMoneyAction fromJson(String json) {
    return ensureInitialized().decodeJson<SendMoneyAction>(json);
  }
}

mixin SendMoneyActionMappable {
  String toJson() {
    return SendMoneyActionMapper.ensureInitialized()
        .encodeJson<SendMoneyAction>(this as SendMoneyAction);
  }

  Map<String, dynamic> toMap() {
    return SendMoneyActionMapper.ensureInitialized().encodeMap<SendMoneyAction>(
      this as SendMoneyAction,
    );
  }

  SendMoneyActionCopyWith<SendMoneyAction, SendMoneyAction, SendMoneyAction>
  get copyWith =>
      _SendMoneyActionCopyWithImpl<SendMoneyAction, SendMoneyAction>(
        this as SendMoneyAction,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SendMoneyActionMapper.ensureInitialized().stringifyValue(
      this as SendMoneyAction,
    );
  }

  @override
  bool operator ==(Object other) {
    return SendMoneyActionMapper.ensureInitialized().equalsValue(
      this as SendMoneyAction,
      other,
    );
  }

  @override
  int get hashCode {
    return SendMoneyActionMapper.ensureInitialized().hashValue(
      this as SendMoneyAction,
    );
  }
}

extension SendMoneyActionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SendMoneyAction, $Out> {
  SendMoneyActionCopyWith<$R, SendMoneyAction, $Out> get $asSendMoneyAction =>
      $base.as((v, t, t2) => _SendMoneyActionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SendMoneyActionCopyWith<$R, $In extends SendMoneyAction, $Out>
    implements QueuedActionCopyWith<$R, $In, $Out> {
  @override
  $R call({
    String? idempotencyKey,
    DateTime? createdAt,
    String? recipient,
    int? amount,
    String? narration,
  });
  SendMoneyActionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SendMoneyActionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SendMoneyAction, $Out>
    implements SendMoneyActionCopyWith<$R, SendMoneyAction, $Out> {
  _SendMoneyActionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SendMoneyAction> $mapper =
      SendMoneyActionMapper.ensureInitialized();
  @override
  $R call({
    String? idempotencyKey,
    DateTime? createdAt,
    String? recipient,
    int? amount,
    Object? narration = $none,
  }) => $apply(
    FieldCopyWithData({
      if (idempotencyKey != null) #idempotencyKey: idempotencyKey,
      if (createdAt != null) #createdAt: createdAt,
      if (recipient != null) #recipient: recipient,
      if (amount != null) #amount: amount,
      if (narration != $none) #narration: narration,
    }),
  );
  @override
  SendMoneyAction $make(CopyWithData data) => SendMoneyAction(
    idempotencyKey: data.get(#idempotencyKey, or: $value.idempotencyKey),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    recipient: data.get(#recipient, or: $value.recipient),
    amount: data.get(#amount, or: $value.amount),
    narration: data.get(#narration, or: $value.narration),
  );

  @override
  SendMoneyActionCopyWith<$R2, SendMoneyAction, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SendMoneyActionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ContributeGoalActionMapper
    extends SubClassMapperBase<ContributeGoalAction> {
  ContributeGoalActionMapper._();

  static ContributeGoalActionMapper? _instance;
  static ContributeGoalActionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContributeGoalActionMapper._());
      QueuedActionMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'ContributeGoalAction';

  static String _$idempotencyKey(ContributeGoalAction v) => v.idempotencyKey;
  static const Field<ContributeGoalAction, String> _f$idempotencyKey = Field(
    'idempotencyKey',
    _$idempotencyKey,
  );
  static DateTime _$createdAt(ContributeGoalAction v) => v.createdAt;
  static const Field<ContributeGoalAction, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String _$goalId(ContributeGoalAction v) => v.goalId;
  static const Field<ContributeGoalAction, String> _f$goalId = Field(
    'goalId',
    _$goalId,
  );
  static String _$goalName(ContributeGoalAction v) => v.goalName;
  static const Field<ContributeGoalAction, String> _f$goalName = Field(
    'goalName',
    _$goalName,
  );
  static int _$amount(ContributeGoalAction v) => v.amount;
  static const Field<ContributeGoalAction, int> _f$amount = Field(
    'amount',
    _$amount,
  );

  @override
  final MappableFields<ContributeGoalAction> fields = const {
    #idempotencyKey: _f$idempotencyKey,
    #createdAt: _f$createdAt,
    #goalId: _f$goalId,
    #goalName: _f$goalName,
    #amount: _f$amount,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'contribute_goal';
  @override
  late final ClassMapperBase superMapper =
      QueuedActionMapper.ensureInitialized();

  static ContributeGoalAction _instantiate(DecodingData data) {
    return ContributeGoalAction(
      idempotencyKey: data.dec(_f$idempotencyKey),
      createdAt: data.dec(_f$createdAt),
      goalId: data.dec(_f$goalId),
      goalName: data.dec(_f$goalName),
      amount: data.dec(_f$amount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ContributeGoalAction fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContributeGoalAction>(map);
  }

  static ContributeGoalAction fromJson(String json) {
    return ensureInitialized().decodeJson<ContributeGoalAction>(json);
  }
}

mixin ContributeGoalActionMappable {
  String toJson() {
    return ContributeGoalActionMapper.ensureInitialized()
        .encodeJson<ContributeGoalAction>(this as ContributeGoalAction);
  }

  Map<String, dynamic> toMap() {
    return ContributeGoalActionMapper.ensureInitialized()
        .encodeMap<ContributeGoalAction>(this as ContributeGoalAction);
  }

  ContributeGoalActionCopyWith<
    ContributeGoalAction,
    ContributeGoalAction,
    ContributeGoalAction
  >
  get copyWith =>
      _ContributeGoalActionCopyWithImpl<
        ContributeGoalAction,
        ContributeGoalAction
      >(this as ContributeGoalAction, $identity, $identity);
  @override
  String toString() {
    return ContributeGoalActionMapper.ensureInitialized().stringifyValue(
      this as ContributeGoalAction,
    );
  }

  @override
  bool operator ==(Object other) {
    return ContributeGoalActionMapper.ensureInitialized().equalsValue(
      this as ContributeGoalAction,
      other,
    );
  }

  @override
  int get hashCode {
    return ContributeGoalActionMapper.ensureInitialized().hashValue(
      this as ContributeGoalAction,
    );
  }
}

extension ContributeGoalActionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContributeGoalAction, $Out> {
  ContributeGoalActionCopyWith<$R, ContributeGoalAction, $Out>
  get $asContributeGoalAction => $base.as(
    (v, t, t2) => _ContributeGoalActionCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ContributeGoalActionCopyWith<
  $R,
  $In extends ContributeGoalAction,
  $Out
>
    implements QueuedActionCopyWith<$R, $In, $Out> {
  @override
  $R call({
    String? idempotencyKey,
    DateTime? createdAt,
    String? goalId,
    String? goalName,
    int? amount,
  });
  ContributeGoalActionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ContributeGoalActionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContributeGoalAction, $Out>
    implements ContributeGoalActionCopyWith<$R, ContributeGoalAction, $Out> {
  _ContributeGoalActionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContributeGoalAction> $mapper =
      ContributeGoalActionMapper.ensureInitialized();
  @override
  $R call({
    String? idempotencyKey,
    DateTime? createdAt,
    String? goalId,
    String? goalName,
    int? amount,
  }) => $apply(
    FieldCopyWithData({
      if (idempotencyKey != null) #idempotencyKey: idempotencyKey,
      if (createdAt != null) #createdAt: createdAt,
      if (goalId != null) #goalId: goalId,
      if (goalName != null) #goalName: goalName,
      if (amount != null) #amount: amount,
    }),
  );
  @override
  ContributeGoalAction $make(CopyWithData data) => ContributeGoalAction(
    idempotencyKey: data.get(#idempotencyKey, or: $value.idempotencyKey),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    goalId: data.get(#goalId, or: $value.goalId),
    goalName: data.get(#goalName, or: $value.goalName),
    amount: data.get(#amount, or: $value.amount),
  );

  @override
  ContributeGoalActionCopyWith<$R2, ContributeGoalAction, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ContributeGoalActionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

