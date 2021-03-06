import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp_tut/pages/admin.dart';
import 'package:shopapp_tut/pages/home.dart';
import 'package:shopapp_tut/pages/product_details.dart';
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
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold);

  //===============================================================================================================================

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> login() async {
    //====================read login db line by line==========================
    final responseRow =
        await http.post("https://etrendsapp.000webhostapp.com/getrows.php");
    var rows = json.decode(responseRow.body);
    print(rows);
    //=====================get user & pwd======================================
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
    //======================== admin============================================
    print(datausers[i]);
    if (datausers[i]['username'] == user.text) {
      if (datausers[i]['password'].toString() == pass.text) {
        if (datausers[i]['username'] == "admin") {
          Fluttertoast.showToast(msg: 'Admin');
          String username2 = user.text;

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Admin(username2)),
            );

        } else {
          //==============================User=======================================

          Fluttertoast.showToast(msg: 'Login Successful');
          String username = user.text;

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(username)),
            );


          //user.text = "";
          pass.text = "";
        }
      } else {
        print("Invalid Password!");
        Fluttertoast.showToast(msg: 'Password Invalid');
        pass.text = "";
      }
    } else {
      print("Invalid Username!");
      Fluttertoast.showToast(msg: 'Username Invalid');
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
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",

          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: pass,
      obscureText: true,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown,
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
      color: Colors.brown,
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
                      "assets/logo.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text("T R E N D S ™ " ,
                    style: TextStyle(color: Colors.green , fontSize: 20, fontWeight: FontWeight.bold,),
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
