import 'package:study_flutter/dataSource/blue_archive_source.dart';
import 'package:study_flutter/model/blue_archive.dart';

class BlueArchiveRepository {
  final BlueArchiveSource _blueArchiveSource = BlueArchiveSource();

  Future<List<Character>?> getCharacterList(int page, int limit) async {
    ResponseBlueArchive studentInfo =
        await _blueArchiveSource.getStudentInfo(page, limit);

    List<Character>? characterList = studentInfo.characterList;

    return characterList;
  }
}
