import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoonStoreUser {
  String userId, displayName, email, phone, photoUrl;
  Map<String, dynamic> address;
  DateTime lastLogin;
  bool doorBellStatus, whatsAppNotificationSetting;

  DoonStoreUser(
      {this.userId,
      this.displayName,
      this.email,
      this.doorBellStatus,
      this.whatsAppNotificationSetting,
      this.phone,
      this.address,
      this.photoUrl,
      this.lastLogin});

  factory DoonStoreUser.fromFirebase(FirebaseUser user) => DoonStoreUser(
        userId: user.uid,
        displayName: user.displayName ?? '',
        photoUrl: user.photoUrl ?? '',
        address: {},
        doorBellStatus: false,
        whatsAppNotificationSetting: false,
        email: user.email ?? '',
        lastLogin: user.metadata.lastSignInTime ?? DateTime.now(),
        phone: user.phoneNumber,
      );

  factory DoonStoreUser.fromJson(Map data) => DoonStoreUser(
      userId: data['userId'],
      email: data['email'] ?? '',
      address: data['address'] ?? {},
      displayName: data['displayName'] ?? '',
      doorBellStatus: data['doorBellStatus'] ?? false,
      lastLogin: (data['lastLogin'] as Timestamp).toDate(),
      phone: data['phone'],
      photoUrl: data['photoUrl'] ?? '',
      whatsAppNotificationSetting:
          data['whatsAppNotificationSetting'] ?? false);

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'displayName': displayName ?? '',
        'address': address ?? {},
        'doorBellStatus': doorBellStatus ?? false,
        'whatsAppNotificationSetting': whatsAppNotificationSetting ?? false,
        'email': email ?? '',
        'photoUrl': photoUrl ?? '',
        'phone': phone,
        'lastLogin': Timestamp.fromDate(lastLogin),
      };
}

List<String> getAddress(Map<String, dynamic> map) {
  return [map['Apartment'], map['Block'], map['House No']];
}

class Address {
  String lineOne;
  String lineTwo;
  String street;
  String city;
  String state;
  String country;
  String pinCode;
  String contactNumber;

  Address(this.lineOne, this.lineTwo, this.street, this.city, this.state,
      this.country, this.pinCode, this.contactNumber);

  Address.fromString(String addressString) {
    List<String> parts = addressString.split("##");
    this.lineOne = parts[0].trim().length == 0 ? null : parts[0].trim();
    this.lineTwo = parts[1].trim().length == 0 ? null : parts[1].trim();
    this.street = parts[2].trim().length == 0 ? null : parts[2].trim();
    this.city = parts[3].trim().length == 0 ? null : parts[3].trim();
    this.state = parts[4].trim().length == 0 ? null : parts[4].trim();
    this.country = parts[5].trim().length == 0 ? null : parts[5].trim();
    this.pinCode = parts[6].trim().length == 0 ? null : parts[6].trim();
    this.contactNumber = parts[7].trim().length == 0 ? null : parts[7].trim();
  }

  @override
  String toString() {
    return "$lineOne##$lineTwo##$street##$city##$state##$country##$pinCode##"
        "$contactNumber";
  }
}

enum PreferncesType { DoorBell, WhatsApp }
