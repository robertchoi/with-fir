import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/data/model/dto_post.dart';

class RemoteDataSource {
  static const post = 'Post';

  final CollectionReference _post = FirebaseFirestore.instance.collection(post);

  getPost() async {
    QuerySnapshot snapshot =
        await _post.orderBy('createdAt', descending: true).get();

    List<DtoPost> list = [];

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      list.add(DtoPost(
        // id: data['id'],
        userName: data['userName'] ?? '',
        userProfile: data['userProfile'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        titleText: data['titleText'] ?? '',
        // createdAt: (doc.get('createdAt') as Timestamp).toDate(),
      ));
    }
    return list;
  }

  Future<int> getPostId() async{
    var snapshot =
        await _post.orderBy('createdAt', descending: true).get();
    print('스냅샷값');
    if(snapshot.docs.isEmpty){
      return 0;
    } else {
      return snapshot.docs.first.get('id');
    }

  }

  void addPost(DtoPost dtoPost) async {
    await _post.add(dtoPost.toJson());
  }
}
