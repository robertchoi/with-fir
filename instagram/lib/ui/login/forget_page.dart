import 'package:flutter/material.dart';
import 'package:instagram/ui/login/forget_view.dart';
import 'package:instagram/ui/login/forget_view_model.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ForgotPasswordViewModel>(
            create: (_) => ForgotPasswordViewModel()),
      ],
      child: ForgotPasswordView(),
    );
  }
}
