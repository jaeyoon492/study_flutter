import 'dart:convert';

import 'package:study_flutter/model/blue_archive.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class BlueArchiveSource {
  Future<ResponseBlueArchive> getStudentInfo(int page, int limit) async {
    final uri = Uri(
        scheme: "https",
        host: "api-blue-archive.vercel.app",
        path: '/api/characters',
        queryParameters: {
          "page": page.toString(),
          "perPage": limit.toString(),
        });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final resJson = jsonDecode(response.body);
      ResponseBlueArchive studentInfo = ResponseBlueArchive.fromJson(resJson);

      print(studentInfo);

      return studentInfo;
    } else {
      throw Exception("학생정보 조회 실패!");
    }
  }
}
