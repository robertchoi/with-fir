import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled1/login_page/sign_up_id.dart';
import 'package:untitled1/main_page/front_screen.dart';

import '2_forgot_password.dart';
import 'kakao_login/kakao_login.dart';
import 'kakao_login/main_view_model.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final firebaseAuth = FirebaseAuth.instance;

  final viewModel = MainViewModel(KakaoLogin());

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset('asset/img/insta.png'),
                    SizedBox(height: 30.0),
                    _loginText('전화번호, 사용자 이름 또는 이메일', emailController),
                    SizedBox(height: 10),
                    _loginText('비밀번호', passwordController, obscureText: true),
                    SizedBox(height: 10),
                    _loginButton(context, emailController, passwordController),
                    SizedBox(height: 30.0),
                    _loginLine(),
                    SizedBox(height: 40.0),
                    _googleLogin(context),
                    SizedBox(height: 3.0),
                    _kakaoLogin(context),
                    SizedBox(height: 5.0),
                    _forgotPassword(context),
                    SizedBox(height: 60.0),
                  ],
                ),
              ),
              Divider(color: Colors.black, thickness: .1),
              _signUp(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _loginText(text, contoller, {obscureText = false}) {
    return Container(
      height: 50,
      child: TextField(
        controller: contoller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: text,
        ),
      ),
    );
  }

  Widget _loginLine() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.black, thickness: .3)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '또는',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(child: Divider(color: Colors.black, thickness: .3)),
      ],
    );
  }

  Widget _googleLogin(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(right: 10.0),
            height: 20,
            width: 20,
            child: Image.asset('asset/img/gogle.png')),
        TextButton(
            onPressed: signInWithGoogle,
            child: Text('Gogole으로 로그인',
                style: TextStyle(fontSize: 19.0, color: Colors.black))),
      ],
    );
  }

  Widget _kakaoLogin(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(right: 10.0),
            height: 20,
            width: 20,
            child: Image.asset('asset/img/kakao.png')),
        TextButton(
            onPressed: () async {
              await viewModel.login();
              if (viewModel.isLogined) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => FrontScreen()));
              } else {
                snackBarMessenger(context, '카카오톡 로그인 실패!');
              }
            },
            child: Text('Kakao 로그인',
                style: TextStyle(fontSize: 19.0, color: Colors.black))),
      ],
    );
  }

  Widget _forgotPassword(context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ForgotPassword(),
            ),
          );
        },
        child: Text('비밀번호를 잊으셨나요?', style: TextStyle(color: Colors.black)));
  }

  Widget _signUp(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('계정이 없으신가요?'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SignUpId(),
              ),
            );
          },
          child: Text(
            '가입하기',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginButton(context, emailContoroller, passwordController) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              signIn(emailContoroller.text, passwordController.text);
            },
            child: Text('로그인'),
          ),
        ),
      ],
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signIn(String email, String pw) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pw)
          .then((value) {
        print(value);
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('사용자가 존재하지 않습니다.');
      } else if (e.code == 'wrong-password') {
        print('비밀번호를 확인하세요.');
      } else if (e.code == 'invalid-email') {
        print('이메일을 확인하세요.');
      } else {
        print(e.code);
      }
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
}
