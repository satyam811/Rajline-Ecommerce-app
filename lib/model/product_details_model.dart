// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) =>
    ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) =>
    json.encode(data.toJson());

class ProductDetailsModel {
  final bool status;
  final String message;
  final Product product;
  final bool isFavourite;

  ProductDetailsModel({
    required this.status,
    required this.message,
    required this.product,
    required this.isFavourite,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        status: json["status"],
        message: json["message"],
        product: Product.fromJson(json["product"]),
        isFavourite: json["isFavourite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "product": product.toJson(),
        "isFavourite": isFavourite,
      };
}

class Product {
  final String id;
  final String name;
  final String description;
  final String material;
  final int price;
  final int stock;
  final Category category;
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
