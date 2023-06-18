import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileModel {
  final String nickName;
  final String email;
  final int age;

  ProfileModel({
    required this.nickName,
    required this.email,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickName': nickName,
      'email': email,
      'age': age,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      nickName: map['nickName'] as String,
      email: map['email'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
