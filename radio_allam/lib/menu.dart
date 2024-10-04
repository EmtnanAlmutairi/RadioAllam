import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.radio),
          label: 'الراديو',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'استكشاف',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'المفضلة',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'حسابي',
        ),
      ],
      currentIndex: 0, // Change this based on the selected index
      selectedItemColor: Color(0xFF5852A3), // Color for the selected item
      unselectedItemColor: Colors.grey, // Color for the unselected items
      onTap: (index) {
        // Add your navigation logic here based on the index
      },
    );
  }
}
