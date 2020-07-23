import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Firestore Refrences
final Firestore _firestore = Firestore.instance;
final CollectionReference userRef = _firestore.collection('users');
final CollectionReference itemRef = _firestore.collection('item');
final CollectionReference categoryRef = _firestore.collection('category');

/// Resposniveness
double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.height;

/// Colors
const Color kPrimaryColor = Colors.teal;

List<Color> kBackgroundColorsList = [
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
