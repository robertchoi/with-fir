import 'package:flutter/material.dart';

class ShowDialogView extends StatelessWidget {
  const ShowDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Text('알림'),
    );
  }
}
