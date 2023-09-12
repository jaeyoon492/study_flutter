import 'dart:developer' as developer;

class Character {
  String? id;
  String? name;
  String? image;
  String? school;
  String? birthday;
  String? photoUrl;
  String? damageType;
  String? imageSchool;

  Character(
      {this.id,
      this.birthday,
      this.damageType,
      this.image,
      this.imageSchool,
      this.name,
      this.photoUrl,
      this.school});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json["_id"],
      name: json["name"],
      image: json["image"],
      school: json["school"],
      birthday: json["birthday"],
      photoUrl: json["photoUrl"],
      damageType: json["damageType"],
      imageSchool: json["imageSchool"],
    );
  }
}

class ResponseBlueArchive {
  String? message;
  int? dataAllPage;
  List<Character>? data;

  ResponseBlueArchive({this.message, this.dataAllPage, this.data});

  factory ResponseBlueArchive.fromJson(Map<String, dynamic> json) {
    return ResponseBlueArchive(
      data: json["data"],
      dataAllPage: json["dataAllPage"],
      message: json["message"],
    );
  }
}
