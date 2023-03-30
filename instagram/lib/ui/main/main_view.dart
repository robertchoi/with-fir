import 'package:flutter/material.dart';
import 'package:instagram/data/model/dto_post.dart';
import 'package:instagram/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);

  late final MainViewModel mainViewModel;

  @override
  Widget build(BuildContext context) {
    mainViewModel = Provider.of<MainViewModel>(context, listen: false);
    mainViewModel.loadItems();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Consumer<MainViewModel>(builder: (_, MainViewModel model, __) {
          return ListView.builder(
              itemCount: model.postCount,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // 상단
                    _top(model.getItem(index)),
                    const SizedBox(height: 10),
                    // 중단
                    _contentImage(model.getItem(index)),
                    // 중단 아이콘
                    _contentImageBottomIcon(),
                    // 하단
                    _contentText(model.getItem(index)),
                    const SizedBox(height: 30),
                  ],
                );
              });
        }),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text('Wegram',
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'logoFont')),
      actions: [
        GestureDetector(
            onTap: () {},
            child: const Icon(Icons.favorite_border, color: Colors.black)),
        GestureDetector(
            onTap: () {},
            child: Image.asset('assets/icon_send.png', scale: 1.8))
      ],
    );
  }

  _top(model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_userInfo(model), const Icon(Icons.more_horiz)],
      ),
    );
  }

  _userInfo(DtoPost dtoPost) {
    return Row(
      children: [
        CircleAvatar(
            backgroundImage: NetworkImage(dtoPost.userProfile.toString())),
        const SizedBox(width: 20),
        Text(dtoPost.userName.toString()),
      ],
    );
  }

  _contentImage(DtoPost dtoPost) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Image.network(
        dtoPost.imageUrl.toString(),
        fit: BoxFit.cover,
      ),
    );
  }

  _contentImageBottomIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite_border),
              const SizedBox(width: 10),
              const Icon(Icons.chat_bubble_outline),
              const SizedBox(width: 10),
              Image.asset('assets/icon_send.png', scale: 1.7),
            ],
          ),
          const Icon(Icons.bookmark_border, size: 27)
        ],
      ),
    );
  }

  _contentText(DtoPost dtoPost) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            dtoPost.userName.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 15),
          Text(dtoPost.titleText.toString()),
        ],
      ),
    );
  }
}
