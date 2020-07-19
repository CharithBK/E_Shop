import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopapp_tut/main.dart';

import 'cart.dart';
import 'home.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;
  final product_detail_category;
  final product_detail_brand;
  final product_detail_description;
  final product_detail_type;
  final product_detail_size;
  final product_detail_colors;
  final uname;

//  example
//      .split(' ')                       // split the text into an array
//      .map((String text) => Text(text)) // put the text inside a widget
//      .toList()
  ProductDetails(
      {this.product_detail_name,
      this.product_detail_new_price,
      this.product_detail_old_price,
      this.product_detail_picture,
      this.product_detail_category,
      this.product_detail_brand,
      this.product_detail_description,
      this.product_detail_type,
      this.product_detail_size,
      this.uname, this.product_detail_colors});

  @override
  _ProductDetailsState createState() => _ProductDetailsState(uname,product_detail_size,product_detail_colors);
}

class _ProductDetailsState extends State<ProductDetails> {
  final uname;
  final product_detail_size;
  final product_detail_colors;
  _ProductDetailsState(this.uname ,this.product_detail_size,this.product_detail_colors);

  String dropdownSize;
  String dropdownColors;
  String dropdownQty;


  double subTot = 0.00;
   List data = List();
  List data1 = List();
   void dbSizeCall(String product_detail_size) {
     setState(() {
       for (var dt in product_detail_size.split(",")) {
         data.add(dt.toString());
         print(dt);
       }
       print(data);
       print("++++++++++++++++++++++++");
     });
   }

  void dbColorCall(String product_detail_colors) {
    setState(() {
      for (var dt in product_detail_colors.split(",")) {
        data1.add(dt.toString());
        print(dt);
      }
      print(data1);
      print("++++++++++++++++++++++++");
    });
  }
  @override
  void initState() {
    super.initState();
    this.dbSizeCall(product_detail_size);
    this.dbColorCall(product_detail_colors);
//    print(product_detail_size);
//    print("gg");

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
        actions: <Widget>[

          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Cart(uname)));
                }
              })
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.product_detail_picture),
              ),
              footer: new Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: new Text(
                      widget.product_detail_name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    title: new Row(children: <Widget>[
                      Expanded(
                          child: new Text(
                        "\$${widget.product_detail_old_price}",
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      )),
                      Expanded(
                          child: new Text(
                              "\$${widget.product_detail_new_price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))),
                      Expanded(
                          child: new Text("Total:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45))),
                      Expanded(
                        child: new Text("\$$subTot",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      )
                    ]),
                  )),
            ),
          ),

          //btn1==========R
          Row(
            children: <Widget>[
              //btnSize=============================
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(

                      hint: Text("Size"),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 16,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 4,
                        color: Colors.lightGreen,
                      ),
                      onChanged: (newVal) {
                        setState(() {
                          dropdownSize = newVal;
                        });
                      },
                      items: data.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item),
                          value: item.toString(),
                        );
                      }).toList(),
                    value: dropdownSize,
                  ),

                ),
              ),


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(

                    hint: Text("Color"),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 16,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 4,
                      color: Colors.lightGreen,
                    ),
                    onChanged: (newVal) {
                      setState(() {
                        dropdownColors = newVal;
                      });
                    },
                    items: data1.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item),
                        value: item.toString(),
                      );
                    }).toList(),
                    value: dropdownColors,
                  ),

                ),
              ),

              //btnQty=============================

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: dropdownQty,
                    hint: Text("Quantity"),
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
                        dropdownQty = newValue;
                        print(widget.product_detail_new_price);
                        print(dropdownQty);

                        var nprice =
                            double.tryParse(widget.product_detail_new_price);
                        var qty = double.tryParse(dropdownQty);
                        subTot = (nprice * qty);
                        print(subTot);
                      });
                    },
                    items: <String>[
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),

//btn2======================
          Row(
            children: <Widget>[
              //btn=============================

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () {
//                      print("Order Done");
//                      print(uname);
//                      print(dropdownSize);
//                      print(dropdownColors);
//                      print(dropdownQty);
//                      print(widget.product_detail_name);
//                      print(subTot);
                      buyNow();

                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text("Buy now"),
                  ),
                ),
              ),

              new IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    addtoCart();
                  }),
              new IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
            ],
          ),
          Divider(),
          new ListTile(
            title: new Text("Product Details"),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
              child: new Text(widget.product_detail_description),
            ),
          ),

          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product name",
                    style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_name),
              )
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product brand",
                    style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_brand),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product category",
                    style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_category),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product condition",
                    style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_type),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("Similar Products "),
          ),
          Container(
            height: 360.0,
            child: Similar_Products(uname),
          ),
        ],
      ),
    );
  }

//  DropdownMenuItem<String> getDropDownWidget(Map<String, dynamic> map) {
//    print(widget.product_detail_size.split(","));
//    return DropdownMenuItem<String>(
//      value: map['size'],
//      child: Text(map['size']),
//    );
//  }


  Future buyNow() async {
    if (dropdownSize != null) {
      if (dropdownColors != null) {
        if (dropdownQty != null) {
          print(uname);
          print(dropdownSize);
          print(dropdownColors);
          print(dropdownQty);
          print(widget.product_detail_name);
          print(subTot);
          final response = await http
              .post("https://etrendsapp.000webhostapp.com/add_cart.php", body: {
            "name": uname,
            "itemname": widget.product_detail_name,
            "size": dropdownSize,
            "qty": dropdownQty,
            "colors": dropdownColors,
            "tot": subTot.toString(),
          });
          Fluttertoast.showToast(msg: 'Deady to buy');

          print(response.body);
        } else {
          Fluttertoast.showToast(msg: 'Select a quantity');
        }
      } else {
        Fluttertoast.showToast(msg: 'Select a color');
      }
    } else {
      Fluttertoast.showToast(msg: 'Select a size');
    }
  }




  Future addtoCart() async {
    if (dropdownSize != null) {
      if (dropdownColors != null) {
        if (dropdownQty != null) {
          print(uname);
          print(dropdownSize);
          print(dropdownColors);
          print(dropdownQty);
          print(widget.product_detail_name);
          print(subTot);
          final response = await http
              .post("https://etrendsapp.000webhostapp.com/add_cart.php", body: {
            "name": uname,
            "itemname": widget.product_detail_name,
            "size": dropdownSize,
            "qty": dropdownQty,
            "colors": dropdownColors,
            "tot": subTot.toString(),
          });
          Fluttertoast.showToast(msg: 'Added To Cart!');

          print(response.body);
        } else {
          Fluttertoast.showToast(msg: 'Select a quantity');
        }
      } else {
        Fluttertoast.showToast(msg: 'Select a color');
      }
    } else {
      Fluttertoast.showToast(msg: 'Select a size');
    }
  }
}

class Similar_Products extends StatefulWidget {
  final uname;

  Similar_Products(this.uname);

  @override
  _Similar_ProductsState createState() => _Similar_ProductsState(uname);
}

class _Similar_ProductsState extends State<Similar_Products> {
  final uname;
  List data = List();
  _Similar_ProductsState(this.uname);

  List<Map<String, dynamic>> product_list = [];

  // ignore: missing_return
  Future<List<Map<String, dynamic>>> getItems() async {
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/getSimilarItems.php");
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
        "sizes": data['sizes'],
        "colors": data['colors']
      };
      product_list.add(myObject);
    }
//
//
//    setState(() {
//      // data = datausers;
//      for (var dt in datausers[3]['sizes'].split(",")) {
//        data.add(dt.toString());
//       // print(dt);
//      }
//     // print(data);
//    });
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
    this.getItems();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_Single_prod(
            prod_name: product_list[index]['name'],
            prod_pricture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
            prod_category: product_list[index]['category'],
            prod_brand: product_list[index]['brand'],
            prod_description: product_list[index]['details'],
            prod_type: product_list[index]['condition'],
            prod_size: product_list[index]['sizes'],
            prod_color: product_list[index]['colors'],
            uname: uname,
          );
        });
  }
}

class Similar_Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_old_price;
  final prod_price;
  final prod_category;
  final prod_brand;
  final prod_description;
  final prod_type;
  final prod_size;
  final prod_color;
  final uname;

  Similar_Single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_old_price,
    this.prod_price,
    this.prod_category,
    this.prod_brand,
    this.prod_description,
    this.prod_type,
    this.prod_size,
    this.prod_color,
    this.uname,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: new Text("Hero 1"),
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                        product_detail_name: prod_name,
                        product_detail_new_price: prod_price,
                        product_detail_old_price: prod_old_price,
                        product_detail_picture: prod_pricture,
                        product_detail_category: prod_category,
                        product_detail_brand: prod_brand,
                        product_detail_description: prod_description,
                        product_detail_type: prod_type,
                        product_detail_size: prod_size,
                        product_detail_colors: prod_color,
                        uname: uname,
                      ))),
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            prod_name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ),
                        new Text(
                          "\$${prod_price}",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  child: Image.network(
                    prod_pricture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
