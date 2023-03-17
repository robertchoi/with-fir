import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/config/routes.dart';
import 'package:instagram/ui/login/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginViewModel loginViewModel = LoginViewModel();
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  /// 로그인폼
  _loginForm(controller, hintText, {obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          filled: true,
          isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.6)))),
    );
  }

  /// 로그인 버튼
  _loginButton(context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          loginViewModel.singIn(
              context, idController.text, passwordController.text);
        },
        child: const Text('로그인',
            style: TextStyle(color: Colors.white, fontSize: 17)),
      ),
    );
  }

  /// 소셜로그인 버튼
  _socialLogin() {
    return GestureDetector(
      onTap: () {
        loginViewModel.googleLogin();
        print('소셜로그인');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/google-icon.png', scale: 3),
          const SizedBox(width: 10),
          const Text('Google로 로그인', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  /// 회원가입 버튼
  _registerButton(context) {
    return TextButton(
        onPressed: () {
          print('회원가입 페이지 이동');
          Navigator.pushNamed(context, RouteNames.signUp);
        },
        child: const Text('가입하기',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.bold)));
  }

  /// 비밀번호 재설정 버튼
  Widget _forgotButton(context) {
    return TextButton(
        onPressed: () {
          print('비밀번호재설정');
          Navigator.pushNamed(context, RouteNames.forgotPassword);
        },
        child: const Text('비밀번호를 잊으셨나요?'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //상단 box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.withOpacity(0.5))),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  //logo
                  const Text('Instagram',
                      style: TextStyle(
                        fontFamily: 'logoFont',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 60),
                  //아이디
                  _loginForm(idController, '이메일을 입력하세요!'),
                  const SizedBox(height: 10),
                  //비밀번호
                  _loginForm(passwordController, '비밀번호를 입력하세요!', obscureText: true),
                  const SizedBox(height: 20),
                  //로그인버튼
                  _loginButton(context),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Flexible(
                          flex: 1,
                          child: Divider(color: Colors.black, thickness: 0.5)),
                      Text('      또는      ',
                          style: TextStyle(color: Colors.grey, fontSize: 17)),
                      Flexible(
                          flex: 1,
                          child: Divider(color: Colors.black, thickness: 0.5)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //소셜로그인
                  _socialLogin(),
                  const SizedBox(height: 10),
                  //비밀번호잊었을 때
                  _forgotButton(context),
                ],
              ),
            ),

            //하단 box
            Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.withOpacity(0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('계정이 없으신가요?', style: TextStyle(fontSize: 15)),
                    //회원가입 버튼
                    _registerButton(context),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
