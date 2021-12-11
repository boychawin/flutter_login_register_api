import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/register_page.dart';
//redux

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          // primaryColor: Color(0xff00b0ff),
          canvasColor: Colors.blue[50],
          accentColor: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
          )),
      debugShowCheckedModeBanner: false,
      // home: MyHomePage(title: 'Flutter TOT'),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        // '/': (context) => token == null ? LoginPage() : HomeStack(),
        // '/homestack': (context) => HomeStack(),
        // '/productstack': (context) => ProductStack(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage()
      },
    );
  }
}
