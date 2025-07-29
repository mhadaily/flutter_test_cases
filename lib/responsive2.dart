import 'package:flutter/material.dart';

/// A widget that displays a [Drawer] on narrow screens and a
/// [NavigationRail] on wider screens.
class ResponsiveWidget extends StatefulWidget {
  const ResponsiveWidget({super.key});

  @override
  State<ResponsiveWidget> createState() => _ResponsiveWidgetState();
}

class _ResponsiveWidgetState extends State<ResponsiveWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Define the breakpoint for switching layouts.
    const double breakpoint = 600.0;
    final screenWidth = MediaQuery.sizeOf(context).width;

    if (screenWidth < breakpoint) {
      // Phone Layout: Use a Scaffold with a Drawer.
      return Scaffold(
        appBar: AppBar(title: const Text('Phone Layout')),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Item 1'),
                selected: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
              ),
              ListTile(
                title: const Text('Item 2'),
                selected: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
            ],
          ),
        ),
        body: const Center(child: Text('Main Content')),
      );
    } else {
      // Tablet/Desktop Layout: Use a Row with a NavigationRail.
      return Scaffold(
        appBar: AppBar(title: const Text('Tablet Layout')),
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('Item 1'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  selectedIcon: Icon(Icons.bookmark),
                  label: Text('Item 2'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            // Main content area
            const Expanded(child: Center(child: Text('Main Content'))),
          ],
        ),
      );
    }
  }
}
