import 'dart:convert';

ContactModal contactModalFromJson(String str) =>
    ContactModal.fromJson(json.decode(str));

String contactModalToJson(ContactModal data) => json.encode(data.toJson());

class ContactModal {
  String? contactName;
  String? contactPhoneNumber;
  final String broadcastSms; // Change to String type
  final String dateSubmitted; // Change to String type
  final String daySubmitted; // Change to String type
  final String currentTime; // Change to String type

  ContactModal({
    this.contactName,
    this.contactPhoneNumber,
    required this.broadcastSms,
    required this.dateSubmitted,
    required this.daySubmitted,
    required this.currentTime,
  });

  factory ContactModal.fromJson(Map<String, dynamic> json) => ContactModal(
        contactName: json["contactName"],
        contactPhoneNumber: json["contactPhoneNumber"],
        broadcastSms: json["broadcastSms"],
    dateSubmitted: json["dateSubmitted"],
    daySubmitted: json["daySubmitted"],
    currentTime: json["currentTime"],
      );

  Map<String, dynamic> toJson() => {
        "contactName": contactName,
        "contactPhoneNumber": contactPhoneNumber,
        "broadcastSms": broadcastSms,
        "dateSubmitted": dateSubmitted,
        "daySubmitted": daySubmitted,
        "currentTime": currentTime,
      };
}
