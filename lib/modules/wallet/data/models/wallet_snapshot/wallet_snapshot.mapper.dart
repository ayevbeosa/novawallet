// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'wallet_snapshot.dart';

class WalletSnapshotMapper extends ClassMapperBase<WalletSnapshot> {
  WalletSnapshotMapper._();

  static WalletSnapshotMapper? _instance;
  static WalletSnapshotMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WalletSnapshotMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WalletSnapshot';

  static int _$balanceKobo(WalletSnapshot v) => v.balanceKobo;
  static const Field<WalletSnapshot, int> _f$balanceKobo = Field(
    'balanceKobo',
    _$balanceKobo,
  );
  static String _$accountNumber(WalletSnapshot v) => v.accountNumber;
  static const Field<WalletSnapshot, String> _f$accountNumber = Field(
    'accountNumber',
    _$accountNumber,
  );
  static String _$ownerName(WalletSnapshot v) => v.ownerName;
  static const Field<WalletSnapshot, String> _f$ownerName = Field(
    'ownerName',
    _$ownerName,
  );
  static DateTime _$updatedAt(WalletSnapshot v) => v.updatedAt;
  static const Field<WalletSnapshot, DateTime> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
  );

  @override
  final MappableFields<WalletSnapshot> fields = const {
    #balanceKobo: _f$balanceKobo,
    #accountNumber: _f$accountNumber,
    #ownerName: _f$ownerName,
    #updatedAt: _f$updatedAt,
  };

  static WalletSnapshot _instantiate(DecodingData data) {
    return WalletSnapshot(
      balanceKobo: data.dec(_f$balanceKobo),
      accountNumber: data.dec(_f$accountNumber),
      ownerName: data.dec(_f$ownerName),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WalletSnapshot fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WalletSnapshot>(map);
  }

  static WalletSnapshot fromJson(String json) {
    return ensureInitialized().decodeJson<WalletSnapshot>(json);
  }
}

mixin WalletSnapshotMappable {
  String toJson() {
    return WalletSnapshotMapper.ensureInitialized().encodeJson<WalletSnapshot>(
      this as WalletSnapshot,
    );
  }

  Map<String, dynamic> toMap() {
    return WalletSnapshotMapper.ensureInitialized().encodeMap<WalletSnapshot>(
      this as WalletSnapshot,
    );
  }

  WalletSnapshotCopyWith<WalletSnapshot, WalletSnapshot, WalletSnapshot>
  get copyWith => _WalletSnapshotCopyWithImpl<WalletSnapshot, WalletSnapshot>(
    this as WalletSnapshot,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return WalletSnapshotMapper.ensureInitialized().stringifyValue(
      this as WalletSnapshot,
    );
  }

  @override
  bool operator ==(Object other) {
    return WalletSnapshotMapper.ensureInitialized().equalsValue(
      this as WalletSnapshot,
      other,
    );
  }

  @override
  int get hashCode {
    return WalletSnapshotMapper.ensureInitialized().hashValue(
      this as WalletSnapshot,
    );
  }
}

extension WalletSnapshotValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WalletSnapshot, $Out> {
  WalletSnapshotCopyWith<$R, WalletSnapshot, $Out> get $asWalletSnapshot =>
      $base.as((v, t, t2) => _WalletSnapshotCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WalletSnapshotCopyWith<$R, $In extends WalletSnapshot, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? balanceKobo,
    String? accountNumber,
    String? ownerName,
    DateTime? updatedAt,
  });
  WalletSnapshotCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WalletSnapshotCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WalletSnapshot, $Out>
    implements WalletSnapshotCopyWith<$R, WalletSnapshot, $Out> {
  _WalletSnapshotCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WalletSnapshot> $mapper =
      WalletSnapshotMapper.ensureInitialized();
  @override
  $R call({
    int? balanceKobo,
    String? accountNumber,
    String? ownerName,
    DateTime? updatedAt,
  }) => $apply(
    FieldCopyWithData({
      if (balanceKobo != null) #balanceKobo: balanceKobo,
      if (accountNumber != null) #accountNumber: accountNumber,
      if (ownerName != null) #ownerName: ownerName,
      if (updatedAt != null) #updatedAt: updatedAt,
    }),
  );
  @override
  WalletSnapshot $make(CopyWithData data) => WalletSnapshot(
    balanceKobo: data.get(#balanceKobo, or: $value.balanceKobo),
    accountNumber: data.get(#accountNumber, or: $value.accountNumber),
    ownerName: data.get(#ownerName, or: $value.ownerName),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  WalletSnapshotCopyWith<$R2, WalletSnapshot, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WalletSnapshotCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

