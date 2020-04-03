import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';
class SAddress extends StatefulWidget {
  final uname;

  SAddress(this.uname);
  @override
  _SAddressState createState() => _SAddressState(uname);
}

class _SAddressState extends State<SAddress> {

  final uname;
  String dropdownCat;
  String dropdownCountry;
  _SAddressState(this.uname);
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
                  child: new Text("S H I P P I N G    D E T A I L S" ,),
                ),

                SizedBox(height: 35.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("User Name :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text(uname),
                    )
                  ],
                ),

                SizedBox(height: 30.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("Contact Number :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("011-2234755"),
                    )
                  ],
                ),
                SizedBox(height: 30.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("Home Address  :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("24/41 Gunapala Mawatha, Kaduwela."),
                    )
                  ],
                ),

                SizedBox(height: 30.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("Province :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("Colombo"),
                    )
                  ],
                ),
                SizedBox(height: 30.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("City :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("Kaduwela"),
                    )
                  ],
                ),
                SizedBox(height: 30.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("City :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("Kaduwela"),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                          child: new Text("Ship to / Country :",
                              style: TextStyle(color: Colors.grey)),
                        ),
                        DropdownButton<String>(
                          value: dropdownCountry,
                          hint: Text("Select Country"),
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
                              dropdownCountry = newValue;
                              print(dropdownCountry);
                              //print(dropdownBrands);
                            });
                            return dropdownCountry;
                          },
                          items: <String>[
                            'Sri Lanka',
                            'Australia',
                            'India',
                            'USA',
                            'United Kingdom',
                            'South Africa',
                            'China',
                            'japan',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                          child: new Text("Currency               :",
                              style: TextStyle(color: Colors.grey)),
                        ),
                        DropdownButton<String>(
                          value: dropdownCat,
                          hint: Text("Select Currency"),
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
                              dropdownCat = newValue;
                              print(dropdownCat);
                              //print(dropdownBrands);
                            });
                            return dropdownCat;
                          },
                          items: <String>[
                            'USD',
                            'AUD',
                            'LKR',
                            'INR',
                            'GBP',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),


                SizedBox(height: 30.0),
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
