import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class ProductService {
// ignore: missing_return

//   void _showSnakBarMsg(String msg) {
//     _scaffoldstate.currentState
//         .showSnackBar(new SnackBar(content: new Text(msg)));
//   }

  Future<List> uploadProduct(
      String name,
      String category,
      String brand,
      String qty,
      String description,
      String condition,
      String oldprice,
      String price,
      String sizes,
      var img) async {
    String fileName = basename(img.path);
    print(fileName);
    print("File base name: $fileName");

    try {
      FormData formData =
          new FormData.from({"file": new UploadFileInfo(img, fileName)});

      Response response = await Dio().post(
          "https://etrendsapp.000webhostapp.com/saveImg.php",
          data: formData);
      print("File upload response: $response");

      // Show the incoming message in snakbar
      // _showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }

    print(name);
    print(category);
    print(brand);
    print(qty);
    print(description);
    print(condition);
    print(oldprice);
    print(sizes);
    print(price);

    final response = await http
        .post("https://etrendsapp.000webhostapp.com/add_product.php", body: {
      "name": name,
      "category": category,
      "brand": brand,
      "qty": qty,
      "description": description,
      "condition": condition,
      "old_price": oldprice,
      "price": price,
      "sizes": sizes,
      "image": fileName,
    });
    print(response.body);
  }
}
