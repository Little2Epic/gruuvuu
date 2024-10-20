import 'package:flutter/material.dart';

class Settings {
  // Theme Settings
  bool isDarkMode; // Light/Dark mode
  Color accentColor; // Accent color
  double fontSize; // Font size
  FontWeight fontWeight; // Font weight

  // Notification Settings
  bool latestGruuvs; // Notify for latest Gruuvs
  bool commentMention; // Notify for comment mentions
  TimeOfDay? journalReminder; // Time of day for journal reminders

  // Data Management
  bool importData; // Option for importing data
  bool exportData; // Option for exporting data
  bool lockJournal; // Lock journal with PIN
  String? pin; // 4-digit PIN for locking the journal
  bool eraseGallery; // Option to erase gallery
  bool eraseJournal; // Option to erase journal

  Settings({
    this.isDarkMode = false, // Default to light mode
    this.accentColor = Colors.orange, // Default accent color
    this.fontSize = 14.0, // Default font size
    this.fontWeight = FontWeight.normal, // Default font weight
    this.latestGruuvs = true, // Default notification setting
    this.commentMention = true, // Default notification setting
    this.journalReminder, // Default to null (no reminder set)
    this.importData = false, // Default to no import
    this.exportData = false, // Default to no export
    this.lockJournal = false, // Default to no lock
    this.pin, // Default to null (no pin)
    this.eraseGallery = false, // Default to false
    this.eraseJournal = false, // Default to false
  });

  // Method to toggle dark mode
  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
  }

  // Method to update font settings
  void updateFontSettings(double newSize, FontWeight newWeight) {
    fontSize = newSize;
    fontWeight = newWeight;
  }

  // Method to set the journal reminder
  void setJournalReminder(TimeOfDay time) {
    journalReminder = time;
  }

  // Method to get the next reminder DateTime
  DateTime getNextJournalReminderDate(DateTime currentDateTime) {
    if (journalReminder != null) {
      DateTime nextReminder = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
        journalReminder!.hour,
        journalReminder!.minute,
      );

      // If the reminder time has already passed today, set it for tomorrow
      if (nextReminder.isBefore(currentDateTime)) {
        nextReminder = nextReminder.add(const Duration(days: 1));
      }

      return nextReminder;
    }
    return DateTime.now(); // Return current time if no reminder set
  }

  // Method to reset settings to defaults
  void resetToDefaults() {
    isDarkMode = false;
    accentColor = Colors.blue;
    fontSize = 14.0;
    fontWeight = FontWeight.normal;
    latestGruuvs = true;
    commentMention = true;
    journalReminder = null; // Reset to no reminder
    importData = false;
    exportData = false;
    lockJournal = false;
    pin = null;
    eraseGallery = false;
    eraseJournal = false;
  }

  static Settings fromMap(Map<String, dynamic> settingsMap) {
    return Settings(
      isDarkMode: settingsMap['isDarkMode'] as bool? ?? false,
      accentColor:
          Color(settingsMap['accentColor'] as int? ?? Colors.orange.value),
      fontSize: settingsMap['fontSize'] as double? ?? 14.0,
      fontWeight: FontWeight.values[settingsMap['fontWeight'] as int? ?? 0],
      latestGruuvs: settingsMap['latestGruuvs'] as bool? ?? true,
      commentMention: settingsMap['commentMention'] as bool? ?? true,
      journalReminder: settingsMap['journalReminder'] != null
          ? TimeOfDay(
              hour: settingsMap['journalReminder']['hour'] as int,
              minute: settingsMap['journalReminder']['minute'] as int)
          : null,
      importData: settingsMap['importData'] as bool? ?? false,
      exportData: settingsMap['exportData'] as bool? ?? false,
      lockJournal: settingsMap['lockJournal'] as bool? ?? false,
      pin: settingsMap['pin'],
      eraseGallery: settingsMap['eraseGallery'] as bool? ?? false,
      eraseJournal: settingsMap['eraseJournal'] as bool? ?? false,
    );
  }

  Object? toMap() {
    return {
      'isDarkMode': isDarkMode,
      'accentColor': accentColor.value,
      'fontSize': fontSize,
      'fontWeight': fontWeight.index,
      'latestGruuvs': latestGruuvs,
      'commentMention': commentMention,
      'journalReminder': journalReminder?.toString(),
      'importData': importData,
      'exportData': exportData,
      'lockJournal': lockJournal,
      'pin': pin,
      'eraseGallery': eraseGallery,
      'eraseJournal': eraseJournal,
    };
  }
}
