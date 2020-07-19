import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopapp_tut/pages/product_details.dart';

class Products extends StatefulWidget {
  final uname;
  final cat;
  final brand;

  Products(this.uname, this.cat, this.brand);

  @override
  _ProductsState createState() => _ProductsState(uname, cat, brand);
}

class _ProductsState extends State<Products> {
  final uname;
  final cat;
  final brand;

  _ProductsState(this.uname, this.cat, this.brand);

  List<Map<String, dynamic>> product_list = [];

  // ignore: missing_return
  Future<List<Map<String, dynamic>>> getItems() async {
    print(cat);
    print(brand);
    String tempCat = cat;
    String tempBrand = brand;
    if (cat == null) {
      tempCat = "";
    }
    if (brand == null) {
      tempBrand = "";
    }
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/getItems.php", body: {
      "cat": tempCat,
      "brand": tempBrand,
    });
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
        "colors": data['colors'],
      };
      product_list.add(myObject);
//      print(data['image']);
//      print(data['category']);
//      print(data['brand']);
//      print(data['old_price']);
//      print(data['description']);
//      print(data['type']);
//      print(data['sizes']);
//      print(data['colors']);
//      print(response.body);
//      print(brand);
    }
//    print(product_list[0]['name']);
//    print(product_list.length);
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
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Single_prod(
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
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
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

  Single_prod(
      {this.prod_name,
      this.prod_pricture,
      this.prod_old_price,
      this.prod_price,
      this.prod_category,
      this.prod_brand,
      this.prod_description,
      this.prod_type,
      this.prod_size,
      this.uname,
      this.prod_color});

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
