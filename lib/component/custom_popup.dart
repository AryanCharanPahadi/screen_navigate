import 'package:flutter/material.dart';
class CustomPopup extends StatelessWidget {
  final String title; // Title of the popup
  final String message; // Message content
  final String? confirmText; // Confirm button text
  final String? cancelText; // Cancel button text
  final VoidCallback? onConfirm; // Action on confirm
  final VoidCallback? onCancel; // Action on cancel
  final IconData? icon; // Optional icon for the popup
  final TextStyle? titleStyle; // Custom title text style
  final TextStyle? messageStyle; // Custom message text style

  const CustomPopup({
    super.key,
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.icon,
    this.titleStyle,
    this.messageStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        height: screenHeight * 0.5, // 50% of the screen height
        width: screenWidth * 0.5, // 50% of the screen width
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 40.0,
                  color: Theme.of(context).primaryColor,
                ),
              const SizedBox(height: 16),
              Text(
                title,
                style: titleStyle ??
                    Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: messageStyle ?? Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (cancelText != null)
                    TextButton(
                      onPressed: onCancel ?? () => Navigator.of(context).pop(),
                      child: Text(cancelText!),
                    ),
                  if (confirmText != null)
                    ElevatedButton(
                      onPressed: onConfirm,
                      child: Text(confirmText!),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
