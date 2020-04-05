import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
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
import 'my_orders.dart';

class HomePage extends StatefulWidget {
  final uname;

  HomePage(this.uname);

  @override
  _HomePageState createState() => _HomePageState(uname);
}

class _HomePageState extends State<HomePage> {
  final uname;

  _HomePageState(this.uname) {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio(); // for http requests
  String _searchText = "";
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');

  get http => null;
  String dropdownCat;
  String dropdownBrands;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green,
        title: Text('ⓉⓇⒺⓃⒹⓈ'),
        actions: <Widget>[
          new IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new MyAccount(uname)));
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new My_orders(uname)));
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
          //padding widget
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: new Text('Recent products')),
          ),

          //grid view
          Flexible(child: Products(uname, dropdownCat, dropdownBrands)),
        ],
      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await dio.get('https://swapi.co/api/people');
    List tempList = new List();
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }

    setState(() {
      names = tempList;
      filteredNames = names;
    });
  }
}
