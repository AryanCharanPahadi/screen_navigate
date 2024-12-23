import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoSwitch
import '../setting/setting.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  // Map to store the toggle state of each notification setting
  final Map<String, bool> notificationToggles = {
    'New Chat': false,
    'New message on chat': false,
    'New chat assigned to agent': false,
    'New message on assigned chat': false,
    'New chat assigned to team': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      kIsWeb
                          ? Icons.arrow_back // Web uses standard back arrow
                          : Platform.isIOS
                          ? Icons.arrow_back_ios // iOS-specific back arrow
                          : Icons.arrow_back, // Default back arrow for other platforms
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      );
                    },
                  ),
                  const Text(
                    'Set\nNotification',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Build ListTiles dynamically from the map
                  ...notificationToggles.entries.map((entry) {
                    return Column(
                      children: [
                        buildListTile(
                          context,
                          title: entry.key,
                          subtitle: _getSubtitle(entry.key),
                          isEnabled: entry.value,
                          onToggle: (bool value) {
                            setState(() {
                              notificationToggles[entry.key] = value; // Update specific toggle state
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to get subtitle for each notification type
  String? _getSubtitle(String title) {
    switch (title) {
      case 'New Chat':
        return 'When a new chat is initiated';
      case 'New message on chat':
        return 'When a new message is received';
      case 'New chat assigned to agent':
        return 'When a new chat is assigned to agent';
      case 'New message on assigned chat':
        return 'When a new message is received on an assigned chat';
      case 'New chat assigned to team':
        return 'When a new chat is assigned to your team';
      default:
        return null;
    }
  }

  Widget buildListTile(BuildContext context,
      {required String title,
        String? subtitle,
        required bool isEnabled,
        required ValueChanged<bool> onToggle}) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          if (subtitle != null)
            const SizedBox(height: 4), // Adjust height as needed
          if (subtitle != null)
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
      trailing: _buildPlatformSpecificToggle(isEnabled, onToggle),
    );
  }

  // Function to return platform-specific toggle
  Widget _buildPlatformSpecificToggle(bool isEnabled, ValueChanged<bool> onToggle) {
    if (kIsWeb) {
      // Web-specific toggle
      return Switch(
        value: isEnabled,
        onChanged: onToggle,
        activeColor: Colors.green,
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey.shade300,
      );
    } else if (Platform.isIOS) {
      // iOS-specific toggle
      return CupertinoSwitch(
        value: isEnabled,
        onChanged: onToggle,
        activeColor: Colors.green,
        trackColor: Colors.grey.shade300,
      );
    } else if (Platform.isAndroid) {
      // Android-specific toggle
      return Switch(
        value: isEnabled,
        onChanged: onToggle,
        activeColor: Colors.green,
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey.shade300,
      );
    } else {
      // Default fallback toggle
      return Switch(
        value: isEnabled,
        onChanged: onToggle,
        activeColor: Colors.green,
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey.shade300,
      );
    }
  }
}
