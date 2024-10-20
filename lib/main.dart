import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gruuvuu/theme.dart';
import 'package:gruuvuu/pages/home_page.dart';
import 'logic/services/providers/settings_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          final settings = settingsProvider.settings;
          return MaterialApp(
            theme: appTheme(
              isDarkMode: settings.isDarkMode,
              accentColor: settings.accentColor,
              fontSize: settings.fontSize,
              fontWeight: settings.fontWeight,
            ),
            darkTheme: settings.isDarkMode
                ? appTheme(
                    isDarkMode: settings.isDarkMode,
                    accentColor: settings.accentColor,
                    fontSize: settings.fontSize,
                    fontWeight: settings.fontWeight,
                  )
                : null,
            themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
            debugShowCheckedModeBanner: false,
            title: 'Gruuvuu',
          );
        },
      ),
    ),
  );
}
