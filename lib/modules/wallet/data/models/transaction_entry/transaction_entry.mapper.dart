// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'transaction_entry.dart';

class TransactionDirectionMapper extends EnumMapper<TransactionDirection> {
  TransactionDirectionMapper._();

  static TransactionDirectionMapper? _instance;
  static TransactionDirectionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TransactionDirectionMapper._());
    }
    return _instance!;
  }

  static TransactionDirection fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TransactionDirection decode(dynamic value) {
    switch (value) {
      case r'credit':
        return TransactionDirection.credit;
      case r'debit':
        return TransactionDirection.debit;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TransactionDirection self) {
    switch (self) {
      case TransactionDirection.credit:
        return r'credit';
      case TransactionDirection.debit:
        return r'debit';
    }
  }
}

extension TransactionDirectionMapperExtension on TransactionDirection {
  String toValue() {
    TransactionDirectionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TransactionDirection>(this)
        as String;
  }
}

class TransactionStatusMapper extends EnumMapper<TransactionStatus> {
  TransactionStatusMapper._();

  static TransactionStatusMapper? _instance;
  static TransactionStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TransactionStatusMapper._());
    }
    return _instance!;
  }

  static TransactionStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TransactionStatus decode(dynamic value) {
    switch (value) {
      case r'completed':
        return TransactionStatus.completed;
      case r'pending':
        return TransactionStatus.pending;
      case r'failed':
        return TransactionStatus.failed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TransactionStatus self) {
    switch (self) {
      case TransactionStatus.completed:
        return r'completed';
      case TransactionStatus.pending:
        return r'pending';
      case TransactionStatus.failed:
        return r'failed';
    }
  }
}

extension TransactionStatusMapperExtension on TransactionStatus {
  String toValue() {
    TransactionStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TransactionStatus>(this) as String;
  }
}

class TransactionEntryMapper extends ClassMapperBase<TransactionEntry> {
  TransactionEntryMapper._();

  static TransactionEntryMapper? _instance;
  static TransactionEntryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TransactionEntryMapper._());
      TransactionDirectionMapper.ensureInitialized();
      TransactionStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TransactionEntry';

  static String _$id(TransactionEntry v) => v.id;
  static const Field<TransactionEntry, String> _f$id = Field('id', _$id);
  static TransactionDirection _$direction(TransactionEntry v) => v.direction;
  static const Field<TransactionEntry, TransactionDirection> _f$direction =
      Field('direction', _$direction);
  static String _$counterparty(TransactionEntry v) => v.counterparty;
  static const Field<TransactionEntry, String> _f$counterparty = Field(
    'counterparty',
    _$counterparty,
  );
  static int _$amount(TransactionEntry v) => v.amount;
  static const Field<TransactionEntry, int> _f$amount = Field(
    'amount',
    _$amount,
  );
  static DateTime _$createdAt(TransactionEntry v) => v.createdAt;
  static const Field<TransactionEntry, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static TransactionStatus _$status(TransactionEntry v) => v.status;
  static const Field<TransactionEntry, TransactionStatus> _f$status = Field(
    'status',
    _$status,
  );
  static String? _$narration(TransactionEntry v) => v.narration;
  static const Field<TransactionEntry, String> _f$narration = Field(
    'narration',
    _$narration,
    opt: true,
  );

  @override
  final MappableFields<TransactionEntry> fields = const {
    #id: _f$id,
    #direction: _f$direction,
    #counterparty: _f$counterparty,
    #amount: _f$amount,
    #createdAt: _f$createdAt,
    #status: _f$status,
    #narration: _f$narration,
  };

  static TransactionEntry _instantiate(DecodingData data) {
    return TransactionEntry(
      id: data.dec(_f$id),
      direction: data.dec(_f$direction),
      counterparty: data.dec(_f$counterparty),
      amount: data.dec(_f$amount),
      createdAt: data.dec(_f$createdAt),
      status: data.dec(_f$status),
      narration: data.dec(_f$narration),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TransactionEntry fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TransactionEntry>(map);
  }

  static TransactionEntry fromJson(String json) {
    return ensureInitialized().decodeJson<TransactionEntry>(json);
  }
}

mixin TransactionEntryMappable {
  String toJson() {
    return TransactionEntryMapper.ensureInitialized()
        .encodeJson<TransactionEntry>(this as TransactionEntry);
  }

  Map<String, dynamic> toMap() {
    return TransactionEntryMapper.ensureInitialized()
        .encodeMap<TransactionEntry>(this as TransactionEntry);
  }

  TransactionEntryCopyWith<TransactionEntry, TransactionEntry, TransactionEntry>
  get copyWith =>
      _TransactionEntryCopyWithImpl<TransactionEntry, TransactionEntry>(
        this as TransactionEntry,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TransactionEntryMapper.ensureInitialized().stringifyValue(
      this as TransactionEntry,
    );
  }

  @override
  bool operator ==(Object other) {
    return TransactionEntryMapper.ensureInitialized().equalsValue(
      this as TransactionEntry,
      other,
    );
  }

  @override
  int get hashCode {
    return TransactionEntryMapper.ensureInitialized().hashValue(
      this as TransactionEntry,
    );
  }
}

extension TransactionEntryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TransactionEntry, $Out> {
  TransactionEntryCopyWith<$R, TransactionEntry, $Out>
  get $asTransactionEntry =>
      $base.as((v, t, t2) => _TransactionEntryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TransactionEntryCopyWith<$R, $In extends TransactionEntry, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    TransactionDirection? direction,
    String? counterparty,
    int? amount,
    DateTime? createdAt,
    TransactionStatus? status,
    String? narration,
  });
  TransactionEntryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TransactionEntryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TransactionEntry, $Out>
    implements TransactionEntryCopyWith<$R, TransactionEntry, $Out> {
  _TransactionEntryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TransactionEntry> $mapper =
      TransactionEntryMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    TransactionDirection? direction,
    String? counterparty,
    int? amount,
    DateTime? createdAt,
    TransactionStatus? status,
    Object? narration = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (direction != null) #direction: direction,
      if (counterparty != null) #counterparty: counterparty,
      if (amount != null) #amount: amount,
      if (createdAt != null) #createdAt: createdAt,
      if (status != null) #status: status,
      if (narration != $none) #narration: narration,
    }),
  );
  @override
  TransactionEntry $make(CopyWithData data) => TransactionEntry(
    id: data.get(#id, or: $value.id),
    direction: data.get(#direction, or: $value.direction),
    counterparty: data.get(#counterparty, or: $value.counterparty),
    amount: data.get(#amount, or: $value.amount),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    status: data.get(#status, or: $value.status),
    narration: data.get(#narration, or: $value.narration),
  );

  @override
  TransactionEntryCopyWith<$R2, TransactionEntry, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TransactionEntryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

