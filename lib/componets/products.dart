import 'package:flutter/material.dart';
import 'package:shopapp_tut/pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Blazer",
      //"picture": "images/products/blazer2.jpg",
      "picture": "https://etrendsapp.000webhostapp.com/images/products/blazer3.jpg",
      "old_price": 120,
      "price": 85,
    },
//    {
//      "name": "Red Dress",
//      "picture": "images/products/blazer2.jpg",
//      "old_price": 100,
//      "price": 50,
//    },
//    {
//      "name": "Blazer",
//      "picture": "images/products/dress1.jpg",
//      "old_price": 120,
//      "price": 85,
//    },
//    {
//      "name": "Red ress",
//      "picture": "images/products/blazer3.jpg",
//      "old_price": 100,
//      "price": 50,
//    }
//    ,
//    {
//      "name": "Blazer",
//      "picture": "images/products/dress2.jpg",
//      "old_price": 120,
//      "price": 85,
//    },
//    {
//      "name": "Red ress",
//      "picture": "images/products/shoe2.jpg",
//      "old_price": 100,
//      "price": 50,
//    }
  ];

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

  Single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_old_price,
    this.prod_price,
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
                      ))),
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: new Row(children: <Widget>[
                      Expanded(
                        child: Text(prod_name ,style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 16.0),),
                      ),
                      new Text("\$${prod_price}" ,style: TextStyle(color: Colors.red , fontWeight: FontWeight.bold),)
                    ],),
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
