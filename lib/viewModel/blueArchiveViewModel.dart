import 'package:flutter/material.dart';
import 'package:study_flutter/model/blueArchive.dart';
import 'package:study_flutter/service/blueArchiveRepository.dart';
import 'dart:developer' as developer;

class BlueArchiveViewModel with ChangeNotifier {
  late final BlueArchiveRepository _blueArchiveRepository;
  List<Character> _characterList = List.empty(growable: true);
  List<Character> get characterList => _characterList;

  BlueArchiveViewModel() {
    _blueArchiveRepository = BlueArchiveRepository();
    _getCharacterList();
  }

  Future<void> _getCharacterList() async {
    _characterList = await _blueArchiveRepository.getCharacterList();

    notifyListeners();
  }
}
