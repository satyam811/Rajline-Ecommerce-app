// To parse this JSON data, do
//
//     final getProductByCategory = getProductByCategoryFromJson(jsonString);

import 'dart:convert';

GetProductByCategory getProductByCategoryFromJson(String str) =>
    GetProductByCategory.fromJson(json.decode(str));

String getProductByCategoryToJson(GetProductByCategory data) =>
    json.encode(data.toJson());

class GetProductByCategory {
  final bool status;
  final String message;
  final List<Product> products;

  GetProductByCategory({
    required this.status,
    required this.message,
    required this.products,
  });

  factory GetProductByCategory.fromJson(Map<String, dynamic> json) =>
      GetProductByCategory(
        status: json["status"],
        message: json["message"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  final String id;
  final String name;
  final String description;
  final String material;
  final int price;
  final int stock;
  final String category;
  final Image mainImage;
  final List<Image> subImages;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.material,
    required this.price,
    required this.stock,
    required this.category,
    required this.mainImage,
    required this.subImages,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        material: json["material"] ?? "",
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
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
        "category": category,
        "mainImage": mainImage.toJson(),
        "subImages": List<dynamic>.from(subImages.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
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
