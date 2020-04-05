import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class MyOrderList extends StatefulWidget {
  final uname;

  MyOrderList(this.uname);
  @override
  _MyOrderListState createState() => _MyOrderListState(uname);
}

class _MyOrderListState extends State<MyOrderList> {
  final uname;

  _MyOrderListState(this.uname);

  GlobalKey<RefreshIndicatorState> refreshKey;

  List<Map<String, dynamic>> Products_on_the_cart = [];

  // ignore: missing_return
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/getOrders.php", body: {
      "name": uname,
    });
    // print(response.body);
    //print(response.statusCode);
    var datausers = json.decode(response.body);
    // ignore: unused_local_variable
    //var pl;
    for (var data in datausers) {
      Map<String, dynamic> myObject = {
        "name": data['itemname'],
        "picture": data['image'],
        "price": data['price'],
        "size": data['size'],
        "qty": data['qty'],
        "color": data['colors'],
        "tot": data['tot'],
      };
      Products_on_the_cart.add(myObject);
      print(data['itemname']);
      print(data['image']);
      print(data['price']);
      print(data['size']);
      print(data['qty']);
      print(data['colors']);
      print(data['total']);
    }
    print(Products_on_the_cart.length);
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
    refreshKey =GlobalKey<RefreshIndicatorState>();
    getCartItems();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            prod_name: Products_on_the_cart[index]['name'],
            prod_pricture: Products_on_the_cart[index]['picture'],
            prod_price: Products_on_the_cart[index]['price'],
            prod_size: Products_on_the_cart[index]['size'],
            prod_qty: Products_on_the_cart[index]['qty'],
            prod_color: Products_on_the_cart[index]['color'],
            prod_tot: Products_on_the_cart[index]['tot'],
            uname: uname,
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_price;
  final prod_size;
  var prod_qty;
  final prod_color;
  final prod_tot;
  final uname;

  Single_cart_product({
    this.prod_name,
    this.prod_pricture,
    this.prod_price,
    this.prod_color,
    this.prod_tot,
    this.prod_size,
    this.prod_qty,
    this.uname,
  });

  @override
  Widget build(BuildContext context) {
    var qtyUp = int.tryParse(prod_qty);
    final Size screenSize = MediaQuery.of(context).size;
    return Card(
      child: ListTile(
        //LEADING SECTIONS
        leading: new Image.network(
          prod_pricture,
          width: 60.0,
          height: 60.0,
        ),
//TITLE SECTION
        title: new Text(prod_name),
        // SUBTITLE SECTION
        subtitle: Container(
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  //  size of products
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("Size:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      prod_size,
                      style: TextStyle(color: Colors.green),
                    ),
                  ),

                  // Product Color
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                    child: new Text("Color"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1.0),
                    child: new Text(
                      prod_color,
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),

              // product price
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "\$${prod_price}",
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "   Total:",
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "\$${prod_tot}",
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
}
