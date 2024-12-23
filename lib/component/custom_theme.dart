import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      // Define primary color
      primaryColor: Colors.blue,

      // Define the brightness
      brightness: Brightness.light,

      // Define text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          color: Colors.black45,
        ),
      ),

      // Define button styles
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.primary,
      ),

      // Define AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 4.0,
        iconTheme: IconThemeData(color: Colors.white),

      ),

      // Define FloatingActionButton style
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
      ),

      // Define Card theme
      cardTheme: CardTheme(
        elevation: 4.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),

      // Define Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }

  // Dark Theme (Optional)
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white70),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 4.0,
        iconTheme: IconThemeData(color: Colors.white),

      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.blueGrey),
      cardTheme: CardTheme(
        elevation: 4.0,
        color: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }
}
