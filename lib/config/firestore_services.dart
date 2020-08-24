import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d2shop/models/apartment_model.dart';
import 'package:d2shop/models/chat_model.dart';
import 'package:d2shop/models/coupon_model.dart';
import 'package:d2shop/models/featured_model.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/utils/constants.dart';

class FirestoreServices {
  Stream<List<Category>> get listOfCategories {
    return categoryRef.snapshots().map((QuerySnapshot q) => q.documents
        .map((DocumentSnapshot doc) => Category.fromJson(doc.data))
        .toList());
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

  Stream<List<OrderModel>> get getOrders {
    return orderRef.snapshots().map(
        (q) => q.documents.map((e) => OrderModel.fromJson(e.data)).toList());
  }

  Stream<List<SupportMessages>> getMessages(String userId) {
    return chatRef.where("userId", isEqualTo: userId).snapshots().map((q) =>
        q.documents.map((e) => SupportMessages.fromJson(e.data)).toList());
  }

// Service Fee
  Future<num> get serviceFee {
    return servicesRef
        .document('serviceFee')
        .get()
        .then((value) => value['value']);
  }

  Future<void> placeOrder(OrderModel orderModel) {
    return orderRef.document(orderModel.id).setData(orderModel.toJson());
  }

  Future<CouponModel> checkCoupon(String promoCode) {
    return couponRef.document(promoCode).get().then((value) {
      if (value.exists)
        return CouponModel.fromJson(value.data);
      else
        return CouponModel();
    });
  }

  Future<List<ApartmentModel>> get apartments {
    return apartmentRef.getDocuments().then((value) =>
        value.documents.map((e) => ApartmentModel.fromJson(e.data)).toList());
  }

  Future<List<OrderModel>> getOrdersDocument() {
    return orderRef.getDocuments().then(
        (q) => q.documents.map((e) => OrderModel.fromJson(e.data)).toList());
  }

  Future<void> sendMessageToSupport(SupportMessages supportMessages) {
    return chatRef
        .document(supportMessages.id)
        .setData(supportMessages.toJson());
  }
}
