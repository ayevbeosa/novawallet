import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.controller,
    required this.label,
    this.hintText = '',
    this.autofocus = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool autofocus;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(label),
          Semantics(
            textField: true,
            label: label,
            readOnly: readOnly,
            onTap: onTap,
            child: TextFormField(
              readOnly: readOnly,
              controller: controller,
              autofocus: autofocus,
              onChanged: onChanged,
              onTap: onTap,
              textCapitalization: textCapitalization,
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: prefixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
