import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled1/firebase_options.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:untitled1/main_page/binding/init_bindings.dart';
import 'package:untitled1/main_page/front_screen.dart';

import 'login_page/1_main_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: 'b419bbc154ab2fd405346e210a8fc9a3',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      initialBinding: InitBinding(),
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 로그인 데이터가 없을때 보여줄 화면
          if (snapshot.hasData)
            return LoginPage();
          // 로그인 데이터를 로딩중일때
          else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          // 로그인이 완료 되었을 경우
          else
            return FrontScreen();
        },
      ),
    );
  }
}
