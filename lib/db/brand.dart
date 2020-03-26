import 'package:flutter_typeahead/flutter_typeahead.dart';
class BrandService {
   String brand ='Nike';
   void createBrand( String name) {
     print(name);

   }

  getSuggestions(String pattern) {}

  Future<List> getBrands() {
     print(brand);
  }
}