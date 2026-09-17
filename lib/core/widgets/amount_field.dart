import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novawallet/core/money/money_input_parser.dart';

/// A Naira amount entry field. Every keystroke is parsed through
/// [parseNairaInputToKobo] (string/int math only) before reaching
/// [onChangedKobo] — the widget never hands a `double` to its caller.
class AmountField extends StatelessWidget {
  const AmountField({
    required this.onChangedKobo,
    super.key,
    this.label = 'Amount',
    this.autofocus = false,
  });

  final ValueChanged<int?> onChangedKobo;
  final String label;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: label,
      child: Column(
        spacing: 8,
        children: [
          Text(label),
          TextField(
            autofocus: autofocus,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]'))],
            style: Theme.of(context).textTheme.headlineMedium,
            decoration: const InputDecoration(prefixText: '₦ '),
            onChanged: (input) {
              final kobo = parseNairaInputToKobo(input);
              onChangedKobo(kobo);
            },
          ),
        ],
      ),
    );
  }
}
