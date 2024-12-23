import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../setting/setting.dart';
import 'detail_screen.dart';

class Automation extends StatefulWidget {
  const Automation({super.key});

  @override
  State<Automation> createState() => _AutomationState();
}

class _AutomationState extends State<Automation> {
  // Map to hold the states of each automation option (On/Off) and the selected timezone
  final Map<String, dynamic> _automationStates = {
    'Timezone': 'GMT +00:00', // Initialize with a default timezone
    'Working Hours': false,
    'Holiday Mode': false,
    'Out of office reply': false,
    'Welcome message': false,
    'Working hours': false,
    'Fallback message': false,
    'Customer service is offline': false,
    'Customers does not respond': false,
    'Expired or closed chat': false,
    'Advanced out of office': false,
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
                              : Icons
                                  .arrow_back, // Default back arrow for other platforms
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
                    'Automations',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Business settings',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Timezone',
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Working Hours',
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Holiday Mode',
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Auto Replies',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Out of office reply',
                    subtitle: 'When it is not working hours',
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Welcome message',
                    subtitle:
                        'When a new chat is started and no keyword search criteria is met',
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Working hours',
                    subtitle:
                        'Users wait more than X minutes without any reply and no keyword matched',
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Fallback message',
                    subtitle: 'When no other automation rule criteria is met',
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Advanced rules',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Customer service is offline',
                    subtitle:
                        'When there are no operators online during working hours',
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Customers does not respond',
                    subtitle:
                        'When chat is not solved, is about to expire and the customer has not responded',
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Expired or closed chat',
                    subtitle:
                        'When a new message is received on an Expired or Solved chat, assigned the chat to last assignee instead of Bot',
                  ),
                  const SizedBox(height: 20),
                  buildListTile(
                    context,
                    title: 'Advanced out of office',
                    subtitle:
                        'When it is not working hours, always send Out of Office message even if keyword match is found',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListTile(BuildContext context,
      {required String title, String? subtitle}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              subtitle: subtitle,
              onToggle: (dynamic value) {
                setState(() {
                  // If the title is 'Timezone', save the selected timezone
                  if (title == 'Timezone') {
                    _automationStates[title] = value['timezone'];
                  } else {
                    _automationStates[title] = value['isEnabled'];
                  }
                });
              },
              currentState: _automationStates[title] is bool
                  ? _automationStates[title] as bool
                  : false, // Ensure a default state
            ),
          ),
        );
      },
      child: ListTile(
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Show On/Off or selected timezone based on the state
            if (title == 'Timezone')
              Text(
                _automationStates[title]!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              )
            else
              Text(
                _automationStates[title]!
                    ? 'On'
                    : 'Off', // Default to 'Off' if not set
                style: TextStyle(
                  fontSize: 14,
                  color: _automationStates[title]! ? Colors.grey : Colors.grey,
                ),
              ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
