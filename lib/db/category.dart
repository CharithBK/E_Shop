import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class CategoryService {
  String category ='T-Shirt';
   Future createCategory(String name) async {
     print("gg");
     final response = await http
         .post("https://etrendsapp.000webhostapp.com/add_category.php", body: {
          "name": name,

     });
     print(name);
   }

  getSuggestions(String pattern) {}
   Future<List> getBrands() {
     print(category);
   }
}
