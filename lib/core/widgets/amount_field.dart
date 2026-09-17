import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:novawallet/core/money/money_input_parser.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    required this.onChangedKobo,
    super.key,
    this.label = 'Amount',
    this.autofocus = false,
  });

  final ValueChanged<int> onChangedKobo;
  final String label;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(label),
          TextFormField(
            autofocus: autofocus,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              CurrencyTextInputFormatter.currency(
                locale: 'en',
                symbol: '',
                decimalDigits: 2,
                enableNegative: false,
                onChange: (formatted) {
                  onChangedKobo(parseNairaInputToKobo(formatted) ?? 0);
                },
              ),
            ],
            style: Theme.of(context).textTheme.headlineMedium,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
                child: Text('₦', style: Theme.of(context).textTheme.headlineMedium),
              ),
              prefixIconConstraints: const BoxConstraints(),
              hintText: '0.00',
            ),
          ),
        ],
      ),
    );
  }
}
