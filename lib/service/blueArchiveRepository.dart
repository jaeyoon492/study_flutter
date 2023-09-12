import 'package:study_flutter/dataSource/blueArchiveSource.dart';
import 'package:study_flutter/model/blueArchive.dart';

class BlueArchiveRepository {
  final BlueArchiveSource _blueArchiveSource = BlueArchiveSource();

  Future<List<Character>> getCharacterList() {
    return _blueArchiveSource.getCharacterList();
  }
}
