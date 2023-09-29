import 'package:contact_dairy_provider/views/componets/them.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Theme_Icon extends StatelessWidget {
  const Theme_Icon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Provider.of<MyTheme>(context, listen: false).changeTheme();
      },
      icon: Icon(
        Provider.of<MyTheme>(context).isDark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
    );
  }
}
