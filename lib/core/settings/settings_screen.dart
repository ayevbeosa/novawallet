import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/settings/locale_cubit.dart';
import 'package:novawallet/core/theme/app_colors.dart';

/// Reads/writes the app-wide [LocaleCubit] provided in `AppProviders` — a
/// long-lived, cross-screen cubit, so (per the same reasoning as
/// `WalletCubit`/`SaveGoalsCubit`) this screen reads it via the ambient
/// `BlocSignalProvider` rather than owning its own instance.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocaleCubit>();
    final localeCode = context.value<LocaleCubit, String>();
    final selected = AppLanguage.fromCode(localeCode);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: SafeArea(
        child: RadioGroup(
          groupValue: selected,
          onChanged: (value) {
            if (value != null) cubit.setLanguage(value);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                l10n.language,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.languagePersist,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 12),
              ...AppLanguage.values.map(
                (language) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: RadioListTile<AppLanguage>(
                    value: language,
                    title: Text(language.label),
                    activeColor: AppColors.cyan,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
