import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//alert
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Future<void> register(Map formValues) async {
    //formValues['name']
    //print(formValues);
    var url = 'http://localhost/nt/cctv_web_api/api/register/restful';
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "firstname": formValues['firstname'],
          "lastname": formValues['lastname'],
          "email": formValues['email'],
          "password": formValues['password']
        }));
    print(response);

    if (response.statusCode == 201) {
      Map<String, dynamic> feedback = json.decode(response.body);

      Alert(
        context: context,
        title: "แจ้งเตือน",
        desc: '${feedback['data']}',
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

      //print(feedback['message']);
      // Flushbar(
      //   message: '${feedback['message']}',
      //   icon: Icon(
      //     Icons.info_outline,
      //     size: 28.0,
      //     color: Colors.green,
      //   ),
      //   duration: Duration(seconds: 3),
      //   leftBarIndicatorColor: Colors.green,
      // )..show(context);

      //กลับไปที่หน้า LoginPage
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    } else {
      Map<String, dynamic> err = json.decode(response.body);
      //print(err['errors']['email'][0]);

      Alert(
        context: context,
        title: "แจ้งเตือน",
        desc: '${err['data']}',
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

      // Flushbar(
      //   message: '${err['errors']['email'][0]}',
      //   icon: Icon(
      //     Icons.info_outline,
      //     size: 28.0,
      //     color: Colors.red,
      //   ),
      //   duration: Duration(seconds: 3),
      //   leftBarIndicatorColor: Colors.red,
      // )..show(context);
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
                Text('ลงทะเบียน', style: TextStyle(fontSize: 40)),
                SizedBox(height: 40),
                FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'firstname': '',
                    'lastname': '',
                    'email': '',
                    'password': ''
                  },
                  autovalidateMode: AutovalidateMode
                      .always, //ถ้าไม่ใส่ต้อง submit ก่อนถึงจะตรวจสอบ validation
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        name: "firstname",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'ชื่อ',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorStyle:
                                TextStyle(backgroundColor: Colors.white)),
                        // validators: [
                        //   FormBuilderValidators.required(
                        //       errorText: 'ป้อนข้อมูลชื่อสกุลด้วย'),
                        // ],
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        name: "lastname",
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'สกุล',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorStyle:
                                TextStyle(backgroundColor: Colors.white)),
                        // validators: [
                        //   FormBuilderValidators.required(
                        //       errorText: 'ป้อนข้อมูลชื่อสกุลด้วย'),
                        // ],
                      ),
                      SizedBox(height: 20),
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
                        // validators: [
                        //   FormBuilderValidators.required(
                        //       errorText: 'ป้อนข้อมูลอีเมล์ด้วย'),
                        //   FormBuilderValidators.email(
                        //       errorText: 'รูปแบบอีเมล์ไม่ถูกต้อง'),
                        // ],
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        name: "password",
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorStyle:
                                TextStyle(backgroundColor: Colors.white)),
                        // validators: [
                        //   FormBuilderValidators.required(
                        //       errorText: 'ป้อนข้อมูลรหัสผ่านด้วย'),
                        //   FormBuilderValidators.minLength(3,
                        //       errorText: 'รหัสผ่านต้อง 3 ตัวอักษรขึ้นไป')
                        // ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
                      padding: EdgeInsets.all(20),
                      color: Colors.orange,
                      // minWidth: 100,
                      // height: 20,
                      textColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text("ลงทะเบียน"),
                      onPressed: () {
                        if (_fbKey.currentState!.saveAndValidate()) {
                          // print(_fbKey.currentState.value);
                          register(_fbKey.currentState!.value);
                        }
                      },
                    ),
                    // MaterialButton(
                    //   padding: EdgeInsets.all(20),
                    //   color: Colors.pink,
                    //   // minWidth: 100,
                    //   // height: 20,
                    //   textColor: Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(20)),
                    //   child: Text("ย้อนกลับ"),
                    //   onPressed: () {
                    //     // _fbKey.currentState.reset();
                    //     Navigator.pop(context);
                    //   },
                    // ),
                    Expanded(
                      child: FlatButton(
                        child: Text("ย้อนกลับ",
                            style: TextStyle(
                                decoration: TextDecoration.underline)),
                        textColor: Colors.white,
                        onPressed: () {
                          // _fbKey.currentState.reset();
                          Navigator.pushNamed(context, '/login');
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
