import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class MycardDetails extends StatefulWidget {
  final uname;

  MycardDetails(this.uname);

  @override
  _MycardDetailsState createState() => _MycardDetailsState(uname);
}

class _MycardDetailsState extends State<MycardDetails> {
  final uname;

  _MycardDetailsState(this.uname);

  bool _isEnabled = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userCardNumberController = TextEditingController();
  TextEditingController userCardDateController = TextEditingController();
  TextEditingController userSecurityCodeController = TextEditingController();

  // ignore: missing_return
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
      userNameController.text = datausers[0]['name'];
      userCardNumberController.text = datausers[0]['card_number'];
      userCardDateController.text = datausers[0]['card_date'];
      userSecurityCodeController.text = datausers[0]['security_code'];
    });
  }

  @override
  void initState() {
    getCardDetails();
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
                    "C A R D     D E T A I L S",
                  ),
                ),
                SizedBox(height: 45.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    controller: userNameController,
                    decoration: InputDecoration(
                        labelText: 'Card Holder Name ', hintText: 'name'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Card Holder Name Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    keyboardType: TextInputType.number,
                    controller: userCardNumberController,
                    decoration: InputDecoration(
                        labelText: 'Card Number ', hintText: 'card number'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'User  Card Number Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    controller: userCardDateController,
                    decoration: InputDecoration(
                        labelText: 'Card Date ', hintText: 'card date'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'User  Card Date Empty *';
                      }
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnabled,
                    keyboardType: TextInputType.number,
                    controller: userSecurityCodeController,
                    decoration: InputDecoration(
                        labelText: 'Security Code ', hintText: 'security code'),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'User  Security Code Empty *';
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
                            print("Save");
                            SaveCardDetails();
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

  Future SaveCardDetails() async {
    final response = await http.post(
        "https://etrendsapp.000webhostapp.com/saveCardDetails.php",
        body: {
          "uname": uname,
          "name": userNameController.text,
          "card_number": userCardNumberController.text.toString(),
          "card_date": userCardDateController.text,
          "security_code": userSecurityCodeController.text.toString(),
        });
    Fluttertoast.showToast(msg: 'Details Saved');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => new MycardDetails(uname)));
  }
}
