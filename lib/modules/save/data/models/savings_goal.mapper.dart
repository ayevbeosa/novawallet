// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'savings_goal.dart';

class SavingsGoalMapper extends ClassMapperBase<SavingsGoal> {
  SavingsGoalMapper._();

  static SavingsGoalMapper? _instance;
  static SavingsGoalMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SavingsGoalMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SavingsGoal';

  static String _$id(SavingsGoal v) => v.id;
  static const Field<SavingsGoal, String> _f$id = Field('id', _$id);
  static String _$name(SavingsGoal v) => v.name;
  static const Field<SavingsGoal, String> _f$name = Field('name', _$name);
  static int _$targetAmount(SavingsGoal v) => v.targetAmount;
  static const Field<SavingsGoal, int> _f$targetAmount = Field(
    'targetAmount',
    _$targetAmount,
  );
  static int _$savedAmount(SavingsGoal v) => v.savedAmount;
  static const Field<SavingsGoal, int> _f$savedAmount = Field(
    'savedAmount',
    _$savedAmount,
  );
  static DateTime _$targetDate(SavingsGoal v) => v.targetDate;
  static const Field<SavingsGoal, DateTime> _f$targetDate = Field(
    'targetDate',
    _$targetDate,
  );
  static DateTime _$createdAt(SavingsGoal v) => v.createdAt;
  static const Field<SavingsGoal, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<SavingsGoal> fields = const {
    #id: _f$id,
    #name: _f$name,
    #targetAmount: _f$targetAmount,
    #savedAmount: _f$savedAmount,
    #targetDate: _f$targetDate,
    #createdAt: _f$createdAt,
  };

  static SavingsGoal _instantiate(DecodingData data) {
    return SavingsGoal(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      targetAmount: data.dec(_f$targetAmount),
      savedAmount: data.dec(_f$savedAmount),
      targetDate: data.dec(_f$targetDate),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SavingsGoal fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SavingsGoal>(map);
  }

  static SavingsGoal fromJson(String json) {
    return ensureInitialized().decodeJson<SavingsGoal>(json);
  }
}

mixin SavingsGoalMappable {
  String toJson() {
    return SavingsGoalMapper.ensureInitialized().encodeJson<SavingsGoal>(
      this as SavingsGoal,
    );
  }

  Map<String, dynamic> toMap() {
    return SavingsGoalMapper.ensureInitialized().encodeMap<SavingsGoal>(
      this as SavingsGoal,
    );
  }

  SavingsGoalCopyWith<SavingsGoal, SavingsGoal, SavingsGoal> get copyWith =>
      _SavingsGoalCopyWithImpl<SavingsGoal, SavingsGoal>(
        this as SavingsGoal,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SavingsGoalMapper.ensureInitialized().stringifyValue(
      this as SavingsGoal,
    );
  }

  @override
  bool operator ==(Object other) {
    return SavingsGoalMapper.ensureInitialized().equalsValue(
      this as SavingsGoal,
      other,
    );
  }

  @override
  int get hashCode {
    return SavingsGoalMapper.ensureInitialized().hashValue(this as SavingsGoal);
  }
}

extension SavingsGoalValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SavingsGoal, $Out> {
  SavingsGoalCopyWith<$R, SavingsGoal, $Out> get $asSavingsGoal =>
      $base.as((v, t, t2) => _SavingsGoalCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SavingsGoalCopyWith<$R, $In extends SavingsGoal, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    int? targetAmount,
    int? savedAmount,
    DateTime? targetDate,
    DateTime? createdAt,
  });
  SavingsGoalCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SavingsGoalCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SavingsGoal, $Out>
    implements SavingsGoalCopyWith<$R, SavingsGoal, $Out> {
  _SavingsGoalCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SavingsGoal> $mapper =
      SavingsGoalMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    int? targetAmount,
    int? savedAmount,
    DateTime? targetDate,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (targetAmount != null) #targetAmount: targetAmount,
      if (savedAmount != null) #savedAmount: savedAmount,
      if (targetDate != null) #targetDate: targetDate,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  SavingsGoal $make(CopyWithData data) => SavingsGoal(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    targetAmount: data.get(#targetAmount, or: $value.targetAmount),
    savedAmount: data.get(#savedAmount, or: $value.savedAmount),
    targetDate: data.get(#targetDate, or: $value.targetDate),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  SavingsGoalCopyWith<$R2, SavingsGoal, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SavingsGoalCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

