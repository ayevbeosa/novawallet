import 'dart:async';

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/amount_field.dart';
import 'package:novawallet/modules/save/presentation/components/target_date_picker.dart';
import 'package:novawallet/modules/save/presentation/cubits/create_goal_cubit.dart';

/// Owns its `CreateGoalCubit` directly — created via the `late final`
/// initializer, closed in `dispose()` — the same as `SendMoneyFlowScreen`
/// does; this screen was already a `StatefulWidget` for its
/// `TextEditingController`, so there's no reason to also nest a separate
/// `BlocSignalProvider` wrapper widget around it.
class CreateGoalScreen extends StatefulWidget {
  const CreateGoalScreen({super.key});

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen> {
  late final _cubit = CreateGoalCubit(repository: getIt());
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    unawaited(_cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSignalBuilder<CreateGoalCubit, CreateGoalState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.createdGoal != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.pop();
          });
        }

        return Scaffold(
          appBar: AppBar(title: const Text('New savings goal')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Semantics(
                    textField: true,
                    label: 'Goal name',
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Goal name',
                        hintText: 'e.g. Japa fund',
                      ),
                      onChanged: _cubit.setName,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AmountField(
                    label: 'Target amount',
                    onChangedKobo: _cubit.setTargetAmountKobo,
                  ),
                  const SizedBox(height: 16),
                  TargetDatePicker(
                    targetDate: state.targetDate,
                    onPick: _cubit.setTargetDate,
                  ),
                  if (state.validationError != null) ...[
                    const SizedBox(height: 12),
                    Text(state.validationError!, style: const TextStyle(color: AppColors.red)),
                  ],
                  const Spacer(),
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
                          : const Text('Create goal'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
