import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/data/model/dto_post.dart';
import 'package:instagram/repository/repository_post.dart';

class PostViewModel with ChangeNotifier {
  RepositoryPost repositoryPost = RepositoryPost();

  String _titleText = '';
  String _imageUrl = '';

  get titleText => _titleText;

  get imageUrl => _imageUrl;

  void setTitleText(text) {
    _titleText = text;
    notifyListeners();
  }

  void setImageUrl(imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }

  void uploadDone(){
    _titleText = '';
    _imageUrl = '';
    print('초기화완료');
    notifyListeners();
  }

  void addPost() async{
    String userName = FirebaseAuth.instance.currentUser!.displayName ?? '';
    String photoURL = FirebaseAuth.instance.currentUser!.photoURL ?? '';
    int postId = await repositoryPost.getPostId()!;

    print('userName: $userName');
    print('photoUrl: $photoURL');

    DtoPost dtoPost = DtoPost(
      id: postId + 1,
      userName: userName,
      userProfile: photoURL,
      titleText: _titleText,
      imageUrl: _imageUrl,
      createdAt: DateTime.now(),
    );

    repositoryPost.addPost(dtoPost);
    uploadDone();
  }
}
