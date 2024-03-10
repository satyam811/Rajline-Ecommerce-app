// To parse this JSON data, do
//
//     final getMainCategory = getMainCategoryFromJson(jsonString);

import 'dart:convert';

GetMainCategory getMainCategoryFromJson(String str) =>
    GetMainCategory.fromJson(json.decode(str));

String getMainCategoryToJson(GetMainCategory data) =>
    json.encode(data.toJson());

class GetMainCategory {
  final bool status;
  final String message;
  final List<MainCategory> mainCategories;

  GetMainCategory({
    required this.status,
    required this.message,
    required this.mainCategories,
  });

  factory GetMainCategory.fromJson(Map<String, dynamic> json) =>
      GetMainCategory(
        status: json["status"],
        message: json["message"],
        mainCategories: List<MainCategory>.from(
            json["mainCategories"].map((x) => MainCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "mainCategories":
            List<dynamic>.from(mainCategories.map((x) => x.toJson())),
      };
}

class MainCategory {
  final ImageUrl imageUrl;
  final String id;
  final String name;
  final int startingPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  MainCategory({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.startingPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
        imageUrl: ImageUrl.fromJson(json["imageUrl"]),
        id: json["_id"],
        name: json["name"],
        startingPrice: json["startingPrice"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl.toJson(),
        "_id": id,
        "name": name,
        "startingPrice": startingPrice,
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
