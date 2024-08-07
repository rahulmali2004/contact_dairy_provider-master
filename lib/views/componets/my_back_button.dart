import 'package:flutter/material.dart';

class My_Back_Button extends StatelessWidget {
  const My_Back_Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios));
  }
}
