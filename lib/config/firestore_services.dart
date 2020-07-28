import 'package:d2shop/models/featured_model.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/utils/constants.dart';

Stream<List<Category>> get listOfCategories {
  return categoryRef
      .snapshots()
      .map((q) => q.documents.map((e) => Category.fromJson(e.data)).toList());
}

Stream<List<FeaturedModel>> get listOfFeaturedHeaders {
  return featuredRef.snapshots().map(
      (q) => q.documents.map((e) => FeaturedModel.fromJSON(e.data)).toList());
}

Stream<List<Item>> get listOfItems {
  return itemRef
      .snapshots()
      .map((q) => q.documents.map((e) => Item.fromJson(e.data)).toList());
}
