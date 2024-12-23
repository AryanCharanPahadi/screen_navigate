import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatelessWidget {
  final bool isIndeterminate; // Whether the indicator is indeterminate or determinate
  final double? value; // The progress value (from 0.0 to 1.0) for determinate indicator
  final double strokeWidth; // Stroke width for the indicator
  final Color? color; // Color of the indicator
  final Color? backgroundColor; // Background color of the circle
  final String? semanticsLabel; // Semantics label for accessibility
  final String? semanticsValue; // Semantics value for accessibility
  final Widget? child; // Widget to show inside the indicator (optional)

  const CustomCircularIndicator({
    super.key,
    this.isIndeterminate = true,
    this.value,
    this.strokeWidth = 4.0,
    this.color,
    this.backgroundColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: isIndeterminate ? null : value, // Indeterminate or determinate
        strokeWidth: strokeWidth, // Custom stroke width
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Theme.of(context).primaryColor,
        ),
        backgroundColor: backgroundColor ?? Colors.grey[300], // Optional background color
        semanticsLabel: semanticsLabel ?? 'Progress Indicator', // Semantics label for accessibility
        semanticsValue: semanticsValue ?? 'Loading', // Semantics value for accessibility
      ),
    );
  }
}
