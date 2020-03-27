import 'dart:convert';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class BrandService {
  //String brand = 'Nike';

  Future createBrand(String name) async {
    //
    print("gg");
    final response = await http
        .post("https://etrendsapp.000webhostapp.com/add_brand.php", body: {
      "name": name,
    });
    print(name);
  }

  getSuggestions(String suggestion) async {
        final response = await http
        .post("https://etrendsapp.000webhostapp.com/getBrand.php", body: {
      "name": suggestion,
    });
    List<dynamic> datausers = json.decode(response.body);
     return datausers;
  }

  Future<List> getBrands() {
    //print(brand);
  }
}
