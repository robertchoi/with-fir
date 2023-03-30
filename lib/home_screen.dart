import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/bottom_nav_controller.dart';
import 'page/1.home.dart';
import 'page/2.search.dart';
import 'page/3.upload.dart';
import 'page/4.video.dart';
import 'page/5.profile.dart';

class HomeScreen extends GetView<BottomNavController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: const [
              Home(),
              Search(),
              Upload(),
              Video(),
              Profile(),
            ],
          ),
          appBar: AppBar(
            centerTitle: false, // IOS 자동 가운데 정렬
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
            selectedItemColor: Colors.black,
            showUnselectedLabels: false,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                  icon: controller.pageIndex.value == 0
                      ? Icon(Icons.home)
                      : Icon(Icons.home_outlined),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search,
                      size: controller.pageIndex.value == 1 ? 25.0 : 20.0),
                  label: 'search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined), label: 'add'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.play_arrow_outlined,
                      size: controller.pageIndex.value == 3 ? 25.0 : 20.0),
                  label: 'video'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      size: controller.pageIndex.value == 4 ? 25.0 : 20.0),
                  label: 'profile'),
            ],
          ),
        ),
      ),
    );
  }
}
