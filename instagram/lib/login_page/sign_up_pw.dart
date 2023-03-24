import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class SignUpPw extends StatelessWidget {
  String id;
  String pw = '';

  SignUpPw({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Center(
          child: Column(
            children: [
              Text(
                '사용자 비밀번호 선택',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
              ),
              Text(
                '나중에 언제든지 변경할 수 있습니다.',
                style: TextStyle(color: Colors.grey, fontSize: 13.0),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 55.0,
                child: TextFormField(
                  onChanged: (value) => pw = value,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp('[a-zA-z0-9!@#]'),
                        allow: true)
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '사용자 비밀번호',
                    filled: true,
                    fillColor: Colors.grey[100],
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
                        onPressed: () {
                          signUp(context);
                        },
                        child: Text(
                          '계정 만들기',
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

  void signUp(context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: id, password: pw)
          .then(
        (value) {
          if (value.user!.email != null) {
            Navigator.pop(context);
            Navigator.pop(context);
            FirebaseAuth.instance.signOut();
          }
          return value;
        },
      );
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              content: Text('비밀번호는 숫자,영문 또는 특수문자를 사용하여 만들어주세요'),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('확인'),
                  ),
                ),
              ],
            );
          },
        );
      else if (e.code == 'email-already-in-use')
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              content: Text('이미 존재하는 계정입니다.'),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('확인'),
                  ),
                ),
              ],
            );
          },
        );
      else
        print(e.code);
    }
  }
}
