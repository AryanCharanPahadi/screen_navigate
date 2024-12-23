import 'package:flutter/material.dart';
import 'package:screen_navigate/setting/setting.dart';

import 'advanced.dart';
import '../contacts_directory/contact.dart';
import 'inbox.dart'; // Update with the actual file name of Advanced

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  // Constructor to accept the current index
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex, // Highlight the selected item
      selectedItemColor: Colors.green, // Color for the selected item-
      unselectedItemColor: Colors.grey, // Color for unselected items
      backgroundColor: Colors.white, // Background color of the bottom bar
      type: BottomNavigationBarType.fixed, // Ensures labels are always visible
      showSelectedLabels: true, // Show labels for selected items
      showUnselectedLabels: true, // Show labels for unselected items
      onTap: (index) {
        // Navigate to the selected screen
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ContactsPage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ChatInbox()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Advanced()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts),
          label: 'Contacts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          label: 'Team Inbox',
        ),
        BottomNavigationBarItem(
          icon:
              Icon(Icons.tune), // Updated Advanced icon for better distinction
          label: 'Advanced',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
