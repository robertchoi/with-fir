import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/ui/home/home_page.dart';
import 'package:instagram/ui/home/home_view_model.dart';
import 'package:instagram/ui/login/login_page.dart';
import 'package:instagram/ui/show_dialog.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  Auth({Key? key}) : super(key: key);

  late HomeViewModel _homeViewModel;

  @override
  Widget build(BuildContext context) {
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        return _willPopAction(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //로그인이 안 돼 있을 때
            if (!snapshot.hasData) {
              return const LoginPage();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              //로딩중
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              //에러 발생 시
              return Text('${snapshot.hasError}');
            } else {
              //로그인정보가 있으면
              return const HomePage();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _willPopAction(context) async {
    if (_homeViewModel.bottomIndex.length ==1) {
      showDialog(context: context, builder: (_)=> const ShowDialogView());
      return true;
    } else {
      _homeViewModel.popBottomIndex();
      return false;
    }
  }
}
