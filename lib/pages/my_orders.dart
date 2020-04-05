import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp_tut/componets/cart_products.dart';

import 'home.dart';
import 'my_order_list.dart';


class My_orders extends StatefulWidget {
  final uname;

  My_orders(this.uname);
  @override
  _My_ordersState createState() => _My_ordersState(uname);
}

class _My_ordersState extends State<My_orders> {
  final uname;

  _My_ordersState(this.uname);

//  Timer timer;
//  int counter = 0;
//
//  void addValue() {
//    setState(() {
//      counter++;
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => addValue());
//  }
//
//  @override
//  void dispose() {
//    timer?.cancel();
//    super.dispose();
//  }
   @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green,
        title: Text('My Orders'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: 'Home Page');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new HomePage(uname)));
              })
        ],
      ),
      body:  new MyOrderList(uname),

    );
  }
}
