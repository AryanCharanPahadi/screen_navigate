import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  final String text; // Button label
  final TextStyle? textStyle; // Custom text style
  final VoidCallback onPressed; // Callback function
  final Color? textColor; // Text color
  final Widget? icon; // Optional leading icon
  final EdgeInsetsGeometry padding; // Padding for button content
  final bool isDisabled; // Whether the button is disabled

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.textColor,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = !isDisabled;

    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(padding),
        foregroundColor: MaterialStateProperty.all(
          isEnabled ? (textColor ?? Theme.of(context).primaryColor) : Colors.grey,
        ),
      ),
      child: _buildContent(),
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
