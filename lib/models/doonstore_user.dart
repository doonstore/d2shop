import 'package:firebase_auth/firebase_auth.dart';

class DoonStoreUser {
  String userId, displayName, email, phone, photoUrl, lastLogin;
  Map<String, dynamic> address, coupons;
  bool doorBellStatus, whatsAppNotificationSetting;
  int wallet;
  List transactions;

  DoonStoreUser(
      {this.userId,
      this.displayName,
      this.email,
      this.doorBellStatus,
      this.whatsAppNotificationSetting,
      this.phone,
      this.address,
      this.wallet,
      this.coupons,
      this.transactions,
      this.photoUrl,
      this.lastLogin});

  factory DoonStoreUser.fromFirebase(FirebaseUser user) => DoonStoreUser(
      userId: user.uid,
      displayName: user.displayName ?? '',
      photoUrl: user.photoUrl ?? '',
      address: {},
      transactions: [],
      doorBellStatus: false,
      whatsAppNotificationSetting: false,
      email: user.email ?? '',
      lastLogin: user.metadata.lastSignInTime.toString(),
      phone: user.phoneNumber,
      wallet: 0,
      coupons: {});

  factory DoonStoreUser.fromJson(Map data) => DoonStoreUser(
      userId: data['userId'],
      email: data['email'] ?? '',
      address: data['address'] ?? {},
      displayName: data['displayName'] ?? '',
      doorBellStatus: data['doorBellStatus'] ?? false,
      lastLogin: data['lastLogin'] ?? '',
      transactions: data['transactions'] ?? [],
      phone: data['phone'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      wallet: data['wallet'] ?? 0,
      whatsAppNotificationSetting: data['whatsAppNotificationSetting'] ?? false,
      coupons: data['coupons']);

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'displayName': displayName ?? '',
        'address': address ?? {},
        'doorBellStatus': doorBellStatus ?? false,
        'whatsAppNotificationSetting': whatsAppNotificationSetting ?? false,
        'email': email ?? '',
        'photoUrl': photoUrl ?? '',
        'phone': phone,
        'transactions': transactions,
        'lastLogin': lastLogin,
        'wallet': wallet,
        'coupons': coupons
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
enum TransactionType { Credited, Debited }

Map<String, Object> getWalletMap(String title, String desc, int amount,
    int newBalance, TransactionType type) {
  return {
    'title': title,
    'desc': desc,
    'amount': amount,
    'date': DateTime.now().toString(),
    'type': type == TransactionType.Credited ? 'Credited' : 'Debited',
    'newBalance': newBalance,
  };
}
