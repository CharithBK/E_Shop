import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopapp_tut/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  //===============================================================================================================================

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController nic = new TextEditingController();

  String msg = '';

  // ignore: missing_return
  void post() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  Future<List> login() async {
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/getData.php", body: {
      "username": user.text,
      "password": pass.text,
      "email": email.text,
      "nic": nic.text,
    });
    var datauser = jsonDecode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      //print(user.text);
      if (datauser['username'] == user.text) {
        if (datauser['password'] == pass.text) {
          if (datauser['email'] == email.text) {
            if (datauser['nic'] == nic.text) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            } else {
              print("Invalid Email!");
              email.text = "";
            }
          } else {
            print("Invalid N I C!");
            nic.text = "";
          }
        } else {
          print("Invalid Password!");
          pass.text = "";
        }
      } else {
        print("Invalid Username!");
        user.text = "";
      }
      setState(() {
        //var username = datauser[0]['username'];
      });
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

    final Email = TextField(
      controller: email,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final Nic = TextField(
      controller: nic,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "NIC",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
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
          post();
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
                  SizedBox(height: 15.0),
                  Email,
                  SizedBox(height: 25.0),
                  Nic,
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
