import 'dart:convert';
import 'dart:math';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  TextEditingController address = new TextEditingController();

  // ignore: non_constant_identifier_names
  String GroupValue = "male";
  String gender;

  String msg = '';

  valueChanged(x) {
    setState(() {
      if (x == "male") {
        GroupValue = x;
        gender = x;
        print(x);
      } else if (x == "female") {
        GroupValue = x;
        gender = x;
        print(x);
      }
    });
  }

  // ignore: missing_return
  Future<List> register() async {
    print("gg");
    // var datauser = jsonDecode(response.body);
    print(user.text);
    print(pass.text);
    print(email.text);
    print(nic.text);
    print(e);
    print(address.text);
    //print(user.text);
    if (user.text != "") {
      if (pass.text != "") {
        if (cpass.text != "") {
          if (email.text != "") {
            var e = email.text;
            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(e);
            if (emailValid) {
              //print(emailValid);
              //  Fluttertoast.showToast(msg: "Email "+emailValid.toString());
              if (nic.text != "") {
                if (address.text != "") {
                  if (gender != "") {
                    if (pass.text == cpass.text) {
                      print("gg");

                      // assert(EmailValidator.validate(email.text));
                      final response = await http.post(
                          "https://etrendsapp.000webhostapp.com/submit_data.php",
                          body: {
                            "username": user.text,
                            "password": pass.text,
                            "email": email.text,
                            "nic": nic.text,
                            "gender": gender,
                            "address": address.text,
                          });
                        print(gender);
                      Fluttertoast.showToast(msg: 'Registered');

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );

                      user.text = "";
                      pass.text = "";
                      cpass.text = "";
                      email.text = "";
                      nic.text = "";
                      address.text = "";
                    } else {
                      print("Empty Address");
                      Fluttertoast.showToast(msg: 'Password Unmatch');
                    }
                  } else {
                    print("Select Your Gender Type");
                    Fluttertoast.showToast(msg: 'Select Gender');
                  }
                } else {
                  print("Empty Address");
                  Fluttertoast.showToast(msg: 'Empty Address');
                }
              } else {
                print("Invalid N I C");
                nic.text = "";
                Fluttertoast.showToast(msg: 'Empty NIC');
              }
            } else {
              Fluttertoast.showToast(msg: "Email " + emailValid.toString());
            }
          } else {
            print("Empty Email");
            email.text = "";
            Fluttertoast.showToast(msg: 'Empty Email');
          }
        } else {
          print("Empty cpassword ");
          cpass.text = "";
          Fluttertoast.showToast(msg: 'Empty Confirm Password');
        }
      } else {
        print("Invalid Password!");
        pass.text = "";
        Fluttertoast.showToast(msg: 'Empty Password');
      }
    } else {
      print("Invalid Username!");
      user.text = "";
      Fluttertoast.showToast(msg: 'Empty Username');
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
          hintText: "UserName",
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

    final cpasswordField = TextField(
      controller: cpass,
      obscureText: true,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold),
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
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold),
        ),
        trailing: new Radio(
          value: "male",
          groupValue: GroupValue,
          onChanged: (x) => (valueChanged(x)),
        ),
      ),
    );

    final r2 = Expanded(
      child: ListTile(
        title: Text(
          "Female",
          textAlign: TextAlign.end,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold),
        ),
        trailing: new Radio(
          value: "female",
          groupValue: GroupValue,
          onChanged: (x) => (valueChanged(x)),
        ),
      ),
    );

    final Email = TextField(
      controller: email,
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final Nic = TextField(
      controller: nic,
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "NIC",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final add = TextField(
      controller: address,
      obscureText: false,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Address",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    // ignore: non_constant_identifier_names
    final RegistrationButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color:  Colors.brown,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          register();
        },
        child: Text("Registration",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold)),
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
                  SizedBox(height: 25.0),
                  cpasswordField,
                  SizedBox(height: 15.0),
                  Email,
                  SizedBox(height: 25.0),
                  Nic,
                  SizedBox(height: 15.0),
                  add,
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[r1, r2],
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
