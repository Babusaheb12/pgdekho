import 'package:flutter/material.dart';

import '../../../screen/Shortlist/ShortlistScreen.dart';
import '../../../screen/dashbord/home/Dashboard.dart';

class MyHomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final int? initialIndex;

  const MyHomeScreen({
    super.key,
    required this.onToggleTheme,
    this.initialIndex,
  });

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _buildPages(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF14B8A6),
        unselectedItemColor: Colors.grey,
        items: const [
          /// 🏠 Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          /// ❤️ Shortlist (use favorite)
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Shortlist',
          ),

          /// ➕ Add (center action)
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),

          /// 📋 My Listing (use list icon)
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'My Listing',
          ),

          /// 👤 Menu/Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Menu',
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPages() {
    return [
      MyDashboardScreen(),
      ShortlistScreen(),
      _buildPlaceholder('Post Ad'),
      _buildPlaceholder('Messages'),
      _buildPlaceholder('Profile'),
    ];
  }

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            '$title Screen',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Under Construction',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
