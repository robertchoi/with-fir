import 'package:flutter/material.dart';
import 'package:instagram/ui/post/post_view.dart';
import 'package:instagram/ui/post/post_view_model.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostViewModel>(create: (_) => PostViewModel())
      ],
      child: PostView(),
    );
  }
}
