import 'package:flutter/material.dart';

class BottomNavDrawer extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onPageSelected;

  const BottomNavDrawer({
    super.key,
    required this.currentIndex,
    required this.onPageSelected,
  });

  @override
  State<BottomNavDrawer> createState() => _BottomNavDrawerState();
}

class _BottomNavDrawerState extends State<BottomNavDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;
  bool _showTrailingIcon = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubicEmphasized,
      reverseCurve: Curves.easeInOutCubicEmphasized,
    );
  }

  void _toggleDrawer() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _onPageTap(int index) {
    widget.onPageSelected(index);
    setState(() {
      _showTrailingIcon = index == 0 || index == 2;
    });
    if (_isExpanded) {
      _toggleDrawer();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80 + (_animation.value * 256),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    BottomAppBar(
                      shape: const CircularNotchedRectangle(),
                      notchMargin: 6.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: _toggleDrawer,
                          ),
                          const Text('Gruuvuu'),
                          _showTrailingIcon
                              ? const Icon(Icons.add)
                              : const SizedBox(width: 48, height: 48),
                        ],
                      ),
                    ),
                    if (_isExpanded)
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          children: [
                            _buildNavItem(0, Icons.dashboard, 'Daily'),
                            _buildNavItem(1, Icons.image, 'Gallery'),
                            _buildNavItem(2, Icons.book, 'Journal'),
                            _buildNavItem(3, Icons.settings, 'Settings'),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNavItem(int index, IconData icon, String title) {
    final isSelected = widget.currentIndex == index;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
          ),
          onTap: () => _onPageTap(index),
        ),
      ),
    );
  }
}
