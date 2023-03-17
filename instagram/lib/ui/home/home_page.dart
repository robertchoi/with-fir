import 'package:flutter/material.dart';
import 'package:instagram/ui/home/home_view.dart';
import 'package:instagram/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel())
    //   ],
    //   child: const HomeView(),
    // );
    return const HomeView();
  }
}
