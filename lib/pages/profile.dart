import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp_tut/pages/shipping_address.dart';
import 'home.dart';
import 'login.dart';
import 'my_cardDetails.dart';

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
  DateTime selectedDate = new DateTime.now();

  Future<List<Map<String, dynamic>>> getUserDetails() async {
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/getUserDetails.php", body: {
      "name": uname,
    });
    var datausers = json.decode(response.body);
    for (var data in datausers) {
      Map<String, dynamic> myObject = {
        "id": data['id'],
        "username": data['username'],
        "email": data['email'],
        "gender": data['gender'],
        "bDay": data['bDay'].toString(),
      };
      print(uname);
      print(data['id']);
      print(data['username']);
      print(data['email']);
      print(data['gender']);
      print(data['bDay']);
    }
    setState(() {
      userIdController.text = datausers[0]['id'];
      userNameController.text = datausers[0]['username'];
      userEmailController.text = datausers[0]['email'];
      dropdownGender = datausers[0]['gender'];
      selectedDate = DateTime.parse(datausers[0]['bDay']);
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    getUserDetails();
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
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.local_shipping,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new SAddress(uname)));
              }),
          new IconButton(
              icon: Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new MycardDetails(uname)));
              })
        ],
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
                        return 'You must enter the user name *';
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
                        if (_isEnabled) {
                          setState(() {
                            dropdownGender = newValue;
                            print(dropdownGender);
                            //print(dropdownBrands);
                          });
                        }
                        return dropdownGender;
                      },
                      items: <String>[
                        'male',
                        'female',
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
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("BirthDay :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    SizedBox(width: 5.0),
                    Text("${selectedDate.toLocal()}".split(' ')[0]),
                    SizedBox(width: 100.0),
                    RaisedButton(
                      onPressed: () {
                        if (_isEnabled) {
                          _selectDate(context);
                        }
                      },
                      child: Text('Select date'),
                      color: Colors.lightGreen,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
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
                              SaveUserDattails();
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
                            if (_isEnabled == true) {
                              Fluttertoast.showToast(msg: 'Edit On');

                            } else {
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

  Future SaveUserDattails() async {
    final response = await http.post(
        "https://etrendsapp.000webhostapp.com/saveUserDetails.php",
        body: {
          "id": userIdController.text,
          "username": userNameController.text,
          "gender": dropdownGender,
          "bDay": selectedDate.toString(),

        });
     if(userNameController.text != uname) {
       Fluttertoast.showToast(msg: 'Details Saved');
       Navigator.push(context,
           MaterialPageRoute(builder: (context) => new Login()));
     }
     else{
       Fluttertoast.showToast(msg: 'Details Saved');
       Navigator.push(context,
           MaterialPageRoute(builder: (context) => new Profile(uname)));
     }


  }
}
