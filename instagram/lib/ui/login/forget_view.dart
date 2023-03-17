import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffF5F5F5),
      // appBar: _appBar(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 150),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.5))),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('비밀번호 새로 정하기',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 100),
              _inputEmail(),
              const SizedBox(height: 20),
              _submit(context),
            ],
          ),
        ),
      ),
    );
  }

  // _appBar(context) {
  //   return AppBar(
  //       backgroundColor: const Color(0xffF5F5F5),
  //       elevation: 0,
  //       leading: IconButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           icon: const Icon(Icons.arrow_back_ios, color: Colors.black)));
  // }

  _inputEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
            filled: true,
            isDense: true,
            hintText: '이메일 입력하세요',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.6)))),
        validator: (value) {
          return EmailValidator.validate(value!)
              ? null
              : _showToast('이메일 양식이 아닙니다.');
        },
      ),
    );
  }

  _showToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.yellow);
  }

  _submit(context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: emailController.text.isNotEmpty
                ? Colors.blue
                : Colors.lightBlueAccent.withOpacity(0.5)),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            resetPassword(emailController.text);
            Navigator.pop(context);
          }
        },
        child: const Text('이메일 보내기'));
  }

  resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
