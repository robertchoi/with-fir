import 'package:instagram/ui/auth.dart';
import 'package:instagram/ui/login/forget_view.dart';
import 'package:instagram/ui/login/signup_page.dart';

class RouteNames {
  static const splash = '/';
  static const signUp = '/signUp';
  static const forgotPassword = '/forgotPassword';
}

var namedRoutes = {
  RouteNames.splash: (context) => const Auth(),
  RouteNames.signUp: (context) => const SignUpPage(),
  RouteNames.forgotPassword: (context) => ForgotPasswordView(),

};