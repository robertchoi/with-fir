import 'package:flutter/material.dart';
import 'package:instagram/ui/home/home_view_model.dart';
import 'package:instagram/ui/post/post_view_model.dart';
import 'package:provider/provider.dart';

class PostView extends StatelessWidget {
  PostView({Key? key}) : super(key: key);

  late HomeViewModel _homeViewModel;

  @override
  Widget build(BuildContext context) {
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.withOpacity(0.5))),
          child: Consumer<PostViewModel>(
            builder: (_, model, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _title(model),
                  const SizedBox(height: 30),
                  _image(model),
                  const SizedBox(height: 100),
                  _nextPage(context, model),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// 제목 업로드
  _title(PostViewModel model) {
    return Row(
      children: [
        const Text(
          '제목 :',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(isDense: true),
            onChanged: (value) {
              model.setTitleText(value);
            },
          ),
        ),
      ],
    );
  }

  /// 이미지 업로드
  _image(PostViewModel model) {
    return Row(
      children: [
        const Text(
          '이미지 URL :',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(isDense: true),
            onChanged: (value) {
              model.setImageUrl(value);
            },
          ),
        ),
      ],
    );
  }

  _nextPage(context, PostViewModel model){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 100)),
        onPressed: () {
          model.addPost();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.grey,
                content: Text('업로드 성공!',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1)),
          );
          _homeViewModel.resetBottomIndex();
        },
        child: const Text('업로드'));
  }
}
