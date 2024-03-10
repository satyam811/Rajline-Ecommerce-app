// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final bool status;
  final String message;
  final List<Order> orders;

  OrderModel({
    required this.status,
    required this.message,
    required this.orders,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        status: json["status"],
        message: json["message"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x)))
            .reversed
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  final String id;
  final String user;
  final List<Item> items;
  final int totalAmount;
  final String orderStatus;
  final double taxAmount;
  final double totalAmountWithTax;
  final int totalItems;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Order({
    required this.id,
    required this.user,
    required this.items,
    required this.totalAmount,
    required this.orderStatus,
    required this.taxAmount,
    required this.totalAmountWithTax,
    required this.totalItems,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        user: json["user"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalAmount: json["totalAmount"],
        orderStatus: json["orderStatus"],
        taxAmount: json["taxAmount"]?.toDouble(),
        totalAmountWithTax: json["totalAmountWithTax"]?.toDouble(),
        totalItems: json["totalItems"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalAmount": totalAmount,
        "orderStatus": orderStatus,
        "taxAmount": taxAmount,
        "totalAmountWithTax": totalAmountWithTax,
        "totalItems": totalItems,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Item {
  final ProductId productId;
  final int quantity;
  final int subtotal;
  final String id;

  Item({
    required this.productId,
    required this.quantity,
    required this.subtotal,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: ProductId.fromJson(json["productId"]),
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId.toJson(),
        "quantity": quantity,
        "subtotal": subtotal,
        "_id": id,
      };
}

class ProductId {
  final String id;
  final String name;
  final String description;
  final String material;
  final int price;
  final int stock;
  // final Category? category;
  final String mainCategory;
  final String categoryFullString;
  final Image mainImage;
  final List<Image> subImages;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ProductId({
    required this.id,
    required this.name,
    required this.description,
    required this.material,
    required this.price,
    required this.stock,
    //  required this.category,
    required this.mainCategory,
    required this.categoryFullString,
    required this.mainImage,
    required this.subImages,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        material: json["material"],
        price: json["price"],
        stock: json["stock"],
        // category: json["category"] == null
        //     ? null
        //     : Category.fromJson(json["category"]),
        mainCategory: json["mainCategory"],
        categoryFullString: json["categoryFullString"],
        mainImage: Image.fromJson(json["mainImage"]),
        subImages:
            List<Image>.from(json["subImages"].map((x) => Image.fromJson(x))),
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "material": material,
        "price": price,
        "stock": stock,
        //     "category": category?.toJson(),
        "mainCategory": mainCategory,
        "categoryFullString": categoryFullString,
        "mainImage": mainImage.toJson(),
        "subImages": List<dynamic>.from(subImages.map((x) => x.toJson())),
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

// class Category {
//   final ImageUrl imageUrl;
//   final String id;
//   final String name;
//   final int startingPrice;
//   final String mainCategory;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   Category({
//     required this.imageUrl,
//     required this.id,
//     required this.name,
//     required this.startingPrice,
//     required this.mainCategory,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         imageUrl: ImageUrl.fromJson(json["imageUrl"]),
//         id: json["_id"],
//         name: json["name"],
//         startingPrice: json["startingPrice"],
//         mainCategory: json["mainCategory"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "imageUrl": imageUrl.toJson(),
//         "_id": id,
//         "name": name,
//         "startingPrice": startingPrice,
//         "mainCategory": mainCategory,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }

class ImageUrl {
  final String url;
  final String publicId;

  ImageUrl({
    required this.url,
    required this.publicId,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
        url: json["url"],
        publicId: json["publicId"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "publicId": publicId,
      };
}

class Image {
  final String url;
  final String publicId;
  final String id;

  Image({
    required this.url,
    required this.publicId,
    required this.id,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        publicId: json["publicId"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "publicId": publicId,
        "_id": id,
      };
}
