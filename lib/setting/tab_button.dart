import 'package:flutter/material.dart';

class CustomTabButtons extends StatefulWidget {
  final int initialSelectedIndex; // Initial index for the selected button
  final List<String> tabs; // List of tab names
  final Function(int) onTabSelected; // Callback for when a tab is clicked

  const CustomTabButtons({
    super.key,
    required this.initialSelectedIndex,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  State<CustomTabButtons> createState() => _CustomTabButtonsState();
}

class _CustomTabButtonsState extends State<CustomTabButtons> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enables horizontal scrolling
        child: Row(
          children: widget.tabs.map((tab) {
            final int index = widget.tabs.indexOf(tab);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildTabButton(
                tab,
                index == selectedIndex, // Check if this tab is selected
                () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.onTabSelected(index);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected, VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }
}
