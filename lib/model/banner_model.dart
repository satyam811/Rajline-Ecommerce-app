import 'cart_model.dart' show ImageUrl;

class BannerModel {
  String id;
  ImageUrl image;
  int v;

  BannerModel({
    required this.id,
    required this.image,
    required this.v,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["_id"],
        image: ImageUrl.fromJson(json["image"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image.toJson(),
        "__v": v,
      };

  @override
  bool operator ==(Object other) {
    return other is BannerModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
