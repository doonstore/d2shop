class Category {
  String id, name, photoUrl;
  bool isFeatured;
  Map<String, dynamic> itemList;

  Category({
    this.id,
    this.name,
    this.photoUrl,
    this.isFeatured,
    this.itemList,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      isFeatured: json['isFeatured'],
      itemList: json['itemList'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'isFeatured': isFeatured,
      'itemList': itemList
    };
  }
}

class Item {
  String id, name, quantityUnit, photoUrl, partOfCategory, partOfSubCategory;
  int quantityValue;
  double price;

  Item(
      {this.id,
      this.name,
      this.photoUrl,
      this.price,
      this.quantityUnit,
      this.partOfSubCategory,
      this.partOfCategory,
      this.quantityValue});

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        photoUrl = json['photoUrl'],
        price = json['price'].runtimeType == int
            ? (json['price'] as int).toDouble()
            : json['price'] as double,
        partOfCategory = json['partOfCategory'],
        quantityValue = json['quantityValue'],
        quantityUnit = json['quantityUnit'],
        partOfSubCategory = json['partOfSubCategory'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'price': price,
      'partOfCategory': partOfCategory,
      'partOfSubCategory': partOfSubCategory,
      'quantityUnit': quantityUnit,
      'quantityValue': quantityValue,
    };
  }
}

class OrderModel {
  String id, deliveryDate, orderDate;
  Map user;
  List itemList, noOfProducts;
  num total;

  OrderModel(
      {this.id,
      this.itemList,
      this.user,
      this.total,
      this.deliveryDate,
      this.orderDate,
      this.noOfProducts});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      user: json['user'],
      itemList: json['itemList'],
      total: json['total'],
      deliveryDate: json['deliveryDate'],
      orderDate: json['orderDate'],
      noOfProducts: json['noOfProducts'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'itemList': itemList,
      'total': total,
      'deliveryDate': deliveryDate,
      'orderDate': orderDate,
      'noOfProducts': noOfProducts
    };
  }
}

Future<Map<String, dynamic>> getSubCategoryList(String data) async {
  Map<String, dynamic> itemList = {};
  List<String> subCategoryList = data.split(',');
  if (subCategoryList.length > 1) {
    subCategoryList.forEach((e) {
      itemList[e.trim()] = [];
    });
  } else {
    itemList[data] = [];
  }
  return itemList;
}
