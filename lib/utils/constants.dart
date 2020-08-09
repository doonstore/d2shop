import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Firestore Refrences
final Firestore _firestore = Firestore.instance;
final CollectionReference userRef = _firestore.collection('users');
final CollectionReference itemRef = _firestore.collection('item');
final CollectionReference categoryRef = _firestore.collection('category');
final CollectionReference featuredRef = _firestore.collection('featured');
final CollectionReference requestRef = _firestore.collection('requests');

/// Resposniveness
double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.height;

RoundedRectangleBorder rounded(double circluar) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(circluar));

/// Colors
const Color kPrimaryColor = Color.fromRGBO(65, 160, 209, 1);

final List<Color> kBackgroundColorsList = <Color>[
  Colors.blue[200],
  Colors.teal[200],
  Colors.orange[200],
  Colors.amber[200],
  Colors.blueAccent[200],
  Colors.tealAccent[200],
  Colors.cyan[200],
  Colors.purpleAccent[200],
  Colors.pink[200]
];

/// Strings
const String rupeeUniCode = '\u20b9';
