import 'package:flutter/material.dart';

class CustomInkWellButton extends StatelessWidget {
  final String text; // Button label
  final VoidCallback onTap; // Callback function
  final Color? splashColor; // Splash color
  final Color? highlightColor; // Highlight color
  final TextStyle? textStyle; // Custom text style

  const CustomInkWellButton({
    super.key,
    required this.text,
    required this.onTap,
    this.splashColor,
    this.highlightColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: splashColor ?? Theme.of(context).primaryColor,
      highlightColor: highlightColor ?? Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: textStyle ?? const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
