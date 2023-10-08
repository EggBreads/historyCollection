import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? userName;
  String? userEmail;
  String? avatarUrl;
  String? phoneNumber;
  bool isEmailVertified;

  UserModel({
    this.userName,
    this.userEmail,
    this.avatarUrl,
    this.phoneNumber,
    required this.isEmailVertified,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userEmail': userEmail,
      'avatarUrl': avatarUrl,
      'phoneNumber': phoneNumber,
      'isEmailVertified': isEmailVertified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] != null ? map['userName'] as String : null,
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      isEmailVertified: map['isEmailVertified'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserModel.empty() {
    return UserModel(
      userName: null,
      userEmail: null,
      avatarUrl: null,
      phoneNumber: null,
      isEmailVertified: false,
    );
  }
}
