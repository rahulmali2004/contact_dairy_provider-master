import 'package:contact_dairy_provider/utild/routes.dart';
import 'package:contact_dairy_provider/views/componets/add_contact.dart';
import 'package:contact_dairy_provider/views/componets/them.dart';
import 'package:contact_dairy_provider/views/screens/add_contact_page.dart';
import 'package:contact_dairy_provider/views/screens/contact_Detail_Page.dart';
import 'package:contact_dairy_provider/views/screens/edit_Contact_Page.dart';
import 'package:contact_dairy_provider/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(
          create: (context) => MyTheme(prefs: prefs),
        ),
        ListenableProvider(create: (create) => Add_Contact(prefs: prefs))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      themeMode: Provider.of<MyTheme>(context).getTheme
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      routes: {
        MyRoutes.home_page: (context) => const home_page(),
        MyRoutes.contact_Detail_Page: (context) => const contact_Detail_Page(),
        MyRoutes.Add_Contact_Page: (context) => Add_Contact_Page(),
        MyRoutes.edit_Contact_Page: (context) => edit_Contact_Page(),
      },
    );
  }
}
