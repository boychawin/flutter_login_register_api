import 'package:flutter/material.dart';
import 'package:flutter_application_1/redux/app_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          StoreConnector<AppState, Map<String, dynamic>>(
            distinct: true,
            converter: (store) => store.state.profileState.profile,
            builder: (context, profile) {
              return UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo/logo.png'),
                ),
                accountEmail:
                    Text('${profile['email']} role: ${profile['email']}'),
                accountName: Text('${profile['email']}'),
              );
            },
          ),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text('หน้าหลัก'),
              trailing: const Icon(Icons.arrow_right),
              // selected: ModalRoute.of(context).settings.name == 'homestack/home' ? true : false,
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil('/homestack', (route) => false);
              }),
          ListTile(
              leading: const Icon(Icons.star),
              title: const Text('สินค้า'),
              trailing: const Icon(Icons.arrow_right),
              // selected: ModalRoute.of(context).settings.name == 'productstack/product' ? true : false,
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil('/productstack', (route) => false);
              }),
        ],
      ),
    );
  }
}
