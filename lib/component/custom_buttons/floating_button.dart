import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Icon icon; // Icon inside the button
  final VoidCallback onPressed; // Callback function
  final Color? backgroundColor; // Background color
  final double? size; // Size of the button

  const CustomFloatingActionButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.size = 56.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      child: icon,
      mini: size! <= 40.0,
      heroTag: null,
    );
  }
}
