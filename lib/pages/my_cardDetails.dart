import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                  child: new Text("C A R D     D E T A I L S" ,),
                ),

                SizedBox(height: 45.0),
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
                      child: new Text("Card Number :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("6545 8765 4454 9009"),
                    )
                  ],
                ),

                SizedBox(height: 30.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("Card Date :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("08/22"),
                    )
                  ],
                ),
                SizedBox(height: 30.0),
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                      child: new Text("Security Code :",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Text("169"),
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
