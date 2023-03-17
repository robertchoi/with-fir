import 'package:flutter/material.dart';
import 'package:instagram/ui/login/login_view.dart';
import 'package:instagram/ui/login/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        )
      ],
      child: LoginView(),
    );
  }
}
