import 'package:firebase_auth/firebase_auth.dart';

class DoonStoreUser {
  String userId, displayName, email, phone, photoUrl, token;
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
      this.token,
      this.coupons,
      this.transactions,
      this.photoUrl});

  factory DoonStoreUser.fromFirebase(FirebaseUser user) => DoonStoreUser(
      userId: user.uid,
      displayName: user.displayName ?? '',
      photoUrl: user.photoUrl ?? '',
      address: {},
      transactions: [],
      doorBellStatus: false,
      whatsAppNotificationSetting: false,
      email: user.email ?? '',
      phone: user.phoneNumber,
      wallet: 0,
      coupons: {});

  factory DoonStoreUser.fromJson(Map data) => DoonStoreUser(
        userId: data['userId'],
        email: data['email'] ?? '',
        address: data['address'] ?? {},
        displayName: data['displayName'] ?? '',
        doorBellStatus: data['doorBellStatus'] ?? false,
        transactions: data['transactions'] ?? [],
        phone: data['phone'] ?? '',
        photoUrl: data['photoUrl'] ?? '',
        wallet: data['wallet'] ?? 0,
        token: data['token'],
        whatsAppNotificationSetting:
            data['whatsAppNotificationSetting'] ?? false,
        coupons: data['coupons'] ?? {},
      );

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
        'wallet': wallet,
        'coupons': coupons,
        'token': token
      };
}

List<String> getAddress(Map<String, dynamic> map) {
  return [map['Apartment'], map['Block'], map['House No']];
}

Map<String, Object> addressToJson(
    String apartment, String block, String houseNo) {
  return {
    'Apartment': apartment,
    'Block': block,
    'House No': houseNo,
  };
}

enum PreferncesType { DoorBell, WhatsApp }
enum TransactionType { Credited, Debited }

Map<String, Object> getWalletMap(String title, String desc, num amount,
    num newBalance, TransactionType type) {
  return {
    'title': title,
    'desc': desc,
    'amount': amount,
    'date': DateTime.now().toString(),
    'type': type == TransactionType.Credited ? 'Credited' : 'Debited',
    'newBalance': newBalance,
  };
}
