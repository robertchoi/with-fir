import 'package:flutter/material.dart';
import 'package:instagram/ui/main/main_view.dart';
import 'package:instagram/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainViewModel>(create: (_) => MainViewModel())
      ],
      child: MainView(),
    );
  }
}
