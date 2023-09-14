import 'dart:convert';
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

  // Character(this.id, this.birthday, this.damageType, this.image,
  //     this.imageSchool, this.name, this.photoUrl, this.school);

  // factory Character.fromJson(Map<String, dynamic> json) => Character(
  //       json["_id"] as String,
  //       json["birthday"] as String,
  //       json["damageType"] as String,
  //       json["image"] as String,
  //       json["imageSchool"] as String,
  //       json["name"] as String,
  //       json["photoUrl"] as String,
  //       json["school"] as String,
  //     );

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        school: json["school"],
        birthday: json["birthday"],
        photoUrl: json["photoUrl"],
        damageType: json["damageType"],
        imageSchool: json["imageSchool"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "birthday": birthday,
        "damageType": damageType,
        "image": image,
        "imageSchool": imageSchool,
        "name": name,
        "photoUrl": photoUrl,
        "school": school,
      };

  @override
  String toString() =>
      '{ ${id}, ${birthday} ${damageType}, ${image}, ${imageSchool}, ${name}, ${photoUrl}, ${school} }';
}

class ResponseBlueArchive {
  String? message;
  int? dataAllPage;
  List<Character>? characterList;

  ResponseBlueArchive({this.message, this.dataAllPage, this.characterList});

  factory ResponseBlueArchive.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    List<Character> characterList =
        data.map<Character>((item) => Character.fromJson(item)).toList();

    return ResponseBlueArchive(
      characterList: characterList,
      dataAllPage: json["dataAllPage"],
      message: json["message"],
    );
  }
}
