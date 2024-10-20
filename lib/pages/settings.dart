import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../logic/models/settings_model.dart';

class SettingsPage extends StatefulWidget {
  final Settings settings;
  final Function(Settings) onSettingsChanged;

  const SettingsPage(
      {Key? key, required this.settings, required this.onSettingsChanged})
      : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Settings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.settings;
  }

  void _updateSettings() {
    widget.onSettingsChanged(_settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: _resetToDefaults,
            tooltip: 'Reset to Defaults',
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildThemeSettings(),
          _buildNotificationSettings(),
          _buildDataManagementSettings(),
        ],
      ),
    );
  }

  Widget _buildThemeSettings() {
    return ExpansionTile(
      title: const Text('Theme Settings'),
      children: [
        SwitchListTile(
          title: const Text('Dark Mode'),
          value: _settings.isDarkMode,
          onChanged: (value) {
            setState(() {
              _settings.toggleDarkMode();
              _updateSettings();
            });
          },
        ),
        ListTile(
          title: const Text('Accent Color'),
          trailing: GestureDetector(
            onTap: () => _showColorPicker(),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _settings.accentColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        ListTile(
          title: const Text('Font Size'),
          trailing: DropdownButton<double>(
            value: _settings.fontSize,
            items: [12.0, 14.0, 16.0, 18.0, 20.0].map((double value) {
              return DropdownMenuItem<double>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() {
                  _settings.updateFontSettings(newValue, _settings.fontWeight);
                  _updateSettings();
                });
              }
            },
          ),
        ),
        ListTile(
          title: const Text('Font Weight'),
          trailing: DropdownButton<FontWeight>(
            value: _settings.fontWeight,
            items:
                [FontWeight.normal, FontWeight.bold].map((FontWeight weight) {
              return DropdownMenuItem<FontWeight>(
                value: weight,
                child: Text(weight == FontWeight.normal ? 'Normal' : 'Bold'),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() {
                  _settings.updateFontSettings(_settings.fontSize, newValue);
                  _updateSettings();
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationSettings() {
    return ExpansionTile(
      title: const Text('Notification Settings'),
      children: [
        SwitchListTile(
          title: const Text('Latest Gruuvs'),
          value: _settings.latestGruuvs,
          onChanged: (value) {
            setState(() {
              _settings.latestGruuvs = value;
              _updateSettings();
            });
          },
        ),
        SwitchListTile(
          title: const Text('Comment Mentions'),
          value: _settings.commentMention,
          onChanged: (value) {
            setState(() {
              _settings.commentMention = value;
              _updateSettings();
            });
          },
        ),
        ListTile(
          title: const Text('Journal Reminder'),
          trailing: _settings.journalReminder != null
              ? Text(_settings.journalReminder!.format(context))
              : const Text('Not set'),
          onTap: () => _showTimePicker(),
        ),
      ],
    );
  }

  Widget _buildDataManagementSettings() {
    return ExpansionTile(
      title: const Text('Data Management'),
      children: [
        ListTile(
          title: const Text('Import Data'),
          trailing: const Icon(Icons.file_upload),
          onTap: () {
            // Implement import functionality
          },
        ),
        ListTile(
          title: const Text('Export Data'),
          trailing: const Icon(Icons.file_download),
          onTap: () {
            // Implement export functionality
          },
        ),
        SwitchListTile(
          title: const Text('Lock Journal'),
          value: _settings.lockJournal,
          onChanged: (value) {
            setState(() {
              _settings.lockJournal = value;
              if (value) {
                _showPinDialog();
              } else {
                _settings.pin = null;
              }
            });
          },
        ),
        ListTile(
          title: const Text('Erase Gallery'),
          trailing: const Icon(Icons.delete_forever),
          onTap: () {
            // Show confirmation dialog before erasing
            _showEraseConfirmationDialog('gallery');
          },
        ),
        ListTile(
          title: const Text('Erase Journal'),
          trailing: const Icon(Icons.delete_forever),
          onTap: () {
            // Show confirmation dialog before erasing
            _showEraseConfirmationDialog('journal');
          },
        ),
      ],
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _settings.accentColor,
              onColorChanged: (Color color) {
                setState(() {
                  _settings.accentColor = color;
                  _updateSettings();
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                _updateSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _settings.journalReminder ?? TimeOfDay.now(),
    ).then((selectedTime) {
      if (selectedTime != null) {
        setState(() {
          _settings.setJournalReminder(selectedTime);
          _updateSettings();
        });
      }
    });
  }

  void _showPinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String pin = '';
        return AlertDialog(
          title: const Text('Set 4-digit PIN'),
          content: TextField(
            keyboardType: TextInputType.number,
            maxLength: 4,
            obscureText: true,
            onChanged: (value) {
              pin = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _settings.lockJournal = false;
                });
              },
            ),
            TextButton(
              child: const Text('Set'),
              onPressed: () {
                if (pin.length == 4) {
                  setState(() {
                    _settings.pin = pin;
                    _updateSettings();
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEraseConfirmationDialog(String itemToErase) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erase $itemToErase'),
          content: Text(
              'Are you sure you want to erase your $itemToErase? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Erase'),
              onPressed: () {
                setState(() {
                  if (itemToErase == 'gallery') {
                    _settings.eraseGallery = true;
                  } else if (itemToErase == 'journal') {
                    _settings.eraseJournal = true;
                  }
                });
                Navigator.of(context).pop();
                // Implement actual erase functionality here
              },
            ),
          ],
        );
      },
    );
  }

  void _resetToDefaults() {
    setState(() {
      _settings.resetToDefaults();
      _updateSettings();
    });
  }
}
