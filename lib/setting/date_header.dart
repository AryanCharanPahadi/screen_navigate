import 'package:flutter/material.dart';

class DateHeader extends StatelessWidget {
  final String date;

  const DateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        date,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
      ),
    );
  }
}
