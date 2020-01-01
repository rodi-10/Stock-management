// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:yourvone/src/models/portfolio_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String uid;
  String displayName;
  String email;
  String gender;
  String birthday;
  String location;
  String providerId;
  Portfolio portfolio;
  double netWorth;
  List<String> friends;

  User({
    this.uid,
    this.displayName,
    this.email,
    this.providerId,
    this.friends,
    this.gender,
    this.birthday,
    this.location,
    this.portfolio,
    this.netWorth
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json["uid"] == null ? null : json["uid"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    email: json["email"] == null ? null : json["email"],
    providerId: json["providerId"] == null ? null : json["providerId"],
    friends: json["friends"] == null ? null : List<String>.from(json["friends"].map((x) => x)),
    birthday: json["birthday"] == null ? null : json["birthday"],
    gender: json["gender"] == null ? null : json["gender"],
    location: json["location"] == null ? null : json["location"],
    portfolio: json["portfolio"] == null ? null : json["portfolio"],
    netWorth: json["netWorth"] == null ? null : json['netWorth'].toDouble()
  );

  Map<String, dynamic> toJson() => {
    "uid": uid == null ? null : uid,
    "displayName": displayName == null ? null : displayName,
    "email": email == null ? null : email,
    "providerId": providerId == null ? null : providerId,
    "friends": friends == null ? null : List<dynamic>.from(friends.map((x) => x)),
    "birthday": birthday == null ? null : birthday,
    "gender": gender == null   ? null  : gender,
    "location": location == null ? null : location,
    "portfolio": portfolio == null ? null : portfolio,
    "netWorth": netWorth == null ? null : netWorth
  };
}