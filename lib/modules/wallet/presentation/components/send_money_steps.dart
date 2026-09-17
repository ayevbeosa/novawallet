import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/money/money.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/core/widgets/amount_field.dart';
import 'package:novawallet/core/widgets/app_text_form_field.dart';
import 'package:novawallet/core/widgets/glow_card.dart';
import 'package:novawallet/modules/wallet/presentation/cubits/send_money_cubit.dart';

class StepDots extends StatelessWidget {
  const StepDots({required this.step, super.key, this.totalSteps = 3});

  final int step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Step ${step + 1} of $totalSteps',
      child: Row(
        children: List.generate(totalSteps, (i) {
          final active = i <= step;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: i == totalSteps - 1 ? 0 : 8),
              height: 4,
              decoration: BoxDecoration(
                color: active ? AppColors.cyan : AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class RecipientStep extends StatefulWidget {
  const RecipientStep({required this.cubit, required this.state, super.key});

  final SendMoneyCubit cubit;
  final SendMoneyState state;

  @override
  State<RecipientStep> createState() => _RecipientStepState();
}

class _RecipientStepState extends State<RecipientStep> {
  late final _controller = TextEditingController(text: widget.state.recipient);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.recipientStepTitle, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        AppTextFormField(
          label: l10n.recipientLabel,
          autofocus: true,
          controller: _controller,
          hintText: 'Account number',
          textInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          onChanged: widget.cubit.setRecipient,
        ),
      ],
    );
  }
}

class AmountStep extends StatelessWidget {
  const AmountStep({required this.cubit, required this.state, super.key});

  final SendMoneyCubit cubit;
  final SendMoneyState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.amountStepTitle, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        AmountField(
          label: l10n.amountLabel,
          autofocus: true,
          onChangedKobo: cubit.setAmountKobo,
        ),
        const SizedBox(height: 16),
        Semantics(
          textField: true,
          label: 'Note, optional',
          child: TextField(
            decoration: const InputDecoration(labelText: 'Note (optional)'),
            onChanged: cubit.setNote,
          ),
        ),
      ],
    );
  }
}

class ConfirmStep extends StatelessWidget {
  const ConfirmStep({required this.cubit, required this.state, super.key});

  final SendMoneyCubit cubit;
  final SendMoneyState state;

  @override
  Widget build(BuildContext context) {
    final money = Money.fromKobo(state.amountKobo);
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.confirmStepTitle, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        GlowCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SummaryRow(label: 'To', value: state.recipient),
              const Divider(height: 24),
              SummaryRow(label: 'Amount', value: money.format()),
              if (state.note != null && state.note!.trim().isNotEmpty) ...[
                const Divider(height: 24),
                SummaryRow(label: 'Note', value: state.note!),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
