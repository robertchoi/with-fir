import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/ui/home/home_view_model.dart';
import 'package:instagram/ui/main/main_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(builder: (_, model, __) {
        return IndexedStack(
          index: model.currentIndex,
          children: const [
            MainView(),
            Center(child: Text('검색 페이지')),
            Center(child: Text('3번째 페이지')),
            Center(child: Text('4번째 페이지')),
            Center(child: Text('프로필 페이지'))
          ],
        );
      }),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  _bottomNavigationBar() {
    return Consumer<HomeViewModel>(builder: (_, model, __) {
      return BottomNavigationBar(
        currentIndex: model.currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          model.setBottomIndex(value);
          print(model.bottomIndex);
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'home',
              activeIcon: Icon(Icons.home, size: 28)),
          const BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'search',
              activeIcon: Icon(Icons.search_sharp, size: 28)),
          const BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'add',
              activeIcon: Icon(Icons.add_box, size: 28)),
          const BottomNavigationBarItem(
              icon: Icon(Icons.video_collection_outlined),
              label: 'video',
              activeIcon: Icon(Icons.video_collection, size: 28)),
          BottomNavigationBarItem(
              icon: FirebaseAuth.instance.currentUser!.photoURL != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${FirebaseAuth.instance.currentUser!.photoURL}'))
                  : const Icon(Icons.person_2_outlined),
              label: 'profile',
              activeIcon: FirebaseAuth.instance.currentUser!.photoURL != null
                  ? null
                  : const Icon(Icons.person, size: 28)),
        ],
      );
    });
  }

  _signOut() {
    return ElevatedButton(
      onPressed: () async {
        try {
          FirebaseAuth.instance.signOut();
          print('logout');
        } catch (e) {
          print(e.toString());
        }
      },
      child: const Text('로그아웃'),
    );
  }
}
