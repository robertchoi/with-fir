import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram/ui/login/signup_view_model.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference ref = FirebaseFirestore.instance.collection('user');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _textOneItem(hintText, controller, {obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          filled: true,
          isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.6)))),
      validator: (value) {
        if (obscureText == false) {
          _emailValidator(value!);
        } else if (obscureText == true) {
          _passwordValidator(value);
        }
        return null;
      },
    );
  }

  _empty() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  /// 회원가입기능
  _register(context, email, password) async {
    try {
      var newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser.user != null) {
        // 기존 로그인이 있으면 로그아웃
        FirebaseAuth.instance.signOut();
        print('회원가입성공!');
        _showToast('회원가입 성공!');
        Navigator.pushReplacementNamed(context, '/');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('비밀번호 강도가 약합니다.');
      } else if (e.code == 'email-already-in-use') {
        print('이미 존재하는 이메일 입니다.');
      }
    } catch (err) {
      print(err);
    }
  }

  _showToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.yellow);
  }

  _emailValidator(String value) {
    return EmailValidator.validate(value) ? null : _showToast('이메일 양식이 아닙니다.');
  }

  _passwordValidator(value) {
    if (value.isEmpty || value.length < 6) {
      return _showToast('최소 6자리로 입력해주세요.');
    }
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
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.withOpacity(0.5))),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Instagram',
                        style: TextStyle(
                          fontFamily: 'logoFont',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 20),
                    const Text('Sign up to see photos and videos',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const Text('from your friends.',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 30),
                    _textOneItem('Email', emailController),
                    const SizedBox(height: 10),
                    _textOneItem('Password', passwordController,
                        obscureText: true),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _empty()
                                  ? Colors.blue
                                  : Colors.lightBlueAccent.withOpacity(0.5)),
                          onPressed: () async {
                            if(formKey.currentState!.validate()){
                              await _register(context, emailController.text,
                                  passwordController.text);
                              _showToast('회원가입 성공!');
                            }
                          },
                          child: const Text('Sign up')),
                    ),
                    const SizedBox(height: 30),
                    const Text.rich(
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                        TextSpan(children: [
                          TextSpan(text: 'By signing up, you agree to our'),
                          TextSpan(
                              text: ' Terms , Data',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    const SizedBox(height: 5),
                    const Text.rich(
                        style: TextStyle(color: Colors.grey),
                        TextSpan(children: [
                          TextSpan(
                              text: 'Policy',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ' and '),
                          TextSpan(
                              text: 'Cookies Policy .',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.withOpacity(0.5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an account?',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Log in",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
