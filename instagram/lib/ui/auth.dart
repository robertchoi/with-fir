import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/ui/home.dart';
import 'package:instagram/ui/login/login_page.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //로그인이 안 돼 있을 때
          if (!snapshot.hasData) {
            return const LoginPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) { //로딩중
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) { //에러 발생 시
            return Text('${snapshot.hasError}');
          } else {  //로그인정보가 있으면
            return const Home();
          }
        },
      ),
    );
  }
}
