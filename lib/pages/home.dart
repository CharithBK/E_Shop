import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';

//my own imports
import 'package:shopapp_tut/componets/horizontal_listview.dart';
import 'package:shopapp_tut/componets/products.dart';
import 'package:shopapp_tut/pages/admin.dart';
import 'package:shopapp_tut/pages/cart.dart';
import 'package:shopapp_tut/pages/login.dart';
import 'package:sweetalert/sweetalert.dart';

import 'myAccount.dart';

class HomePage extends StatefulWidget {
  final uname;

  HomePage(this.uname);

  @override
  _HomePageState createState() => _HomePageState(uname);
}

class _HomePageState extends State<HomePage> {
  final uname;

  _HomePageState(this.uname);

  get http => null;
  String dropdownCat;
  String dropdownBrands;

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/w3.jpeg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/c1.jpg'),
          AssetImage('images/w4.jpeg'),
          AssetImage('images/m2.jpg'),
        ],
        autoplay: true,
//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green,
        title: Text('ⓉⓇⒺⓃⒹⓈ'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: 'Searching . . .');
                print(dropdownCat);
                print(dropdownBrands);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            new Products(uname, dropdownCat, dropdownBrands)));


              }),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Cart(uname)));
              })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName: Text(uname),
              accountEmail: Text('trends@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.lime,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.green),
            ),

//            body

            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: 'HomePage');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new HomePage(uname)));
              },
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(
                  Icons.home,
                  color: Colors.green,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new MyAccount(uname)));
                Fluttertoast.showToast(msg: 'My account');
              },
              child: ListTile(
                title: Text('My account'),
                leading: Icon(
                  Icons.person,
                  color: Colors.green,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: 'My Orderst');
              },
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.green,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: 'Categoris');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Cart(uname)));
              },
              child: ListTile(
                title: Text('Categoris'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: 'Favourites');
              },
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.green,
                ),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: 'Admin');

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Admin(uname)),
                );
              },
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ),

            InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: 'Logout');
                Timer(Duration(seconds: 2), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                });
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.backspace),
              ),
            ),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          //image carousel begins here
          // image_carousel,

          //padding widget
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child:
                Container(alignment: Alignment.centerLeft, child: new Text('')),
          ),
//          FlatButton(
//            color: Colors.red,
//            textColor: Colors.white,
//            child: Text('add product'),
//            onPressed: () {
//              print(uname);
//            },
//          ),
          //Horizontal list view begins here
          HorizontalList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButton<String>(
                      value: dropdownCat,
                      hint: Text("Category"),
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
                          dropdownCat = newValue;
                          Products(uname,dropdownCat,dropdownBrands);
                        });
                        return dropdownCat;
                      },
                      items: <String>[
                        'T-shirt',
                        'Suits',
                        'Shoes',
                        'Sweaters',
                        'Jackets&costa',
                        'Trousers',
                        'Slippers',
                        'Shirt',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 9.0),
                  Expanded(
                    child: DropdownButton<String>(
                      value: dropdownBrands,
                      hint: Text("Brand"),
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
                          dropdownBrands = newValue;
                          Products(uname,dropdownCat,dropdownBrands);
                          //print(dropdownBrands);
                        });
                        return dropdownBrands;
                      },
                      items: <String>[
                        'Nike',
                        'Addidas',
                        'Burberry',
                        'Fendi',
                        'Louis Vuitton',
                        'Prada',
                        'Chanel',
                        'Hermes',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //padding widget
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: new Text('Recent products')),
          ),

          //grid view
          Flexible(child: Products(uname,dropdownCat,dropdownBrands)),
        ],
      ),
    );
  }
}
