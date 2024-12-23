import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items; // List of dropdown items
  final T? selectedItem; // Currently selected item
  final String hint; // Hint text when no item is selected
  final String? Function(T?)? validator; // Validator function for validation
  final void Function(T?) onChanged; // Callback when an item is selected
  final String Function(T)? itemLabelBuilder; // Function to get the label for each item
  final EdgeInsetsGeometry padding; // Padding around the dropdown
  final bool isExpanded; // Whether the dropdown should expand horizontally
  final Color? dropdownColor; // Background color of the dropdown
  final double? height; // Height of the dropdown

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.hint = "Select an option",
    this.validator,
    this.itemLabelBuilder,
    this.padding = const EdgeInsets.all(8.0),
    this.isExpanded = true,
    this.dropdownColor,
    this.height, // Initialize height
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height, // Apply height if provided
        child: DropdownButtonFormField<T>(
          value: selectedItem,
          hint: Text(hint),
          isExpanded: isExpanded,
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          ),
          dropdownColor: dropdownColor,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabelBuilder != null
                  ? itemLabelBuilder!(item)
                  : item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}
