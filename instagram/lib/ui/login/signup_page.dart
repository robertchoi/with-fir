import 'package:flutter/material.dart';
import 'package:instagram/ui/login/signup_view.dart';
import 'package:instagram/ui/login/signup_view_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignUpViewModel>(
            create: (_) => SignUpViewModel())
      ],
      child: SignUpView(),
    );
  }
}
