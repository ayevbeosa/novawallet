import 'dart:async';

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/amount_field.dart';
import 'package:novawallet/modules/save/presentation/cubits/contribute_cubit.dart';

/// Modal bottom sheet for contributing to a single goal. Owns its
/// `ContributeCubit` directly — created via the `late final` initializer,
/// closed in `dispose()` — one instance per sheet, mirroring the Send
/// Money flow's guarantee that an idempotency key is minted exactly once
/// per attempt.
class ContributeSheet extends StatefulWidget {
  const ContributeSheet({required this.goalId, required this.goalName, super.key});

  final String goalId;
  final String goalName;

  @override
  State<ContributeSheet> createState() => _ContributeSheetState();
}

class _ContributeSheetState extends State<ContributeSheet> {
  late final _cubit = ContributeCubit(
    repository: getIt(),
    connectivity: getIt(),
    goalId: widget.goalId,
    goalName: widget.goalName,
  );

  @override
  void dispose() {
    unawaited(_cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocSignalBuilder<ContributeCubit, ContributeState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.outcome != null) {
          final offline = state.outcome!.kind == ContributeOutcomeKind.queuedOffline;
          return Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 32,
              bottom: MediaQuery.of(context).viewInsets.bottom + 32,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  offline ? Icons.cloud_off_rounded : Icons.check_circle_rounded,
                  color: offline ? AppColors.gold : AppColors.green,
                  size: 56,
                ),
                const SizedBox(height: 16),
                Text(
                  offline ? l10n.pendingOffline : l10n.contributionQueued,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.done),
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.contribute, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              AmountField(autofocus: true, onChangedKobo: _cubit.setAmountKobo),
              if (state.validationError != null) ...[
                const SizedBox(height: 8),
                Text(state.validationError!, style: const TextStyle(color: AppColors.red)),
              ],
              const SizedBox(height: 20),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: state.isSubmitting ? null : _cubit.submit,
                  child: state.isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.confirmContribution),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
