// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) =>
    GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  final bool status;
  final String message;
  final List<Item> items;
  final int subTotal;
  final double tax;
  final double totalAmount;

  GetCartModel({
    required this.status,
    required this.message,
    required this.items,
    required this.subTotal,
    required this.tax,
    required this.totalAmount,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
        status: json["status"],
        message: json["message"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        subTotal: json['subTotal'],
        tax: json['tax']?.toDouble() ?? 0.0,
        totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "subTotal": subTotal,
        "tax": tax,
        "totalAmount": totalAmount,
      };
}

class Item {
  final ProductId productId;
  final int quantity;
  final String id;

  Item({
    required this.productId,
    required this.quantity,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: ProductId.fromJson(json["productId"]),
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId.toJson(),
        "quantity": quantity,
        "_id": id,
      };
}

class ProductId {
  final String id;
  final String name;
  final String description;
  final int price;
  final int stock;
  final Category category;
  final Image mainImage;
  final List<Image> subImages;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ProductId({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.mainImage,
    required this.subImages,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        category: Category.fromJson(json["category"]),
        mainImage: Image.fromJson(json["mainImage"]),
        subImages:
            List<Image>.from(json["subImages"].map((x) => Image.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "category": category.toJson(),
        "mainImage": mainImage.toJson(),
        "subImages": List<dynamic>.from(subImages.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Category {
  final ImageUrl imageUrl;
  final String id;
  final String name;
  final int startingPrice;
  final String mainCategory;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Category({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.startingPrice,
    required this.mainCategory,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        imageUrl: ImageUrl.fromJson(json["imageUrl"]),
        id: json["_id"],
        name: json["name"],
        startingPrice: json["startingPrice"],
        mainCategory: json["mainCategory"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl.toJson(),
        "_id": id,
        "name": name,
        "startingPrice": startingPrice,
        "mainCategory": mainCategory,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

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
