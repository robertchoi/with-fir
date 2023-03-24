import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatelessWidget {
  TextEditingController email = TextEditingController();
  ForgotPassword({super.key});

  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '로그인 도움말',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: Center(
          child: Column(
            children: [
              Text(
                '내 계정 찾기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '사용자 이름 또는 계정에 연결된 이메일\n주소나 전화번호를 입력하세요.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 30.0),
              Container(
                height: 55.0,
                child: TextFormField(
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp('[a-zA-Z0-9_@.]'),
                        allow: true)
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '사용자 이메일 주소',
                    filled: true,
                    fillColor: Colors.grey[80],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                        ),
                        onPressed: () async {
                          try {
                            await firebaseAuth.sendPasswordResetEmail(
                                email: email.text);
                            Navigator.of(context).pop();
                            snackBarMessenger(
                                context, '이메일로 비밀번호 변경 링크가 발송되었습니다.');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              snackBarMessenger(context, '사용자가 존재하지 않습니다.');
                            } else if (e.code == 'invalid-email') {
                              snackBarMessenger(context, '올바른 이메일 형식을 입력해주세요.');
                            } else {
                              print(e.code);
                            }
                          }
                        },
                        child: Text(
                          '비밀번호 찾기',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
