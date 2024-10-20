import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/services/providers/settings_provider.dart';
import 'daily.dart';
import 'gallery.dart';
import 'journal.dart';
import 'settings.dart';
import '../widgets/bottom_nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = [
      const DailyPage(),
      const GalleryPage(),
      const JournalPage(),
      SettingsPage(
        settings: Provider.of<SettingsProvider>(context).settings,
        onSettingsChanged: Provider.of<SettingsProvider>(context).saveSettings,
      ),
    ];
  }

  void _onPageSelected(int index) {
    if (mounted && _currentIndex != index) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _pages[_currentIndex],
        BottomNavDrawer(
          onPageSelected: _onPageSelected,
          currentIndex: _currentIndex,
        ),
      ],
    ));
  }
}
