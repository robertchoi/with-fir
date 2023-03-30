import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  List _bottomIndex = [0];

  get currentIndex => _bottomIndex.last;

  get bottomIndex => _bottomIndex;


  void setBottomIndex(index) {
    // 추가하려는 인덱스가 이미 존재하면 중복되므로, 이전것은 제거하고 새로 push 해준다.
    _bottomIndex.contains(index) ? _bottomIndex.remove(index) : null;
    _bottomIndex.add(index);
    notifyListeners();
  }

  void popBottomIndex(){
    _bottomIndex.removeLast();
    print(_bottomIndex);
    notifyListeners();
  }

  void resetBottomIndex(){
    _bottomIndex = [0];
    print(_bottomIndex);
    notifyListeners();
  }
  // Future<bool> willPopAction() async {
  //   if (_bottomIndex.isEmpty) {
  //     return showDialog(context: context!, builder: (_)=> ShowDialogView());
  //     // print('갔다 온겨?');
  //     // return true;
  //   } else {
  //     _bottomIndex.removeLast();
  //     notifyListeners();
  //     return false;
  //   }
  // }
}
