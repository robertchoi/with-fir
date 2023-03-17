import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text('Wegram',
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'logoFont')),
      actions: [
        GestureDetector(
            onTap: () {},
            child: const Icon(Icons.favorite_border, color: Colors.black)),
        GestureDetector(
            onTap: () {},
            child: Image.asset('assets/icon_send.png', scale: 1.8))
      ],
    );
  }
}
