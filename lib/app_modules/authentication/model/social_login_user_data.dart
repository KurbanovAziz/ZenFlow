import 'package:zen_flow/utils/Enums/enums.dart';

class UserModel {
  UserModel({
    this.userId,
    this.userName,
    // this.userFirstName,
    // this.userLastName,
    this.userEmail,
    this.profilePicture,
    this.subscriptionType,
    this.subscriptionDate,
    this.createdAt,
    this.loginType,
    this.password,
    // required this.nameFr,
    // required this.items,
  });

  String? userId;
  String? userName;
  // String? userFirstName;
  // String? userLastName;
  String? userEmail;
  String? profilePicture;
  String? subscriptionType;
  String? subscriptionDate;
  String? createdAt;
  String? loginType;
  String? password;
  // String nameFr;
  // List<SubCategoriesItem> items;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"] ?? '',
        userName: json["userName"] ?? '',
        // userFirstName: json["userFirstName"] ?? '',
        // userLastName: json["userLastName"] ?? '',
        userEmail: json["userEmail"] ?? '',
        profilePicture: json["profilePicture"] ?? '',
        subscriptionType: json["subscriptionType"] ?? '',
        subscriptionDate: json["subscriptionDate"] ?? '',
        createdAt: json["createdAt"] ?? '',
        loginType: json["loginType"] ?? '',
        password: json["password"] ?? '',
        // nameFr: json["name_fr"] ?? '',/
        // items: List<SubCategoriesItem>.from(
        //     json["items"].map((x) => SubCategoriesItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        // "userFirstName": userFirstName,
        // "userLastName": userLastName,
        "userEmail": userEmail,
        "profilePicture": profilePicture,
        "subscriptionType": subscriptionType,
        "subscriptionDate": subscriptionDate,
        "createdAt": createdAt,
        "loginType": loginType,
        "password": password,
        // "name_fr": nameFr,
        // "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
