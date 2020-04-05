import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class Profile extends StatefulWidget {
  final uname;

  Profile(this.uname);

  @override
  _ProfileState createState() => _ProfileState(uname);
}

class _ProfileState extends State<Profile> {
  final uname;
  String dropdownGender;

  _ProfileState(this.uname);
  bool _isEnabled = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userBdayController = TextEditingController();

  Future<List<Map<String, dynamic>>> getCardDetails() async {
    final response = await http.post(
        "https://etrendsapp.000webhostapp.com/getCard_Details.php",
        body: {
          "name": uname,
        });
    var datausers = json.decode(response.body);
    for (var data in datausers) {
      Map<String, dynamic> myObject = {
        "name": data['name'],
        "card_number": data['card_number'],
        "card_date": data['card_date'],
        "security_code": data['security_code'],
      };
      print(uname);
      print(data['name']);
      print(data['card_number']);
      print(data['card_date']);
      print(data['security_code']);
    }
    setState(() {
      userIdController.text = datausers[0]['name'];
      userNameController.text = datausers[0]['card_number'];
      userEmailController.text = datausers[0]['card_date'];
      userBdayController.text = datausers[0]['security_code'];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green,
        title: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new HomePage(uname)));
            },
            child: Text('ⓉⓇⒺⓃⒹⓈ')),
        actions: <Widget>[],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(
                    "U S E R      P R O F I L E",
                  ),
                ),
                SizedBox(height: 45.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: false,
                    controller: userIdController,
                    decoration:
                        InputDecoration(labelText: 'User ID ', hintText: 'Id'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'User Id Empty';
                      }
                    },
                  ),
                ),


                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: userNameController,
                    enabled: _isEnabled,
                    decoration: InputDecoration(
                        labelText: 'User Name ', hintText: 'name'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the product name *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: false,
                    controller: userEmailController,
                    decoration: InputDecoration(
                        labelText: 'User Email ', hintText: 'email'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'User  Email Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("Gender :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    DropdownButton<String>(
                      value: dropdownGender,
                      hint: Text("Select Gender"),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 16,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 4,
                        color: Colors.lightGreen,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownGender = newValue;
                          print(dropdownGender);
                          //print(dropdownBrands);
                        });
                        return dropdownGender;
                      },
                      items: <String>[
                        'Male',
                        'Female',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    controller: userBdayController,
                    decoration: InputDecoration(
                        labelText: 'User BirthDay ', hintText: 'BDay'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the BirthDay *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 35.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (dropdownGender != null) {
                              print("Save");
                              Fluttertoast.showToast(msg: 'Details Saved');
                            } else {
                              Fluttertoast.showToast(msg: 'Select the gender');
                            }
                          }
                        },
                        child: new Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 35.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new MaterialButton(
                       onPressed: () {
                         setState(() {
                           _isEnabled = !_isEnabled;
                           if(_isEnabled == true) {
                             Fluttertoast.showToast(msg: 'Edit On');
                           }
                           else {
                             Fluttertoast.showToast(msg: 'Edit Off');
                           }

                         });
                       },
//                        () {
//
//                          Fluttertoast.showToast(msg: 'You can edit details');
//                          print("Edit");
//                        },
                        child: new Text(
                          "Edit Mode",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
