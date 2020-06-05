import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d2shop/models/shopping_model.dart';

final databaseReference = Firestore.instance;

Future<List<Item>> getItems() async {
  var q = await databaseReference.collection('item').getDocuments();
  return q.documents.map((e) => Item.fromJson(e.data)).toList();
}

Future<Item> getItem(String id) async {
  var q = await databaseReference.collection('item').document(id).get();
  return Item.fromJson(q.data);
}
