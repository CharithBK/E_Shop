import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp_tut/pages/profile.dart';

import 'home.dart';
import 'my_cardDetails.dart';

class SAddress extends StatefulWidget {
  final uname;

  SAddress(this.uname);

  @override
  _SAddressState createState() => _SAddressState(uname);
}

class _SAddressState extends State<SAddress> {
  final uname;
  String dropdownCurrency;
  String dropdownCountry;
  bool _isEnabled = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userNumberController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  TextEditingController userProvinceController = TextEditingController();
  TextEditingController userCityController = TextEditingController();
  TextEditingController userPostController = TextEditingController();

  _SAddressState(this.uname);

  Future<List<Map<String, dynamic>>> getUserShippingDetails() async {
    final response = await http.post(
        "https://etrendsapp.000webhostapp.com/getShippingDetails.php",
        body: {
          "name": uname,
        });
    var datausers = json.decode(response.body);

    setState(() {
      userNameController.text = datausers[0]['name'];
      userNumberController.text = datausers[0]['tp'];
      userAddressController.text = datausers[0]['address'];
      userProvinceController.text = datausers[0]['province'];
      userCityController.text = datausers[0]['city'];
      userPostController.text = datausers[0]['post_code'];

      print(datausers[0]['country']);
      print(datausers[0]['currency']);
    });
    if (datausers[0]['country'] == "") {
      dropdownCountry = null;
    } else {
      dropdownCountry = datausers[0]['country'];
    }
    if (datausers[0]['currency'] == "") {
      dropdownCurrency = null;
    } else {
      dropdownCurrency = datausers[0]['currency'];
    }
  }

  @override
  void initState() {
    getUserShippingDetails();
  }

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
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Profile(uname)));
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
                  child: new Text("S H I P P I N G    D E T A I L S"),
                ),
                SizedBox(height: 45.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: userNameController,
                    enabled: _isEnabled,
                    decoration: InputDecoration(
                        labelText: 'First Name ', hintText: 'name'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the first name *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: userNumberController,
                    enabled: _isEnabled,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Contact Number ', hintText: 'mobile'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the contact number *';
                      } else if (value.length > 10) {
                        return 'Contact number cant have more than 10 numbers *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: userAddressController,
                    enabled: _isEnabled,
                    decoration: InputDecoration(
                        labelText: 'Home Address ', hintText: 'address'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the home addres *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: userProvinceController,
                    enabled: _isEnabled,
                    decoration: InputDecoration(
                        labelText: 'Province ', hintText: 'province'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the province *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: userCityController,
                    enabled: _isEnabled,
                    decoration:
                        InputDecoration(labelText: 'City ', hintText: 'city'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the city *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: userPostController,
                    enabled: _isEnabled,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Postal Code ', hintText: 'post code'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the postal code *';
                      } else if (value.length > 5) {
                        return 'Postal code cant have more than 5 numbers *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
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
                            if (_isEnabled) {
                              setState(() {
                                dropdownCountry = newValue;
                                print(dropdownCountry);
                                //print(dropdownBrands);
                              });
                            }

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
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                          child: new Text("Currency               :",
                              style: TextStyle(color: Colors.grey)),
                        ),
                        DropdownButton<String>(
                          value: dropdownCurrency,
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
                            if (_isEnabled) {
                              setState(() {
                                dropdownCurrency = newValue;
                                print(dropdownCurrency);
                                //print(dropdownBrands);
                              });
                            }

                            return dropdownCurrency;
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
                          if (_formKey.currentState.validate()) {
                            if (dropdownCountry != null) {
                              if (dropdownCurrency != null) {
                                print("Save");
                                SaveShippingDetails();
                                Fluttertoast.showToast(msg: 'Details Saved');
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Select a currency');
                              }
                            } else {
                              Fluttertoast.showToast(msg: 'Select a country ');
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

  Future SaveShippingDetails() async {
    final response = await http.post(
        "https://etrendsapp.000webhostapp.com/saveShippingDetails.php",
        body: {
          "uname": uname,
          "fname": userNameController.text,
          "tp": userNumberController.text,
          "address": userAddressController.text,
          "province": userProvinceController.text,
          "city": userCityController.text,
          "postcode": userPostController.text,
          "country": dropdownCountry,
          "currency": dropdownCurrency,
        });

    Fluttertoast.showToast(msg: 'Details Saved');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => new SAddress(uname)));
  }
}
