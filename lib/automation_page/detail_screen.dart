import 'package:flutter/material.dart';
import '../component/custom_dropdown.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool currentState;
  final String?
      selectedTimezone; // Add a parameter to pass the selected timezone
  final ValueChanged<Map<String, dynamic>> onToggle;

  const DetailScreen({
    super.key,
    required this.title,
    this.subtitle,
    required this.onToggle,
    required this.currentState,
    this.selectedTimezone, // Initialize selectedTimezone
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool _isEnabled;
  String? _selectedTimezone;
  final List<String> _timezones = [
    'GMT -12:00',
    'GMT -11:00',
    'GMT -10:00',
    'GMT -09:00',
    'GMT -08:00',
    'GMT -07:00',
    'GMT -06:00',
    'GMT -05:00',
    'GMT -04:00',
    'GMT -03:00',
    'GMT -02:00',
    'GMT -01:00',
    'GMT +00:00',
    'GMT +01:00',
    'GMT +02:00',
    'GMT +03:00',
    'GMT +04:00',
    'GMT +05:00',
    'GMT +06:00',
    'GMT +07:00',
    'GMT +08:00',
    'GMT +09:00',
    'GMT +10:00',
    'GMT +11:00',
    'GMT +12:00'
  ];

  final Map<String, bool> _workingDaysState = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.currentState;
    _selectedTimezone = widget.selectedTimezone ??
        'GMT +00:00'; // Set default or selected timezone
  }

  void _save() {
    widget.onToggle({
      'isEnabled': _isEnabled,
      'timezone': _selectedTimezone,
      'workingHours': _workingDaysState, // Include working hours state in save
    });
    Navigator.pop(context); // Go back to the Automation screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false, // Remove back icon
      ),
      body: Stack(
        children: [

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (widget.title == 'Timezone' ||
                        widget.title == 'Working Hours' ||
                        widget.title == 'Holiday Mode') ...[
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ] else if (widget.title == 'Advanced out of office' ||
                        widget.title == 'Expired or closed chat') ...[
                      const Text(
                        "Option",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ] else ...[
                      const Text(
                        "Auto Reply",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 20),
                if (widget.title == 'Holiday Mode') ...[
                  const Text(
                    'When holiday mode is on, users will be replied with out of office hour reply',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ] else if (widget.title == 'Timezone') ...[
                  const Text(
                    'Select your preferred timezone:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  CustomDropdown<String>(
                    items: _timezones,
                    selectedItem: _selectedTimezone,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTimezone = newValue!;
                      });
                    },
                    hint: 'Select a timezone',
                    isExpanded: true,
                  ),
                ] else if (widget.title == 'Working Hours') ...[
                  const Text(
                    'Set your working hours for each day:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _workingDaysState.keys.length,
                      itemBuilder: (context, index) {
                        final day = _workingDaysState.keys.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                day,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Switch(
                                value: _workingDaysState[day]!,
                                onChanged: (value) {
                                  setState(() {
                                    _workingDaysState[day] = value;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ] else ...[
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
                const SizedBox(height: 30),
                if (widget.title != 'Timezone' &&
                    widget.title != 'Working Hours') ...[
                  // Only show the switch if title is not 'Timezone'
                  Row(
                    children: [
                      Switch(
                        value: _isEnabled,
                        onChanged: (value) {
                          setState(() {
                            _isEnabled = value;
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      Text(
                        _isEnabled ? 'On' : 'Off',
                        style: TextStyle(
                          fontSize: 16,
                          color: _isEnabled ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 40),
              ],
            ),
          ),
          const Positioned(
            right: 16,
            bottom: 80,
            left: 16,
            child: Divider(),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: TextButton(
              onPressed: _save,
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
