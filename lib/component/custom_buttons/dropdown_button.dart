import 'package:flutter/material.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items; // Dropdown items
  final T? value; // Current selected value
  final ValueChanged<T?>? onChanged; // Callback function when value is changed

  // Customizable fields for styling
  final double? width; // Width of the dropdown button
  final double? height; // Height of the dropdown button
  final EdgeInsetsGeometry? padding; // Padding inside the dropdown button
  final Color? backgroundColor; // Background color of the button
  final BorderRadiusGeometry? borderRadius; // Border radius of the button
  final TextStyle? textStyle; // Text style of the selected item
  final BoxDecoration? decoration; // BoxDecoration for additional styling

  const CustomDropDownButton({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.textStyle,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration ??
          BoxDecoration(
            color: backgroundColor ?? Colors.white, // Default to white if no background color
            borderRadius: borderRadius ?? BorderRadius.circular(8), // Default border radius
          ),
      child: DropdownButton<T>(
        value: value,
        items: items,
        onChanged: onChanged ?? (value) {},
        isExpanded: true,
        underline: const SizedBox(), // Removes the default underline
        style: textStyle ?? const TextStyle(color: Colors.black), // Default text style
        icon: const Icon(Icons.arrow_drop_down), // Customize the dropdown icon if needed
        iconSize: 24, // Customize the icon size
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0), // Padding inside the dropdown
      ),
    );
  }
}
