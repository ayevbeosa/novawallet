import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/amount_field.dart';
import 'package:novawallet/modules/save/presentation/components/target_date_picker.dart';
import 'package:novawallet/modules/save/presentation/cubits/create_goal_cubit.dart';

class CreateGoalScreen extends StatelessWidget {
  const CreateGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSignalProvider<CreateGoalCubit>(
      create: (_) => CreateGoalCubit(repository: getIt()),
      child: const _CreateGoalView(),
    );
  }
}

class _CreateGoalView extends StatefulWidget {
  const _CreateGoalView();

  @override
  State<_CreateGoalView> createState() => _CreateGoalViewState();
}

class _CreateGoalViewState extends State<_CreateGoalView> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateGoalCubit>();
    final state = context.value<CreateGoalCubit, CreateGoalState>();

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
                  onChanged: cubit.setName,
                ),
              ),
              const SizedBox(height: 16),
              AmountField(
                label: 'Target amount',
                onChangedKobo: (k) => cubit.setTargetAmountKobo(k ?? 0),
              ),
              const SizedBox(height: 16),
              TargetDatePicker(
                targetDate: state.targetDate,
                onPick: cubit.setTargetDate,
              ),
              if (state.validationError != null) ...[
                const SizedBox(height: 12),
                Text(state.validationError!, style: const TextStyle(color: AppColors.red)),
              ],
              const Spacer(),
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
                      : const Text('Create goal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
