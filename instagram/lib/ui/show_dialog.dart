import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowDialogView extends StatelessWidget {
  const ShowDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('앱을 종료하겠습니까?'),
      actions: [
        ElevatedButton(
            onPressed: () {
              // exit(0);
              SystemNavigator.pop();
            },
            child: const Text('확인')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소')),
      ],
    );
  }
}
