import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
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
                icon: Icon(Icons.exit_to_app, color: Colors.white, size: 35),
                onPressed: () {
                  logout();
                }),
          ],
        ),
        body: Column(
          children: [
            // Expanded(
            //   flex: isPortrait ? 1 : 3 ,
            //     child: Center(
            //     child: StoreConnector<AppState, Map<String, dynamic>>(
            //             distinct: true,
            //             converter: (store) => store.state.profileState.profile,
            //             builder: (context, profile) {
            //               return Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Text('สวัสดีคุณ ${profile['name']}'),
            //                     Text('Email: ${profile['email']} Role: ${profile['role']}')
            //                   ],
            //               );
            //             },
            //           ),
            //       )
            //   ),
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
                        children: [
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
                      children: [
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
