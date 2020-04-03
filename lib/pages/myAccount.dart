import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp_tut/pages/profile.dart';
import 'package:shopapp_tut/pages/shipping_address.dart';

import 'home.dart';
import 'my_cardDetails.dart';

class MyAccount extends StatefulWidget {
  final uname;

  MyAccount(this.uname);

  @override
  _MyAccountState createState() => _MyAccountState(uname);
}

class _MyAccountState extends State<MyAccount> {
  final uname;

  _MyAccountState(this.uname);

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
      body: new ListView(
       children: <Widget>[
          InkWell(
           onTap: () {
             Fluttertoast.showToast(msg: 'Profile');
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => new Profile(uname)));
           },
           child: ListTile(
             title: Text('Profile'),
             leading: Icon(
               Icons.people,
               color: Colors.green,
             ),
           ),
         ),

         InkWell(
           onTap: () {
             Fluttertoast.showToast(msg: 'Address');
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => new SAddress(uname)));
           },
           child: ListTile(
             title: Text('Shipping Address'),
             leading: Icon(
               Icons.local_shipping,
               color: Colors.green,
             ),
           ),
         ),

         InkWell(
           onTap: () {
             Fluttertoast.showToast(msg: 'cards');
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => new MycardDetails(uname)));
           },
           child: ListTile(
             title: Text('My Credit/Debit Cards'),
             leading: Icon(
               Icons.attach_money,
               color: Colors.green,
             ),
           ),
         ),
       ],
      ),
    );
  }
}
