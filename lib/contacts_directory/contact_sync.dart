import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../component/custom_snackbar.dart';
import 'contact_modal.dart'; // Adjust according to your project structure

const String baseURL = 'http://192.168.1.8/wati_project/';

class ContactData {
  static Future<void> addContact(
      ContactModal contactModal, BuildContext context) async {
    try {
      Uri url = Uri.parse('${baseURL}contact_add.php'); // API URL

      var response = await http.post(
        url,
        body: {
          'contactName': contactModal.contactName,
          'contactPhoneNumber': contactModal.contactPhoneNumber,
          'broadcastSms': contactModal.broadcastSms,
          'dateSubmitted': contactModal.dateSubmitted,
          'daySubmitted': contactModal.daySubmitted,
          'currentTime': contactModal.currentTime,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['status'] == 'success') {
          if (kDebugMode) {
            print('Contact added successfully!');
          }
          customSnackbar(
            'Success',
            data['message'],
            Colors.green,
            Colors.white,
            Icons.check_circle,
          );
        } else {
          customSnackbar(
            'Error',
            data['message'],
            Colors.red,
            Colors.white,
            Icons.error,
          );
          throw Exception(data['message']);
        }
      } else {
        customSnackbar(
          'Error',
          'Failed to connect to the API',
          Colors.red,
          Colors.white,
          Icons.error,
        );
        throw Exception('Failed to connect to the API');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      customSnackbar(
        'Error',
        e.toString(),
        Colors.red,
        Colors.white,
        Icons.error,
      );
    }
  }

  Future<List<Map<String, String>>> fetchContacts() async {
    try {
      final response = await http.get(Uri.parse('${baseURL}select.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['message'] == 'Contacts fetched successfully') {
          List<Map<String, String>> contacts = [];
          for (var contact in data['data']) {
            contacts.add({
              "id": contact['id'].toString(),
              "name": toProperCase(contact['contactName']!),
              "phone": contact['contactPhoneNumber'],
              "broadcastSms": contact['broadcastSms'],
              "dateSubmitted": contact['dateSubmitted'],
              "daySubmitted": contact['daySubmitted'],
              "currentTime": contact['currentTime'],
            });
          }
          print(contacts);

          customSnackbar(
            'Success',
            data['message'],
            Colors.green,
            Colors.white,
            Icons.check_circle,
          );
          return contacts;
        } else {
          customSnackbar(
            'Error',
            'Failed to fetch contacts',
            Colors.red,
            Colors.white,
            Icons.error,
          );
          throw Exception('Failed to fetch contacts');
        }
      } else {
        customSnackbar(
          'Error',
          'Failed to load data',
          Colors.red,
          Colors.white,
          Icons.error,
        );
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      customSnackbar(
        'Error',
        e.toString(),
        Colors.red,
        Colors.white,
        Icons.error,
      );
      rethrow;
    }
  }

  Future<bool> editContact(
      String id, String name, String phone, String broadcastSms) async {
    try {
      final response = await http.post(
        Uri.parse('${baseURL}edit.php'),
        body: {
          'id': id,
          'contactName': name,
          'contactPhoneNumber': phone,
          'broadcastSms': broadcastSms,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          customSnackbar(
            'Success',
            data['message'],
            Colors.green,
            Colors.white,
            Icons.check_circle,
          );
          return true;
        } else {
          customSnackbar(
            'Error',
            data['message'],
            Colors.red,
            Colors.white,
            Icons.error,
          );
          throw Exception(data['message']);
        }
      } else {
        customSnackbar(
          'Error',
          'Failed to connect to the server',
          Colors.red,
          Colors.white,
          Icons.error,
        );
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      customSnackbar(
        'Error',
        e.toString(),
        Colors.red,
        Colors.white,
        Icons.error,
      );
      rethrow;
    }
  }

  static deleteContact(String id) async {
    try {
      final response = await http.post(
        Uri.parse('${baseURL}delete.php'),
        body: {
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['message'] == 'Contact deleted successfully') {
          customSnackbar(
            'Success',
            data['message'],
            Colors.green,
            Colors.white,
            Icons.check_circle,
          );
          return true;
        } else {
          customSnackbar(
            'Error',
            data['message'],
            Colors.red,
            Colors.white,
            Icons.error,
          );
          throw Exception(data['message']);
        }
      } else {
        customSnackbar(
          'Error',
          'Failed to connect to the server',
          Colors.red,
          Colors.white,
          Icons.error,
        );
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      customSnackbar(
        'Error',
        e.toString(),
        Colors.red,
        Colors.white,
        Icons.error,
      );
      rethrow;
    }
  }

  String toProperCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      return word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '';
    }).join(' ');
  }
}
