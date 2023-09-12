import 'dart:convert';

import 'package:study_flutter/model/blueArchive.dart';
import 'package:http/http.dart' as http;

class BlueArchiveSource {
  Future<List<Character>> getCharacterList() async {
    final response = await http
        .get(Uri.parse("https://api-blue-archive.vercel.app/api/characters"));

    final result = jsonDecode(response.body)["data"];
    final charactersJson = result.cast<Map<String, dynamic>>();

    List<Character> characters = charactersJson
        .map<Character>((json) => Character.fromJson(json))
        .toList();

    return characters;
  }
}
