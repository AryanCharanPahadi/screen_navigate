import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSplashScreen extends StatefulWidget {
  final String? backgroundImage;
  final String? logoImage;
  final double? logoWidth;
  final double? logoHeight;
  final Duration duration;
  final Widget Function(BuildContext context) navigateTo;

  const CustomSplashScreen({
    Key? key,
    this.backgroundImage,
    this.logoImage,
    this.logoWidth = 150.0,
    this.logoHeight = 150.0,
    this.duration = const Duration(seconds: 3),
    required this.navigateTo,
  }) : super(key: key);

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();

    // Schedule navigation after the specified duration
    Future.delayed(widget.duration, () {
      if (mounted) {
        // Check if the widget is still in the tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => widget.navigateTo(context)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.backgroundImage != null)
            Image.asset(
              widget.backgroundImage!,
              fit: BoxFit.cover,
            ),
          if (widget.logoImage != null)
            Center(
              child: Image.asset(
                widget.logoImage!,
                width: widget.logoWidth!.w,
                height: widget.logoHeight!.h,
              ),
            ),
        ],
      ),
    );
  }
}
