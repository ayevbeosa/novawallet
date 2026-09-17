import 'package:bloc_signals_hydrate/bloc_signals_hydrate.dart';

/// Supported app languages — English and Yoruba, matching the Send Money
/// screen's localization scaffold (`lib/core/l10n/app_en.arb` /
/// `app_yo.arb`).
enum AppLanguage {
  english('en', 'English'),
  yoruba('yo', 'Yorùbá');

  const AppLanguage(this.code, this.label);
  final String code;
  final String label;

  static AppLanguage fromCode(String code) =>
      AppLanguage.values.firstWhere((l) => l.code == code, orElse: () => AppLanguage.english);
}

/// Persists the user's chosen language across app restarts via
/// `bloc_signals_hydrate` — state is a plain `String` locale code, one of
/// the primitive types the package hydrates without needing a manual
/// `toJson`/`fromJson` override. Storage itself (`HydratedStorage.storage`)
/// is configured once in `main()`, before this cubit (or anything else) is
/// constructed, so the persisted value is available synchronously on the
/// very first frame — no flash of the default language while a read
/// completes.
class LocaleCubit extends HydratedCubitSignal<String> {
  LocaleCubit() : super(initialState: AppLanguage.english.code);

  AppLanguage get language => AppLanguage.fromCode(value);

  void setLanguage(AppLanguage language) => emit(language.code);
}
