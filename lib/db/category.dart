import 'package:flutter_typeahead/flutter_typeahead.dart';
class CategoryService {
  String category ='T-Shirt';
   void createCategory(String name) {
     print(name);
   }

  getSuggestions(String pattern) {}
   Future<List> getBrands() {
     print(category);
   }
}
