import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_stack/home_stack.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/product_stack/product_stack.dart';
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:flutter_application_1/redux/app_reducer.dart';
//redux
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');

  final myStore = Store<AppState>(appReducer, initialState: AppState.initial());

  runApp(MyApp(store: myStore));
}

class MyApp extends StatelessWidget {
  // MyApp({Key? key, required this.store}) : super(key: key);
  // final Store<AppState> store;
  final Store<AppState> store;

  // MyApp({this.store}); //this.store = myStore;
  // MyApp({Key? key, required this.store}) : super(key: key);

  const MyApp({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'CCTV App',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              // primaryColor: Color(0xff00b0ff),
              canvasColor: Colors.blue[50],
              // accentColor: Colors.orange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: TextTheme(
                headline1: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              )),
          debugShowCheckedModeBanner: false,
          // home: MyHomePage(title: 'Flutter TOT'),
          initialRoute: '/',
          routes: {
            '/': (context) => token == null ? LoginPage() : HomeStack(),
            '/homestack': (context) => HomeStack(),
            '/productstack': (context) => ProductStack(),
            '/register': (context) => RegisterPage(),
            '/login': (context) => LoginPage()
          },
        ));
  }
}
