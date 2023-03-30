import 'package:instagram/data/datasource/remote_datasource.dart';
import 'package:instagram/data/model/dto_post.dart';

class RepositoryPost {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  getPost() async{
    return await _remoteDataSource.getPost();
  }

  void addPost(DtoPost dtoPost) {
    _remoteDataSource.addPost(dtoPost);
  }

  getPostId(){
    return _remoteDataSource.getPostId();
  }
}