import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopapp_tut/pages/admin.dart';
import 'package:shopapp_tut/pages/home.dart';
import 'package:shopapp_tut/pages/registration.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shopapp_tut/pages/registration.dart' as prefix0;
import 'package:sweetalert/sweetalert.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  //===============================================================================================================================

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> login() async {
    final responseRow =
        await http.post("https://etrendsapp.000webhostapp.com/getrows.php");
    var rows = json.decode(responseRow.body);
    print(rows);

    final response =
        await http.post("https://etrendsapp.000webhostapp.com/getData.php");
    //print(response.statusCode);

    var datausers = json.decode(response.body);

    int i = 0;
    while (i != rows) {
      if (datausers[i]['username'] == user.text) {
        if (datausers[i]['password'].toString() == pass.text) {
          break;
        }
        break;
      }
      i++;
    }
    if (i == rows) {
      i--;
    }

    print(datausers[i]);
    if (datausers[i]['username'] == user.text) {
      if (datausers[i]['password'].toString() == pass.text) {
        if (datausers[i]['username'] == "admin") {
          SweetAlert.show(context,
              title: "Login Successful",
              subtitle: "",
              style: SweetAlertStyle.success);

          Timer(Duration(seconds: 2), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Admin()),
            );
          });
        } else {
          SweetAlert.show(context,
              title: "Login Successful",
              subtitle: "",
              style: SweetAlertStyle.success);

          Timer(Duration(seconds: 2), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          });

          user.text = "";
          pass.text = "";
        }
      } else {
        print("Invalid Password!");
        SweetAlert.show(context,
            title: "Password Invalid",
            subtitle: "please check your password",
            style: SweetAlertStyle.confirm);
        pass.text = "";
      }
    } else {
      print("Invalid Username!");
      SweetAlert.show(context,
          title: "Username Invalid",
          subtitle: "please check your username",
          style: SweetAlertStyle.confirm);
      user.text = "";
    }
  }

  //=================================================================================================================================
  @override
  Widget build(BuildContext context) {
    //=========================================================================
    final username = TextField(
      controller: user,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "UserName",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: pass,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          login();
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // ignore: non_constant_identifier_names
    final RegistrationButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Registration()),
          );
        },
        child: Text("Registration",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    //==================================================================================================================

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  username,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(height: 35.0),
                  loginButon,
                  SizedBox(height: 15.0),
                  RegistrationButton,
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
