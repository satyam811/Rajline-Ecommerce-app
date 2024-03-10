// class CategoriesProduct {
//   final String image;
//   final String title;
//   final String type;

//   CategoriesProduct(this.image, this.title, this.type);

//   static List<CategoriesProduct> getCategoriesProducts() {
//     List<CategoriesProduct> categoriesItems = <CategoriesProduct>[];
//     categoriesItems.add(CategoriesProduct("assets/dumy/cilingFan.png",
//         "Rajlines Ceiling Fan", 'Home Appliances'));
//     categoriesItems.add(CategoriesProduct(
//         "assets/dumy/tableFan.png", "Rajlines Table Fan", 'Home Appliances'));
//     categoriesItems.add(CategoriesProduct(
//         "assets/dumy/wallFan.png", "Rajlines Wall Fan", 'Home Appliances'));
//     categoriesItems.add(CategoriesProduct("assets/dumy/waterHeater.png",
//         "Rajlines Water Heater", 'Home Appliances'));
//     categoriesItems.add(CategoriesProduct("assets/dumy/cilingFan.png",
//         "Rajlines Ceiling Fan", 'Home Appliances'));
//     categoriesItems.add(CategoriesProduct(
//         "assets/dumy/tableFan.png", "Rajlines Table Fan", 'Home Appliances'));
//     categoriesItems.add(CategoriesProduct(
//         "assets/dumy/wallFan.png", "Rajlines Wall Fan", 'Home Appliances'));
//     categoriesItems.add(CategoriesProduct("assets/dumy/waterHeater.png",
//         "Rajlines Water Heater", 'Home Appliances'));

//     return categoriesItems;
//   }
// }

// To parse this JSON data, do
//
//     final getSubCategoryMain = getSubCategoryMainFromJson(jsonString);

import 'dart:convert';

GetSubCategoryMain getSubCategoryMainFromJson(String str) =>
    GetSubCategoryMain.fromJson(json.decode(str));

String getSubCategoryMainToJson(GetSubCategoryMain data) =>
    json.encode(data.toJson());

class GetSubCategoryMain {
  final bool status;
  final String message;
  final List<SubCategory> subCategories;

  GetSubCategoryMain({
    required this.status,
    required this.message,
    required this.subCategories,
  });

  factory GetSubCategoryMain.fromJson(Map<String, dynamic> json) =>
      GetSubCategoryMain(
        status: json["status"],
        message: json["message"],
        subCategories: List<SubCategory>.from(
            json["subCategories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "subCategories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
      };
}

class SubCategory {
  final ImageUrl imageUrl;
  final String id;
  final String name;
  final int startingPrice;
  final String mainCategory;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SubCategory({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.startingPrice,
    required this.mainCategory,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
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
