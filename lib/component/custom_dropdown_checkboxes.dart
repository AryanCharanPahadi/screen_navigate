import 'package:flutter/material.dart';

class CustomMultiSelectDropdown extends StatefulWidget {
  final List<String> items; // List of items for the dropdown
  final ValueChanged<List<String>> onChanged; // Callback for selected items
  final String hintText; // Hint text for the dropdown
  final String errorText; // Error text to display
  final bool showError; // Whether to show the error text

  const CustomMultiSelectDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.hintText = "Select items",
    this.errorText = "Please select at least one item.",
    this.showError = false,
  });

  @override
  CustomMultiSelectDropdownState createState() =>
      CustomMultiSelectDropdownState();
}

class CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  final List<String> _selectedItems = []; // List of selected items

  void _toggleSelection(String item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
      widget.onChanged(_selectedItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: null,
          hint: Text(widget.hintText),
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Checkbox(
                    value: _selectedItems.contains(item),
                    onChanged: (_) {
                      _toggleSelection(item);
                    },
                  ),
                  Text(item),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) _toggleSelection(value);
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: widget.showError ? widget.errorText : null,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _selectedItems.map((item) {
            return Chip(
              label: Text(item),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () => _toggleSelection(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
