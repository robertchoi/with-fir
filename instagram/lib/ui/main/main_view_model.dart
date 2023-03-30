import 'package:flutter/material.dart';
import 'package:instagram/data/model/dto_post.dart';
import 'package:instagram/repository/repository_post.dart';

class MainViewModel with ChangeNotifier{
  List<DtoPost> _items = [];
  late RepositoryPost _repository;

  get postCount => _items.length;


  MainViewModel() {
    _repository = RepositoryPost();
  }

  Future<void> loadItems() async {
    _items = await _repository.getPost();
    notifyListeners();
  }

  DtoPost getItem(int index) {
    return _items[index];
  }
}