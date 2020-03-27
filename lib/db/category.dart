import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CategoryService {
  // String category = 'T-Shirt';

  Future createCategory(String name) async {
    print("gg");
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/add_category.php", body: {
      "name": name,
    });
    print(name);
  }

  getSuggestions(String suggestion) async {
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/getCategory.php", body: {
      "name": suggestion,
    });
    List<dynamic> datausers = json.decode(response.body);
    //print(suggestion);
    print(datausers);
    //List<dynamic> car ;
    //car = datausers;
    print(suggestion);
    return datausers;
  }

  Future<List> getBrands() {
    //print(category);
  }


}
