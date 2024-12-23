import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final String labelText; // Label for the date picker
  final DateTime? initialDate; // Initial date
  final DateTime? firstDate; // Earliest selectable date
  final DateTime? lastDate; // Latest selectable date
  final void Function(DateTime)? onDateSelected; // Callback when a date is selected
  final DateTime? selectedDate; // Currently selected date
  final bool enabled; // Whether the picker is enabled
  final String? errorText; // Error message to display
  final TextStyle? labelStyle; // Style for the label
  final TextStyle? dateStyle; // Style for the displayed date
  final TextStyle? errorStyle; // Style for the error message

  const CustomDatePicker({
    super.key,
    required this.labelText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.selectedDate,
    this.enabled = true,
    this.errorText,
    this.labelStyle,
    this.dateStyle,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled
          ? () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(2000),
          lastDate: lastDate ?? DateTime(2100),
        );
        if (pickedDate != null) {
          onDateSelected?.call(pickedDate);
        }
      }
          : null,
      child: AbsorbPointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: labelStyle ?? const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                hintText: selectedDate != null
                    ? _formatDate(selectedDate!)
                    : "Select a date",
                hintStyle: dateStyle ?? const TextStyle(fontSize: 14.0, color: Colors.grey),
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorText: errorText, // Displays error if not null
                errorStyle: errorStyle ?? const TextStyle(color: Colors.red, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Format the selected date to exclude time.
  String _formatDate(DateTime date) {
    return "${date.year}-${_padZero(date.month)}-${_padZero(date.day)}";
  }

  String _padZero(int number) {
    return number < 10 ? '0$number' : '$number';
  }
}
