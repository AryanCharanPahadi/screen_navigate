import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextStyle? style;
  final TextDirection? textDirection;
  final bool asterisk;

  const CustomText(
      this.text, {
        super.key,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.textAlign,
        this.decoration,
        this.overflow,
        this.maxLines,
        this.letterSpacing,
        this.wordSpacing,
        this.style,
        this.textDirection,
        this.asterisk = false, // Default is false
      });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      text: TextSpan(
        text: text,
        style: style?.copyWith(
          color: color,
          fontSize: fontSize != null ? fontSize!.sp : 14.sp,
          fontWeight: fontWeight,
          decoration: decoration,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
        ) ??
            TextStyle(
              color: color ?? Colors.black,
              fontSize: fontSize != null ? fontSize!.sp : 14.sp,
              fontWeight: fontWeight ?? FontWeight.normal,
              decoration: decoration,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
            ),
        children: asterisk
            ? [
          TextSpan(
            text: ' *',
            style: TextStyle(
              color: Colors.red,
              fontSize: fontSize != null ? fontSize!.sp : 14.sp,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ]
            : [],
      ),
    );
  }
}
