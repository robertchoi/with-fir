import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:untitled1/main_page/bottom_nav_page/1.home.dart';
import 'package:untitled1/main_page/bottom_nav_page/2.search.dart';
import 'package:untitled1/main_page/bottom_nav_page/3.upload.dart';
import 'package:untitled1/main_page/bottom_nav_page/4.video.dart';
import 'package:untitled1/main_page/bottom_nav_page/5.profile.dart';
import 'package:untitled1/main_page/controller/bottom_nav_controller.dart';

import '../login_page/kakao_login/kakao_login.dart';
import '../login_page/kakao_login/main_view_model.dart';

final viewModel = MainViewModel(KakaoLogin());

class FrontScreen extends GetView<BottomNavController> {
  const FrontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              Home(),
              Search(),
              Upload(),
              Video(),
              Profile(),
            ],
          ),
          appBar: AppBar(
            title: Image.asset(
              'asset/img/logo.jpg',
              width: 120,
            ),
            actions: [
              GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'asset/img/like_off_icon.jpg',
                            width: 30,
                          ),
                        ),
                        SizedBox(width: 15.0),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'asset/img/direct_msg_icon.jpg',
                            width: 30,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.pageIndex.value,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(icon: controller.pageIndex.value == 0 ? Icon(Icons.home) : Icon(Icons.home_outlined), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search, size: controller.pageIndex.value == 1 ? 25.0 : 20.0), label: 'search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined), label: 'add'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.play_arrow_outlined, size: controller.pageIndex.value == 3 ? 25.0 : 20.0), label: 'video'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: controller.pageIndex.value == 4 ? 25.0 : 20.0), label: 'profile'),
            ],
          ),
        ),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              try {
                FirebaseAuth.instance.signOut();
                print('logout');
              } catch (e) {
                print(e.toString());
              }
            },
            child: const Text('로그아웃'),
          ),
          ElevatedButton(
            onPressed: () async {
              await viewModel.logout();
              if (!viewModel.isLogined) {
                Navigator.of(context).pop();
                snackBarMessenger(context, '정상적으로 카카오톡에서 로그아웃 되었습니다.');
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

void snackBarMessenger(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: '확인',
        onPressed: () {},
      ),
    ),
  );
}
