import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text; // Button label
  final TextStyle? textStyle; // Custom text style
  final VoidCallback onPressed; // Callback function
  final double? width; // Width of the button
  final double? height; // Height of the button
  final Color? borderColor; // Border color
  final Color? textColor; // Text color
  final Widget? icon; // Optional leading icon
  final double borderRadius; // Border radius
  final EdgeInsetsGeometry padding; // Padding for button content
  final bool isDisabled; // Whether the button is disabled

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.width,
    this.height,
    this.borderColor,
    this.textColor,
    this.icon,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = !isDisabled;

    return SizedBox(
      width: width?.w,
      height: height?.h,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(padding),
          side: MaterialStateProperty.all(
            BorderSide(color: borderColor ?? Theme.of(context).primaryColor),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          foregroundColor: MaterialStateProperty.all(
            isEnabled ? (textColor ?? Theme.of(context).primaryColor) : Colors.grey,
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
