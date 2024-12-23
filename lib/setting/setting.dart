import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screen_navigate/notification/notification.dart';

import '../automation_page/automation.dart';
import 'bottombar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Account',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.person,
                              size: 30, color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Vinod Kumar',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('Email Id: reach.us@17000ft.org'),
                            Text('Client ID: 332828'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // General Settings Section
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('General Settings',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              buildListTile(
                context,
                title: 'Automations',
                icon: Icons.access_time,
                iconColor: Colors.blue,
                bgColor: Colors.blue[100],
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Automation()),
                  );
                },
              ),
              const SizedBox(height: 20),
              buildListTile(
                context,
                title: 'Notifications',
                icon: Icons.notifications,
                iconColor: Colors.red,
                bgColor: Colors.red[100],
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationSetting()),
                  );
                }
              ),

              const SizedBox(height: 20),

              // Others Section
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Others',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              buildListTile(
                context,
                title: 'Help',
                icon: Icons.help,
                iconColor: Colors.pink,
                bgColor: Colors.pink[100],
              ),
              const SizedBox(height: 20),
              buildListTile(
                context,
                title: 'Terms & Conditions',
                icon: Icons.description,
                iconColor: Colors.green,
                bgColor: Colors.green[100],
              ),
              const SizedBox(height: 20),
              buildListTile(
                context,
                title: 'Logout',
                icon: Icons.logout,
                iconColor: Colors.red,
                bgColor: Colors.red[100],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 3), // Use the custom widget
    );
  }

  // Reusable function for ListTile
  Widget buildListTile(BuildContext context,
      {required String title,
        required IconData icon,
        required Color iconColor,
        required Color? bgColor,
        VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bgColor,
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title),
        trailing: Icon(
          kIsWeb
              ? Icons.arrow_forward // Web uses standard back arrow
              : Platform.isIOS
              ? Icons.arrow_forward_ios // iOS-specific back arrow
              : Icons
              .arrow_forward, // Default back arrow for other platforms
          color: Colors.black,
          size: 16,
        ),
      ),
    );
  }
}