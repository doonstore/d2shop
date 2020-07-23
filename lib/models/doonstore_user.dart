import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoonStoreUser {
  String userId;
  String displayName;
  String email;
  String phone;
  List<Address> addressList = List();
  String photoUrl;
  DateTime lastLogin;
  bool doorBellStatus = false;

  DoonStoreUser(this.userId, this.displayName, this.email, this.phone,
      this.addressList, this.photoUrl, this.lastLogin);

  DoonStoreUser.fromFirebaseUser(FirebaseUser user) {
    this.userId = user.uid ?? '';
    this.displayName = user.displayName ?? '';
    this.email = user.email ?? '';
    this.photoUrl = user.photoUrl ?? '';
    this.phone = user.phoneNumber ?? '';
    this.lastLogin = user.metadata.lastSignInTime;
    this.addressList = List();
  }

  DoonStoreUser.fromJson(Map data) {
    this.userId = data['userId'] ?? '';
    this.displayName = data['displayName'] ?? '';
    this.email = data['email'] ?? '';
    this.photoUrl = data['photoUrl'] ?? '';
    this.phone = data['phone'] ?? '';
    this.lastLogin = (data['lastLogin'] as Timestamp).toDate();
    setAddressList(data['addressList']);
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId ?? '',
      'displayName': displayName ?? '',
      'email': email ?? '',
      'photoUrl': photoUrl ?? '',
      'phone': phone ?? '',
      'lastLogin': Timestamp.fromDate(lastLogin),
      'addressList': getAddressList()
    };
  }

  List<String> getAddressList() {
    List<String> addressList = List();
    for (Address address in this.addressList) {
      addressList.add(address.toString());
    }
    return addressList;
  }

  void setAddressList(List<dynamic> addressList) {
    addressList.cast<String>().forEach((element) {
      this.addressList.add(Address.fromString(element));
    });
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
