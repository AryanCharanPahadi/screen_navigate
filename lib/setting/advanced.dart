import 'package:flutter/material.dart';

import '../component/custom_buttons/elevated_button.dart';
import 'bottombar.dart';

class Advanced extends StatelessWidget {
  const Advanced({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            // Make the page scrollable
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Advanced',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Broadcasts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'For creating and setting up broadcast campaigns, please use our website.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 26),
                Container(
                  margin: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bot_20241207T07-39-1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildCircularIndicator(
                              label: 'Successful',
                              percentage: 100,
                              color: Colors.green,
                            ),
                            _buildCircularIndicator(
                              label: 'Read',
                              percentage: 0,
                              color: Colors.grey,
                            ),
                            _buildCircularIndicator(
                              label: 'Replied',
                              percentage: 0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        const Text(
                          'Bot_20241207T07-19-22',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildCircularIndicator(
                              label: 'Successful',
                              percentage: 100,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 16),
                            _buildCircularIndicator(
                              label: 'Read',
                              percentage: 0,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 16),
                            _buildCircularIndicator(
                              label: 'Replied',
                              percentage: 0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        const Text(
                          'Bot_20241207T07-19-07',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildCircularIndicator(
                              label: 'Successful',
                              percentage: 100,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 16),
                            _buildCircularIndicator(
                              label: 'Read',
                              percentage: 0,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 16),
                            _buildCircularIndicator(
                              label: 'Replied',
                              percentage: 0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            text: 'View all',
                            onPressed: () {
                              // Your onPressed logic here
                            },
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            borderRadius: 8.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
          currentIndex: 2), // Use the custom widget
    );
  }

  Widget _buildCircularIndicator({
    required String label,
    required int percentage,
    required Color color,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 5,
                color: color,
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}
