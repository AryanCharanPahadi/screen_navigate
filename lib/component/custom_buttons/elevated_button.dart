import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text; // Button label
  final TextStyle? textStyle; // Custom text style
  final VoidCallback onPressed; // Callback function
  final double? width; // Width of the button
  final double? height; // Height of the button
  final Color? backgroundColor; // Background color
  final Color? textColor; // Text color
  final Widget? icon; // Optional leading icon
  final double borderRadius; // Border radius
  final EdgeInsetsGeometry padding; // Padding for button content
  final bool isDisabled; // Whether the button is disabled

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = !isDisabled;

    return SizedBox(
      width: width?.w,
      height: height?.h,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(padding),
          backgroundColor: WidgetStateProperty.all(
            isEnabled
                ? backgroundColor ?? Theme.of(context).primaryColor
                : Colors.grey,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          foregroundColor: WidgetStateProperty.all(
            isEnabled ? (textColor ?? Colors.white) : Colors.white,
          ),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (icon == null) {
      return Text(
        text,
        style: textStyle,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon!,
        SizedBox(width: 8.0.w),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
