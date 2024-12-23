import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon; // The icon for the button
  final VoidCallback onPressed; // Callback function
  final Color? iconColor; // Icon color
  final double? iconSize; // Icon size
  final double? padding; // Padding for the button

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.iconSize,
    this.padding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      color: iconColor,
      iconSize: iconSize ?? 24.0,
      padding: EdgeInsets.all(padding!),
    );
  }
}
