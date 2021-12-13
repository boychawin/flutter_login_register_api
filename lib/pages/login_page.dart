import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';
//alert
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _fbKey = GlobalKey<FormBuilderState>();

  var FormBuilderValidators;
  var _emailError;

  Future<void> login(Map formValues) async {
    //formValues['name']
    //print(formValues);
    try {
      var url = 'http://localhost/nt/cctv_web_api/api/login/restful';
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "email": formValues['email'],
            "password": formValues['password']
          }));
      Map<String, dynamic> err = json.decode(response.body);

      // if (err['error']) {
      if (response.statusCode == 200) {
        Map<String, dynamic> token = json.decode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.body);

        //get Profile
        var profileUrl = 'http://localhost/nt/cctv_web_api/api/users/restful';
        var responseProfile = await http.get(Uri.parse(profileUrl),
            headers: {'Authorization': 'Bearer ${token['access_token']}'});
        Map<String, dynamic> profile = json.decode(responseProfile.body);
        var user = profile['data']['user']; // { id: 111, name: john ....}
        await prefs.setString('profile', json.encode(user));
        print('profile: $user');

        //กลับไปที่หน้า HomeStack
        Navigator.pushNamedAndRemoveUntil(
            context, '/homestack', (route) => false);
      } else {
        // print(err);
        Alert(
          context: context,
          type: AlertType.warning,
          // title: "แจ้งเตือน",
          desc: '${err['message']}',
          buttons: [
            DialogButton(
              child: Text(
                "ปิด",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () => Navigator.pop(context),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0),
              ]),
            )
          ],
        )..show();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.lightBlue],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                FlutterLogo(size: 80),
                SizedBox(height: 40),
                FormBuilder(
                  key: _fbKey,
                  initialValue: {'email': '', 'password': ''},
                  autovalidateMode: AutovalidateMode
                      .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        name: "email",
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorStyle:
                                TextStyle(backgroundColor: Colors.white)),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "ป้อนข้อมูลอีเมล์ด้วย"),
                          EmailValidator(errorText: "รูปแบบอีเมล์ไม่ถูกต้อง"),
                        ]),
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        name: "password",
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            errorText: _emailError,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorStyle:
                                TextStyle(backgroundColor: Colors.white)),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "ป้อนข้อมูลรหัสผ่านด้วย"),
                          MinLengthValidator(6,
                              errorText: "รหัสผ่านต้อง 6 ตัวอักษรขึ้นไป"),
                        ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton.icon(
                        label: Text('เข้าสู่ระบบ'),
                        icon: Icon(Icons.login_rounded),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          //side: BorderSide(color: Colors.red, width: 5),
                          textStyle: TextStyle(fontSize: 15),
                          padding: EdgeInsets.all(15),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          // shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () {
                          if (_fbKey.currentState!.saveAndValidate()) {
                            // print(_fbKey.currentState.value);
                            login(_fbKey.currentState!.value);
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        child: Text("สมัครสมาชิก",
                            style: TextStyle(
                                decoration: TextDecoration.underline)),
                        textColor: Colors.white,
                        onPressed: () {
                          // _fbKey.currentState.reset();
                          Navigator.pushNamed(context, '/register');
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
