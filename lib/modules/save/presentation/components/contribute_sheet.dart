import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/amount_field.dart';
import 'package:novawallet/modules/save/presentation/cubits/contribute_cubit.dart';

/// Modal bottom sheet for contributing to a single goal. One
/// [ContributeCubit] per sheet instance — mirrors the Send Money flow's
/// guarantee that an idempotency key is minted exactly once per attempt.
class ContributeSheet extends StatelessWidget {
  const ContributeSheet({required this.goalId, required this.goalName, super.key});

  final String goalId;
  final String goalName;

  @override
  Widget build(BuildContext context) {
    return BlocSignalProvider<ContributeCubit>(
      create: (_) => ContributeCubit(
        repository: getIt(),
        connectivity: getIt(),
        goalId: goalId,
        goalName: goalName,
      ),
      child: const _ContributeSheetView(),
    );
  }
}

class _ContributeSheetView extends StatelessWidget {
  const _ContributeSheetView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ContributeCubit>();
    final state = context.value<ContributeCubit, ContributeState>();

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
              offline ? 'Pending — will send when back online' : 'Contribution queued',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Done'),
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
          Text('Contribute', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          AmountField(autofocus: true, onChangedKobo: (k) => cubit.setAmountKobo(k ?? 0)),
          if (state.validationError != null) ...[
            const SizedBox(height: 8),
            Text(state.validationError!, style: const TextStyle(color: AppColors.red)),
          ],
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: state.isSubmitting ? null : cubit.submit,
              child: state.isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Confirm contribution'),
            ),
          ),
        ],
      ),
    );
  }
}
