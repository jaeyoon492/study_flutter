import 'package:flutter/material.dart';
import 'package:study_flutter/model/blue_archive.dart';
import 'package:study_flutter/service/blue_archive_repository.dart';
import 'dart:developer' as developer;

class BlueArchiveViewModel with ChangeNotifier {
  late final BlueArchiveRepository _blueArchiveRepository;

  // pagination state
  int _page = 1;
  final int _limit = 20;
  bool _hasNextPage = true;
  bool _isDataLoading = false;

  // data state
  List<Character>? _characterList = List.empty(growable: true);
  List<Character>? get characterList => _characterList;

  BlueArchiveViewModel() {
    _blueArchiveRepository = BlueArchiveRepository();
    _initLoad();
  }

  setDataLoading() {
    if (_isDataLoading == false) {
      _isDataLoading = true;
    } else {
      _isDataLoading = false;
    }
    notifyListeners();
  }

  Future<void> _initLoad() async {
    setDataLoading();
    await _initCharacterList();
    setDataLoading();
  }

  Future<void> fetchNext() async {
    if (_hasNextPage && !_isDataLoading) {
      setDataLoading();
      _page += 1;
      await _fetchNextCharacterList();
      setDataLoading();
    }
  }

  Future<void> _initCharacterList() async {
    _characterList =
        await _blueArchiveRepository.getCharacterList(_page, _limit);
    notifyListeners();
  }

  Future<void> _fetchNextCharacterList() async {
    List<Character>? newList =
        await _blueArchiveRepository.getCharacterList(_page, _limit);

    if (newList != null) {
      if (newList.isNotEmpty) {
        _characterList?.addAll(newList);
      } else {
        _hasNextPage = false;
      }
      notifyListeners();
    } else {
      throw Exception("can't add to _characterList, cause newValue is null");
    }
  }
}
