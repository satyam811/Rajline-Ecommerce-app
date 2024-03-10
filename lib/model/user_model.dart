// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final bool status;
  final String message;
  final User user;

  UserModel({
    required this.status,
    required this.message,
    required this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String mobileNumber;
  final String shopName;
  final Address address;
  final String gstNo;
  final bool isAdmin;
  final bool isVerified;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final ProfilePic? profilePic;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.mobileNumber,
    required this.shopName,
    required this.address,
    required this.gstNo,
    required this.isAdmin,
    required this.isVerified,
    required this.isEmailVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        mobileNumber: json["mobileNumber"],
        shopName: json["shopName"],
        address: Address.fromJson(json["address"]),
        gstNo: json["gstNo"],
        isAdmin: json["isAdmin"],
        isVerified: json["isVerified"],
        isEmailVerified: json["isEmailVerified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        profilePic: json["profilePic"] == null
            ? null
            : ProfilePic.fromJson(json["profilePic"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "mobileNumber": mobileNumber,
        "shopName": shopName,
        "address": address.toJson(),
        "gstNo": gstNo,
        "isAdmin": isAdmin,
        "isVerified": isVerified,
        "isEmailVerified": isEmailVerified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        //"profilePic": profilePic.toJson(),
      };
}

class Address {
  final String id;
  final String addressLine1;
  final String city;
  final String pincode;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String user;

  Address({
    required this.id,
    required this.addressLine1,
    required this.city,
    required this.pincode,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.user,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["_id"],
        addressLine1: json["addressLine1"],
        city: json["city"],
        pincode: json["pincode"],
        state: json["state"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "addressLine1": addressLine1,
        "city": city,
        "pincode": pincode,
        "state": state,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "user": user,
      };
}

class ProfilePic {
  final String url;
  final String publicId;
  final String id;

  ProfilePic({
    required this.url,
    required this.publicId,
    required this.id,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
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
