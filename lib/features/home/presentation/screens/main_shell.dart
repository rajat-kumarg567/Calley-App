import 'package:calley_app/features/home/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../widgets/app_bottom_nav.dart';



class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _pages = <Widget>[
    DashboardScreen(),
    PlaceholderScreen(title: 'Contacts'),
    PlaceholderScreen(title: 'Calling'),
    PlaceholderScreen(title: 'Call Logs'),
    PlaceholderScreen(title: 'Schedule'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
