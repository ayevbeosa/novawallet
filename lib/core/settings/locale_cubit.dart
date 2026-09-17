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

class LocaleCubit extends HydratedCubitSignal<String> {
  LocaleCubit() : super(initialState: AppLanguage.english.code);

  AppLanguage get language => AppLanguage.fromCode(value);

  void setLanguage(AppLanguage language) => emit(language.code);
}
