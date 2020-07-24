import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/utils/constants.dart';

Future<List<Item>> getItems() async {
  QuerySnapshot querySnapshot = await itemRef.getDocuments();
  return querySnapshot.documents.map((e) => Item.fromJson(e.data)).toList();
}

Future<Item> getItem(String id) async {
  DocumentSnapshot doc = await itemRef.document(id).get();
  return Item.fromJson(doc.data);
}

Future<List<Category>> getCategories() async {
  QuerySnapshot querySnapshot = await categoryRef.getDocuments();
  return querySnapshot.documents.map((e) => Category.fromJson(e.data)).toList();
}

Stream<List<Category>> get listOfCategories {
  return categoryRef.snapshots().map((querySnapsot) =>
      querySnapsot.documents.map((e) => Category.fromJson(e.data)).toList());
}
