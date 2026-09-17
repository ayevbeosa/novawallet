import 'dart:async';

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/modules/wallet/presentation/components/send_money_steps.dart';
import 'package:novawallet/modules/wallet/presentation/components/send_result_view.dart';
import 'package:novawallet/modules/wallet/presentation/cubits/send_money_cubit.dart';

class SendMoneyFlowScreen extends StatefulWidget {
  const SendMoneyFlowScreen({super.key});

  @override
  State<SendMoneyFlowScreen> createState() => _SendMoneyFlowScreenState();
}

class _SendMoneyFlowScreenState extends State<SendMoneyFlowScreen> {
  late final _cubit = SendMoneyCubit(repository: getIt(), connectivity: getIt());

  @override
  void dispose() {
    unawaited(_cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSignalBuilder<SendMoneyCubit, SendMoneyState>(
      bloc: _cubit,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;

        if (state.outcome != null) {
          return SendResultView(state: state);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.sendMoneyTitle),
            leading: IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StepDots(step: state.step.index),
                  const SizedBox(height: 24),
                  Expanded(
                    child: switch (state.step) {
                      SendMoneyStep.recipient => RecipientStep(cubit: _cubit, state: state),
                      SendMoneyStep.amount => AmountStep(cubit: _cubit, state: state),
                      SendMoneyStep.confirm => ConfirmStep(cubit: _cubit, state: state),
                    },
                  ),
                  if (state.validationError != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        switch (state.validationError) {
                          'errorValidRecipient' => l10n.errorValidRecipient,
                          'errorAmountZero' => l10n.errorAmountZero,
                          _ => state.validationError!,
                        },
                        style: const TextStyle(color: AppColors.red),
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              if (state.step == SendMoneyStep.confirm) {
                                unawaited(_cubit.submit());
                              } else {
                                _cubit.next();
                              }
                            },
                      child: state.isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              state.step == SendMoneyStep.confirm ? l10n.confirmSendButton : l10n.continueButton,
                            ),
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
