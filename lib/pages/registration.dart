import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopapp_tut/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:sweetalert/sweetalert.dart';

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
  TextEditingController cpass = new TextEditingController();
  String GroupValue = "male";
  String msg = '';

  // ignore: missing_return
  void post() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        GroupValue = e;
       print(e);

      } else if (e == "felame") {
        GroupValue = e;
        print(e);
      }
    });
  }


  Future<List> login() async {
    print("gg");
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/submit_data.php", body: {
      "username": user.text,
      "password": pass.text,
      "email": email.text,
      "nic": nic.text,
    });

    print("gg");
    // var datauser = jsonDecode(response.body);
    print(user.text);
    print(pass.text);
    print(email.text);
    print(nic.text);
    //print(user.text);
    if (user.text != "") {
      if (pass.text != "") {
        if (cpass.text != "") {
          if (email.text != "") {
            if (nic.text != "") {
              if (pass.text == cpass.text) {
                SweetAlert.show(context,
                    title: "Registred",
                    subtitle: "",
                    style: SweetAlertStyle.success);

                Timer(Duration(seconds: 3), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                });
              } else {
                print("Password Unmatch");
                SweetAlert.show(context,
                    title: "Password Unmatch",
                    subtitle: "please enter same password",
                    style: SweetAlertStyle.error);
              }
            } else {
              print("Invalid N I C");
              nic.text = "";
              SweetAlert.show(context,
                  title: "Empty NIC",
                  subtitle: "please check your nic",
                  style: SweetAlertStyle.confirm);
            }
          } else {
            print("Empty Email");
            email.text = "";
            SweetAlert.show(context,
                title: "Empty Email",
                subtitle: "please check your email",
                style: SweetAlertStyle.confirm);
          }
        } else {
          print("Empty cpassword ");
          cpass.text = "";
          SweetAlert.show(context,
              title: "Empty Confirm Password",
              subtitle: "please check your confirm password",
              style: SweetAlertStyle.confirm);
        }
      } else {
        print("Invalid Password!");
        pass.text = "";
        SweetAlert.show(context,
            title: "Empty Password",
            subtitle: "please check your password",
            style: SweetAlertStyle.confirm);
      }
    } else {
      print("Invalid Username!");
      user.text = "";
      SweetAlert.show(context,
          title: "Empty Username",
          subtitle: "please check your username",
          style: SweetAlertStyle.confirm);
    }
    setState(() {
      //var username = datauser[0]['username'];
    });


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

    final cpasswordField = TextField(
      controller: cpass,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final r1 = Expanded(
      child: ListTile(
        title: Text(
          "Male",
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.black),
        ),
        trailing: new Radio(
          value: "male",
          groupValue: GroupValue,
          onChanged: (e) => (valueChanged(e)),
        ),
      ),
    );

    final r2 = Expanded(
      child: ListTile(
        title: Text(
          "Female",
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.black),
        ),
        trailing: new Radio(
          value: "female",
          groupValue: GroupValue,
          onChanged: (e) => (valueChanged(e)),
        ),
      ),
    );

      final Email = TextField(
      controller: email,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final Nic = TextField(
      controller: nic,
      obscureText: false,
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
          login();
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => Login()),
//          );
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
                  SizedBox(height: 25.0),
                  cpasswordField,
                  SizedBox(height: 15.0),
                  Email,
                  SizedBox(height: 25.0),
                  Nic,
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                    r1,r2
                    ],
                  ),
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
