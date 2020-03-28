import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

 class ProductService {
// ignore: missing_return
   Future<List> uploadProduct() async {
     print("gg");
     final response = await http
         .post("https://etrendsapp.000webhostapp.com/submit_data.php", body: {
     });
   }
 }