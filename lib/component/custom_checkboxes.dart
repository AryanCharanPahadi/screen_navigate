import 'package:flutter/material.dart';

class CustomCheckboxList extends StatelessWidget {
  final List<String> items; // List of items to display as checkboxes
  final Map<String, bool> selectedItems; // Map tracking which items are selected
  final ValueChanged<Map<String, bool>> onChanged; // Callback when checkboxes are toggled
  final String errorText; // Error message
  final bool isError; // Whether to show the error message

  const CustomCheckboxList({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    this.errorText = "Please select at least one item.",
    this.isError = false, // Default: No error
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dynamically generate checkboxes from the items list
        for (var item in items)
          Row(
            children: [
              Checkbox(
                value: selectedItems[item] ?? false,
                activeColor: Colors.green, // Set active color to green
                onChanged: (bool? value) {
                  selectedItems[item] = value ?? false;
                  onChanged(selectedItems); // Update the selection state
                },
              ),
              Text(item),
            ],
          ),
        // Display the error message if isError is true
        if (isError) ...[
          const SizedBox(height: 4),
          Text(
            errorText,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value; // The current value of the checkbox (checked or unchecked)
  final ValueChanged<bool?> onChanged; // Callback function when the checkbox is clicked
  final List<Widget> label; // List of widgets (texts, icons, etc.) to be displayed next to the checkbox
  final String? errorText; // Error text to display below the checkbox (if any)

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label, // List of widgets for the label
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: value,
            activeColor: Colors.green, // Set active color to green
            onChanged: onChanged,
          ),
          ...label,
        ],
      ),
    );
  }
}
