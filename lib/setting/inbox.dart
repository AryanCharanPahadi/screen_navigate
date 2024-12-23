import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screen_navigate/setting/search_screen.dart';
import 'package:screen_navigate/setting/tab_button.dart';
import '../component/custom_buttons/elevated_button.dart';
import '../contacts_directory/contact_controller.dart';
import '../contacts_directory/contact_sync.dart';
import 'bottombar.dart';
import 'chat_item.dart';
import 'date_header.dart';

class ChatInbox extends StatefulWidget {
  const ChatInbox({super.key});

  @override
  State<ChatInbox> createState() => _ChatInboxState();
}

class _ChatInboxState extends State<ChatInbox> {
  int selectedIndex = 0;
  late Future<List<Map<String, String>>>
      contactsFuture; // Future for contacts data

  @override
  void initState() {
    super.initState();
    contactsFuture =
        ContactData().fetchContacts(); // Initialize the contacts fetch
  }

  final ContactController contactController = Get.put(ContactController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showCreateContactBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Wrap(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                          child: Icon(Icons.drag_handle, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Choose Contact",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "WhatsApp number (with Country code) ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: contactController.phoneNumber,
                          decoration: const InputDecoration(
                            labelText: 'Phone No',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 10, right: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '🇮🇳',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '+91',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter phone number';
                            }
                            String pattern = r'^[6-9]\d{9}$';
                            RegExp regex = RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "or",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: contactController.phoneNumber2,
                          decoration: InputDecoration(
                            labelText: 'Select Contact',
                            filled: true,
                            fillColor:
                                Colors.grey[100], // Light grey background
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide.none, // No border when inactive
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide.none, // No border when focused
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter phone number';
                            }
                            String pattern = r'^[6-9]\d{9}$';
                            RegExp regex = RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomElevatedButton(
                              backgroundColor: Colors.green,
                              text: 'Next',
                              onPressed: () {},
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Center(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.green,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.green,
                                  decorationThickness:
                                      1.5, // Underline thickness
                                  height:
                                      3, // Increases line height to create gap
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Inbox",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Tab buttons
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTabButtons(
                        initialSelectedIndex: 0,
                        tabs: const [
                          'All chats',
                          'Active chats',
                          'Broadcast',
                          'Unassigned',
                          'Unread',
                          'Last 24 hours',
                          'Assigned to me',
                          'Favorite only',
                          'Open',
                          'Pending',
                          'Solved Expired',
                          'Blocked knowbot',
                        ],
                        onTabSelected: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.grey[300]),
              // List of messages
              Expanded(
                child: FutureBuilder<List<Map<String, String>>>(
                  future: contactsFuture, // Use the fetched contacts here
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No contacts available'));
                    } else {
                      // Use the fetched data to display chat items
                      List<Widget> chatItems = snapshot.data!.map((contact) {
                        // Parse the dateSubmitted string into a DateTime object
                        String formattedDate =
                            contact['dateSubmitted'] ?? 'Unknown date';

                        try {
                          // Convert the string to DateTime and format it to "21 December"
                          DateTime date = DateTime.parse(formattedDate);
                          formattedDate = DateFormat('d MMM')
                              .format(date); // Format to "21 December"
                        } catch (e) {
                          // If the date format is invalid, fallback to default format
                          formattedDate = 'Invalid date';
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DateHeader(
                                date: formattedDate), // Pass the formatted date
                            ChatItem(
                              name: contact['name']!,
                              message: contact['broadcastSms']!,
                              time: contact[
                                  'currentTime']!, // Example time, adjust as needed
                              status:
                                  'Active', // Adjust based on your status logic
                            ),
                          ],
                        );
                      }).toList();

                      return ListView(children: chatItems);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCreateContactBottomSheet(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }
}
