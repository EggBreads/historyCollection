import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class InterestModel {
  int seqNo;
  String title;

  InterestModel({
    required this.seqNo,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seqNo': seqNo,
      'title': title,
    };
  }

  factory InterestModel.fromMap(Map<String, dynamic> map) {
    return InterestModel(
      seqNo: map['seqNo'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestModel.fromJson(String source) =>
      InterestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
