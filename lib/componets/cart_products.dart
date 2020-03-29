import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  List<Map<String, dynamic>> Products_on_the_cart = [];

  // ignore: missing_return
  Future<List<Map<String, dynamic>>> getItems() async {
    final response =
        await http.post("https://etrendsapp.000webhostapp.com/getItems.php");
    //print(response.statusCode);
    var datausers = json.decode(response.body);
    var pl;
    for (var data in datausers) {
      Map<String, dynamic> myObject = {
        "name": data['name'],
        "picture": data['image'],
        "old_price": data['old_price'],
        "price": data['price'],
        "category": data['category'],
        "brand": data['brand'],
        "details": data['description'],
        "condition": data['type'],
        "size": data['sizes'],
        "qty": data['qty'],
      };
      Products_on_the_cart.add(myObject);
      print(data['image']);
      print(data['category']);
      print(data['brand']);
      print(data['old_price']);
      print(data['description']);
      print(data['type']);
      print(data['sizes']);
      print(data['qty']);
    }
    print(Products_on_the_cart[0]['name']);
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
    getItems();
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
            prod_old_price: Products_on_the_cart[index]['old_price'],
            prod_price: Products_on_the_cart[index]['price'],
            prod_category: Products_on_the_cart[index]['category'],
            prod_brand: Products_on_the_cart[index]['brand'],
            prod_description: Products_on_the_cart[index]['details'],
            prod_type: Products_on_the_cart[index]['condition'],
            prod_size: Products_on_the_cart[index]['size'],
            prod_qty: Products_on_the_cart[index]['qty'],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_old_price;
  final prod_price;
  final prod_category;
  final prod_brand;
  final prod_description;
  final prod_type;
  final prod_size;
  final prod_qty;

  Single_cart_product(
      {this.prod_name,
      this.prod_pricture,
      this.prod_old_price,
      this.prod_price,
      this.prod_category,
      this.prod_brand,
      this.prod_description,
      this.prod_type,
      this.prod_size,
      this.prod_qty});

  @override
  Widget build(BuildContext context) {
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
        subtitle: new Column(
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
                    "red",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),

            // product price
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                "\$${prod_price}",
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
          ],
        ),
        trailing: new Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: new IconButton(
                    icon: Icon(Icons.arrow_drop_up), onPressed: () {}),
              ),
            ),
            Expanded(
              child: new Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text("$prod_qty")),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: new IconButton(
                  icon: Icon(Icons.arrow_drop_down), onPressed: () {}),
            )),
          ],
        ),
      ),
    );
  }
}
