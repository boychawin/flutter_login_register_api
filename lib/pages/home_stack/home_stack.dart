import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_stack/about_page.dart';
import 'package:flutter_application_1/pages/home_stack/home_page.dart';
import 'package:flutter_application_1/pages/home_stack/map_page.dart';


class HomeStack extends StatelessWidget {
  const HomeStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Navigator(
      initialRoute: 'homestack/home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'homestack/home':
            builder = (BuildContext _) => MyHomePage();
            break;
          case 'homestack/about':
            builder = (BuildContext _) => AboutPage();
            break;
          case 'homestack/map':
            builder = (BuildContext _) => MapPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
