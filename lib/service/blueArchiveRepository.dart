import 'package:study_flutter/dataSource/blueArchiveSource.dart';
import 'package:study_flutter/model/blueArchive.dart';

class BlueArchiveRepository {
  final BlueArchiveSource _blueArchiveSource = BlueArchiveSource();

  Future<List<Character>?> getCharacterList(int page, int limit) async {
    ResponseBlueArchive studentInfo =
        await _blueArchiveSource.getStudentInfo(page, limit);

    List<Character>? characterList = studentInfo.characterList;

    return characterList;
  }
}
