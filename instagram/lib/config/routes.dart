import 'package:instagram/ui/auth.dart';
import 'package:instagram/ui/home/home_page.dart';
import 'package:instagram/ui/login/forget_page.dart';
import 'package:instagram/ui/login/signup_page.dart';
import 'package:instagram/ui/post/post_page.dart';
import 'package:instagram/ui/profile/profile_page.dart';

class RouteNames {
  static const splash = '/';
  static const signUp = '/signUp';
  static const forgotPassword = '/forgotPassword';
  static const home = '/home';
  static const profile = '/profile';
  static const post = '/post';
}

var namedRoutes = {
  RouteNames.splash: (context) => Auth(),
  RouteNames.signUp: (context) => const SignUpPage(),
  RouteNames.forgotPassword: (context) => const ForgotPasswordPage(),
  RouteNames.home: (context) => const HomePage(),
  RouteNames.profile: (context) => const ProfilePage(),
  RouteNames.post: (context) => const PostPage(),
};
