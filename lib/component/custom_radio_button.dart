import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final List<T> values; // List of values to be used for the radio buttons
  final T? groupValue; // The currently selected value in the group
  final ValueChanged<T?> onChanged; // Callback to handle changes in selection
  final String Function(T value)?
      itemBuilder; // Function to build the label text for each value
  final Color activeColor; // Color of the selected radio button
  final Color inactiveColor; // Color of the unselected radio button
  final double size; // Size of the radio button
  final EdgeInsetsGeometry? padding; // Padding for the widget
  final bool isExpanded; // Whether the button should expand horizontally
  final String? errorMessage; // Error message to display if validation fails
  final bool showError; // Flag to show error message or not

  const CustomRadioButton({
    Key? key,
    required this.values,
    required this.groupValue,
    required this.onChanged,
    this.itemBuilder = defaultItemBuilder,
    this.activeColor = Colors.blue, // Default active color
    this.inactiveColor = Colors.grey, // Default inactive color
    this.size = 24.0, // Default size of the radio button
    this.padding,
    this.isExpanded = false, // Default to not expanded
    this.errorMessage, // Error message (optional)
    this.showError = false, // Whether to show error message (optional)
  }) : super(key: key);

  static String defaultItemBuilder(dynamic value) {
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Render the radio button options
        ...values.map<Widget>((value) {
          return Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => onChanged(
                      value), // Select radio button when the text is clicked
                  child: Radio<T>(
                    value: value,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    activeColor: activeColor,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                GestureDetector(
                  onTap: () => onChanged(
                      value), // Select radio button when the text is clicked
                  child: Text(
                    itemBuilder!(value),
                    style: TextStyle(
                      color: groupValue == value ? activeColor : inactiveColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),

        // Display the error message if showError is true and no option is selected
        if (showError && groupValue == null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorMessage ??
                  'Please select an option', // Default error message if none provided
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
