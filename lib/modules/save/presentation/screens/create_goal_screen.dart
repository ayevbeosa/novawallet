import 'dart:async';

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/amount_field.dart';
import 'package:novawallet/core/widgets/app_text_form_field.dart';
import 'package:novawallet/modules/save/presentation/cubits/create_goal_cubit.dart';

class CreateGoalScreen extends StatefulWidget {
  const CreateGoalScreen({super.key});

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen> {
  late final _cubit = CreateGoalCubit(repository: getIt());
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    unawaited(_cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocSignalBuilder<CreateGoalCubit, CreateGoalState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.createdGoal != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.pop();
          });
        }

        return Scaffold(
          appBar: AppBar(title: Text(l10n.newSavingsGoal)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextFormField(
                    label: l10n.goalName,
                    controller: _nameController,
                    hintText: l10n.goalNameHint,
                    onChanged: _cubit.setName,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 16),
                  AmountField(
                    label: l10n.targetAmount,
                    onChangedKobo: _cubit.setTargetAmountKobo,
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    controller: _dateController,
                    readOnly: true,
                    label: l10n.pickTargetDate,
                    hintText: l10n.targetDateHint,
                    prefixIcon: const Icon(Icons.calendar_month_rounded),
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: now.add(const Duration(days: 90)),
                        firstDate: now.add(const Duration(days: 1)),
                        lastDate: now.add(const Duration(days: 365 * 5)),
                      );
                      if (picked != null) {
                        _cubit.setTargetDate(picked);
                        _dateController.text = DateFormat('dd, MMM yyyy').format(picked);
                      }
                    },
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
                          : Text(l10n.createGoal),
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
