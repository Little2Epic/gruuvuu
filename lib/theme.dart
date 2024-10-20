import 'package:flutter/material.dart';

ThemeData appTheme({
  bool isDarkMode = false,
  Color accentColor = Colors.orange,
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.normal,
}) {
  final brightness = isDarkMode ? Brightness.dark : Brightness.light;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: brightness,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      bodyMedium: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      // Add other text styles as needed
    ),
  );
}

IconThemeData iconTheme({required ColorScheme colorScheme}) {
  return IconThemeData(
    color: colorScheme.onPrimaryContainer,
    size: 24,
  );
}

IconButtonThemeData iconButtonTheme({required ColorScheme colorScheme}) {
  return IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: colorScheme.onPrimaryContainer,
    ),
  );
}

// Helper function to get the current theme's color scheme
ColorScheme currentColorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}
