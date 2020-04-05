import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp_tut/componets/cart_products.dart';

import 'my_orders.dart';

class Cart extends StatefulWidget {
  final uname;

  Cart(this.uname);

  @override
  _CartState createState() => _CartState(uname);
}

class _CartState extends State<Cart> {
  final uname;

  _CartState(this.uname);
  String SubTotal;
  List<Map<String, dynamic>> Products_on_the_cart = [];

  // ignore: missing_return
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/getSubTotal.php", body: {
      "name": uname,
    });
    // print(response.body);
    //print(response.statusCode);
    var datausers = json.decode(response.body);
    print(uname);
    print("==============");
    SubTotal = datausers['total'];
    print(SubTotal);

    print(Products_on_the_cart.length);
  }

  Future<List<Map<String, dynamic>>> UploadItems() async {
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/uploaditems.php", body: {
      "name": uname,

    });


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Cart(uname)),
    );

  }




  Timer timer;
  int counter = 0;

  void addValue() {
    setState(() {
      counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    getCartItems();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => addValue());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green,
        title: Text('Cart'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: 'My Orders');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new My_orders(uname)));
              })
        ],
      ),
      body: new Cart_products(uname),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: new Text("Total:"),
              subtitle: new Text("\$$SubTotal"),
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new MaterialButton(
                  onPressed: () {
                    UploadItems();
                    Fluttertoast.showToast(msg: 'Purchase Successful');
                    print(SubTotal);
                  },
                  child: new Text(
                    "Buy Now",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
