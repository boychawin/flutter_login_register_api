// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/redux/app_reducer.dart';
import 'package:flutter_application_1/widgets/menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Map<String, dynamic> profile;
  // @override
  // void initState() {
  //   super.initState();
  //   // getProfile();
  // }

  // Future<void> getProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // var newProfile = json.decode(prefs.getString('profile'));
  //   // //call redux action
  //   // final store = StoreProvider.of<AppState>(context);
  //   // store.dispatch(updateProfileAction(newProfile));

  //   print(prefs);
  // }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');
    //กลับไปที่หน้า Login
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          title: Image.asset('assets/images/logo_tot.png', height: 30),
          centerTitle: true,
          actions: [
            // IconButton(
            //   icon: Icon(Icons.person_add, color: Colors.white, size: 35),
            //   onPressed: null
            // ),
            IconButton(
                icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 35),
                onPressed: () {
                  logout();
                }),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                flex: isPortrait ? 1 : 3,
                child: Center(
                  child: StoreConnector<AppState, Map<String, dynamic>>(
                    distinct: true,
                    converter: (store) => store.state.profileState.profile,
                    builder: (context, profile) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('สวัสดีคุณ ${profile}'),
                          Text(
                              'Email: ${profile['user_email']} Role: ${profile['user_email']}')
                        ],
                      );
                    },
                  ),
                )),
            Expanded(
              flex: isPortrait ? 8 : 9,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'homestack/about');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.person, size: 80, color: Colors.blue),
                          Text('เกี่ยวกับ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue))
                        ],
                      ),
                      color: Colors.blue[100],
                    ),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    onPressed: () {
                      Navigator.pushNamed(context, 'homestack/map');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.map_rounded, size: 80, color: Colors.blue),
                        Text('แผนที่',
                            style: TextStyle(fontSize: 20, color: Colors.blue))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
