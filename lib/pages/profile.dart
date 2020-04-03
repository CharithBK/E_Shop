import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  child: new Text("U S E R      P R O F I L E" ,),
                ),

                SizedBox(height: 45.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("User ID :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("01"),
                    )
                  ],
                ),

                SizedBox(height: 45.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("Contact Name :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("Test Perera"),
                    )
                  ],
                ),
                SizedBox(height: 45.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("Email  :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("test123@gmail.com"),
                    )
                  ],
                ),

                SizedBox(height: 45.0),
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
                SizedBox(height: 45.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("B'Day :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("1995/10/10"),
                    )
                  ],
                ),
                SizedBox(height: 35.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new MaterialButton(
                        onPressed: () {
                          print("Save");
                          Fluttertoast.showToast(msg: 'Details Saved');
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
                          Fluttertoast.showToast(msg: 'You can edit details');
                          print("Edit");
                        },
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
