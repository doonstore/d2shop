import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoonStoreUser {
  String userId;
  String displayName;
  String email;
  String phone;
  List<Address> addressList;
  String photoUrl;
  DateTime lastLogin;

  DoonStoreUser(this.userId, this.displayName, this.email, this.phone,
      this.addressList, this.photoUrl, this.lastLogin);

  DoonStoreUser.fromFirebaseUser(FirebaseUser user) {
    this.userId = user.uid;
    this.displayName = user.displayName;
    this.email = user.email;
    this.photoUrl = user.photoUrl;
    this.phone = user.phoneNumber;
    this.lastLogin = user.metadata.lastSignInTime;
    this.addressList = List();
  }

  DoonStoreUser.fromJson(Map data) {
    this.userId = data['userId'];
    this.displayName = data['displayName'];
    this.email = data['email'];
    this.photoUrl = data['photoUrl'];
    this.phone = data['phone'];
    this.lastLogin = (data['lastLogin'] as Timestamp).toDate();
    this.addressList = List.castFrom(data['addressList']);
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'phone': phone,
      'lastLogin': Timestamp.fromDate(lastLogin),
      'addressList': addressList
    };
  }
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
}
