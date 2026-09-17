import 'package:flutter/material.dart';

class TargetDatePicker extends StatelessWidget {
  const TargetDatePicker({required this.targetDate, required this.onPick, super.key});

  final DateTime? targetDate;
  final ValueChanged<DateTime> onPick;

  @override
  Widget build(BuildContext context) {
    final label = targetDate == null
        ? 'Pick a target date'
        : '${targetDate!.year}-${targetDate!.month.toString().padLeft(2, '0')}-${targetDate!.day.toString().padLeft(2, '0')}';
    return Semantics(
      button: true,
      label: 'Target date, $label',
      child: OutlinedButton.icon(
        icon: const Icon(Icons.calendar_month_rounded),
        label: Align(alignment: Alignment.centerLeft, child: Text(label)),
        onPressed: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: now.add(const Duration(days: 90)),
            firstDate: now.add(const Duration(days: 1)),
            lastDate: now.add(const Duration(days: 365 * 5)),
          );
          if (picked != null) onPick(picked);
        },
      ),
    );
  }
}
