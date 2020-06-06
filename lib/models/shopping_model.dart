class Category {
  String id;
  String name;
  String photoUrl;
  bool isFeatured;
  List<String> itemList = List();

  Category(this.id, this.name, this.photoUrl, this.isFeatured, this.itemList);

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        photoUrl = json['photoUrl'],
        isFeatured = json['isFeatured'],
        itemList = json['itemList'].cast<String>();

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
  String id;
  String name;
  String photoUrl;
  double price;
  List<String> categoryList = List();

  Item(this.id, this.name, this.photoUrl, this.price, this.categoryList);

  Item.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        photoUrl = json['photoUrl'],
        price = json['price'].runtimeType == int
            ? (json['price'] as int).toDouble()
            : json['price'] as double,
        categoryList = json['categoryList'].cast<String>();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'price': price,
      'categoryList': categoryList
    };
  }
}

class Order {
  String id;
  String userId;
  List<OrderItem> itemList;
  double total;

  Order(this.id, this.userId, this.itemList, this.total);

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        total = json['total'].runtimeType == int
            ? (json['total'] as int).toDouble()
            : json['total'] as double,
        itemList = unmarshalItemList(json['itemList']);

  static List<OrderItem> unmarshalItemList(List<String> itemString) {
    List<OrderItem> orders = List();
    for (String item in itemString) {
      orders.add(OrderItem.fromString(item));
    }
    return orders;
  }

  List<String> marshalItemList() {
    List<String> itemStringList = List();
    for (OrderItem order in itemList) {
      itemStringList.add(order.toString());
    }
    return itemStringList;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'itemList': marshalItemList(),
      'total': total
    };
  }
}

class OrderItem {
  String itemId;
  int quantity;
  double price;

  OrderItem(this.itemId, this.quantity, this.price);

  OrderItem.fromString(String itemString) {
    List<String> parts = itemString.split("##");
    itemId = parts[0];
    quantity = parts[1] as int;
    price = parts[2].runtimeType == int
        ? (parts[2] as int).toDouble()
        : parts[2] as double;
  }

  @override
  String toString() {
    return "$itemId##$quantity##$price";
  }
}
