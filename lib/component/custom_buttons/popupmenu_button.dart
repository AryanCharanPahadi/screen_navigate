import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<PopupMenuEntry<String>> itemList; // Menu items
  final ValueChanged<String> onSelected; // Callback when item is selected

  const CustomPopupMenuButton({
    super.key,
    required this.itemList,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return itemList;
      },
      onSelected: onSelected,
    );
  }
}
