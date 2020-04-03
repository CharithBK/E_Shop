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

  _ProfileState(this.uname);
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
    );
  }
}
