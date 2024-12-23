import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../component/custom_buttons/elevated_button.dart';
import '../component/custom_checkboxes.dart';
import '../setting/bottombar.dart';
import 'contact_controller.dart';
import 'contact_modal.dart';
import 'contact_sync.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  ContactsPageState createState() => ContactsPageState();
}

class ContactsPageState extends State<ContactsPage> {
  final ContactController contactController = Get.put(ContactController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, String>> contacts = [];

  @override
  void initState() {
    super.initState();
    _showLoader();
  }

  void _showLoader() async {
    // Show the loader initially
    setState(() {
      _isLoading = true;
    });

    // Wait for 5 seconds
    await Future.delayed(const Duration(seconds: 2));

    // After 5 seconds, hide the loader and fetch contacts
    setState(() {
      _isLoading = false;
    });

    fetchContacts();
  }

  bool _isLoading = false;
  void fetchContacts() async {
    try {
      final contactService = ContactData();
      final fetchedContacts = await contactService.fetchContacts();
      setState(() {
        contacts = fetchedContacts;
      });
    } catch (e) {
      // Handle error (e.g., show a message to the user)
      if (kDebugMode) {
        print('Error fetching contacts: $e');
      }
    }
  }

  String searchQuery = '';

  List<Map<String, String>> get filteredContacts {
    if (searchQuery.isEmpty) {
      return contacts;
    } else {
      return contacts
          .where((contact) =>
              contact['name']!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              contact['phone']!.contains(searchQuery))
          .toList();
    }
  }

  void showCreateContactBottomSheet(BuildContext context,
      {Map<String, String>? contact}) {
    String allowBroadcastText =
        ''; // To store the text of the selected checkbox
    String allowSmsText = ''; // To store the text of the selected checkbox

    // Pre-fill form fields if a contact is provided

    if (contact != null) {
      contactController.contactName.text = contact['name'] ?? '';
      contactController.phoneNumber.text = contact['phone'] ?? '';

      // Parse the broadcastSms field if it exists
      if (contact['broadcastSms'] != null &&
          contact['broadcastSms']!.isNotEmpty) {
        Map<String, dynamic> broadcastSmsData =
            jsonDecode(contact['broadcastSms']!);

        // Set the checkbox values based on the broadcastSms map
        allowSmsText = broadcastSmsData['allowSms'] == true ? 'Allow SMS' : '';
        allowBroadcastText =
            broadcastSmsData['allowBroadcast'] == true ? 'Allow Broadcast' : '';
      }
    } else {
      // Clear the fields for a new contact
      contactController.contactName.clear();
      contactController.phoneNumber.clear();
    }

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
                        Text(
                          contact == null ? "Create Contact" : "Edit Contact",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 30),
                        TextFormField(
                          controller: contactController.contactName,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter contact name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: contactController.phoneNumber,
                          decoration: InputDecoration(
                            labelText: 'Phone No',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                        const SizedBox(height: 20),
                        // Show the checkbox and check it based on the pre-filled data
                        CustomCheckbox(
                          value: allowBroadcastText == "Allow Broadcast",
                          onChanged: (value) {
                            setState(() {
                              allowBroadcastText =
                                  value ?? false ? "Allow Broadcast" : '';
                            });
                          },
                          label: const [Text("Allow Broadcast")],
                        ),
                        CustomCheckbox(
                          value: allowSmsText == "Allow SMS",
                          onChanged: (value) {
                            setState(() {
                              allowSmsText = value ?? false ? "Allow SMS" : '';
                            });
                          },
                          label: const [Text("Allow SMS")],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                              width: double.infinity,
                              child: CustomElevatedButton(
                                text: contact == null ? 'Save' : 'Update',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Map<String, bool> broadcastSmsMap = {};

                                    if (allowSmsText.isNotEmpty) {
                                      broadcastSmsMap['allowSms'] = true;
                                    } else {
                                      broadcastSmsMap['allowSms'] = false;
                                    }

                                    if (allowBroadcastText.isNotEmpty) {
                                      broadcastSmsMap['allowBroadcast'] = true;
                                    } else {
                                      broadcastSmsMap['allowBroadcast'] = false;
                                    }

                                    // Convert the map to a JSON string
                                    String broadcastSms =
                                        json.encode(broadcastSmsMap);

                                    // Get the current date, day, and time
                                    DateTime now = DateTime.now();
                                    String currentDate =
                                        '${now.year}-${now.month}-${now.day}';
                                    String currentDay = now.weekday == 1
                                        ? 'Monday'
                                        : now.weekday == 2
                                            ? 'Tuesday'
                                            : now.weekday == 3
                                                ? 'Wednesday'
                                                : now.weekday == 4
                                                    ? 'Thursday'
                                                    : now.weekday == 5
                                                        ? 'Friday'
                                                        : now.weekday == 6
                                                            ? 'Saturday'
                                                            : 'Sunday';

                                    // Format the current time to 12-hour format with AM/PM (e.g., 2:30 A.M or 3:00 P.M)
                                    String currentTime =
                                        DateFormat('h:mm a').format(now);

                                    if (contact == null) {
                                      // Creating a new contact
                                      ContactModal contactModal = ContactModal(
                                        contactName:
                                            contactController.contactName.text,
                                        contactPhoneNumber:
                                            contactController.phoneNumber.text,
                                        broadcastSms:
                                            broadcastSms, // Store the text
                                        dateSubmitted:
                                            currentDate, // Store the date
                                        daySubmitted:
                                            currentDay, // Store the day
                                        currentTime:
                                            currentTime, // Store the formatted time (e.g., 2:30 A.M)
                                      );
                                      await ContactData.addContact(
                                          contactModal, context);
                                    } else {
                                      // Updating an existing contact
                                      await ContactData().editContact(
                                        contact['id']!,
                                        contactController.contactName.text,
                                        contactController.phoneNumber.text,
                                        broadcastSms,
                                      );
                                    }

                                    // Clear the text fields and close the bottom sheet
                                    contactController.contactName.clear();
                                    contactController.phoneNumber.clear();
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      Navigator.pop(context);
                                    });

                                    fetchContacts(); // Trigger data fetch
                                  }
                                },
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                borderRadius: 8.0,
                              )),
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
                              ),
                            ),
                          ),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green,))
          : Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Contacts',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () {
                                setState(() {});
                                fetchContacts(); // Trigger data fetch
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  showCreateContactBottomSheet(context),
                            ),
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.filter_list),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Search box
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  // Contact list

                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredContacts.length,
                      itemBuilder: (context, index) {
                        final contact = filteredContacts[index];

                        // Decode the broadcastSms JSON string into a Map
                        final Map<String, dynamic> broadcastSmsData =
                            jsonDecode(contact['broadcastSms']!);

                        if (kDebugMode) {
                          print(jsonDecode(contact['broadcastSms']!));
                        }
                        // Get the individual values for the checkboxes
                        bool allowSms = broadcastSmsData['allowSms'] ?? false;
                        bool allowBroadcast =
                            broadcastSmsData['allowBroadcast'] ?? false;

                        return InkWell(
                          onTap: () {
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
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: Wrap(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Center(
                                                child: Icon(
                                                  Icons.drag_handle,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                "Contact Details",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    contact['name']!,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  IconButton(
                                                    icon: Icon(
                                                      kIsWeb
                                                          ? Icons.edit
                                                          : Platform.isIOS
                                                              ? Icons.edit_note
                                                              : Icons.edit,
                                                    ),
                                                    onPressed: () {
                                                      showCreateContactBottomSheet(
                                                        context,
                                                        contact: contact,
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(width: 10),
                                                  IconButton(
                                                    icon: Icon(
                                                      kIsWeb
                                                          ? Icons.delete
                                                          : Platform.isIOS
                                                              ? Icons
                                                                  .delete_forever
                                                              : Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () async {
                                                      final bool? isConfirmed =
                                                          await showDialog<
                                                              bool>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return kIsWeb ||
                                                                  !Platform
                                                                      .isIOS
                                                              ? AlertDialog(
                                                                  title: const Text(
                                                                      'Delete Confirmation'),
                                                                  content:
                                                                      const Text(
                                                                          'Are you sure you want to delete this contact?'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(false); // Cancel deletion
                                                                      },
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(true); // Confirm deletion
                                                                      },
                                                                      child: const Text(
                                                                          'Delete',
                                                                          style:
                                                                              TextStyle(color: Colors.red)),
                                                                    ),
                                                                  ],
                                                                )
                                                              : CupertinoAlertDialog(
                                                                  title: const Text(
                                                                      'Delete Confirmation'),
                                                                  content:
                                                                      const Text(
                                                                          'Are you sure you want to delete this contact?'),
                                                                  actions: [
                                                                    CupertinoDialogAction(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(false); // Cancel deletion
                                                                      },
                                                                      child: const Text(
                                                                          'Cancel'),
                                                                    ),
                                                                    CupertinoDialogAction(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(true); // Confirm deletion
                                                                      },
                                                                      isDestructiveAction:
                                                                          true,
                                                                      child: const Text(
                                                                          'Delete'),
                                                                    ),
                                                                  ],
                                                                );
                                                        },
                                                      );

                                                      if (isConfirmed == true) {
                                                        // Perform delete operation
                                                        bool isDeleted =
                                                            await ContactData
                                                                .deleteContact(
                                                                    contact[
                                                                        'id']!);

                                                        if (isDeleted) {
                                                          setState(() {
                                                            filteredContacts
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        }
                                                        fetchContacts();
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                "Phone Number",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                contact['phone']!,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),

                                              const SizedBox(height: 10),

                                              // Display checkboxes based on the parsed values

                                              CustomCheckbox(
                                                value: allowBroadcast,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                label: const [
                                                  Text("Allow Broadcast")
                                                ],
                                              ),

                                              CustomCheckbox(
                                                value: allowSms,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                label: const [
                                                  Text("Allow SMS")
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: ListTile(
                            title: Text(
                              contact['name']!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(contact['phone']!),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
      bottomNavigationBar: const CustomBottomNavigationBar(
          currentIndex: 0), // Use the custom widget
    );
  }
}
