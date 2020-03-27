import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shopapp_tut/db/brand.dart';
import 'package:shopapp_tut/db/category.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  String _currentCategory;
  String _currentBrand;

  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  @override
  void initState() {
    _getCategories();
    _getBrands();
    categoriesDropDown = getCategoriesDropdown();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
//    for(int i = 0; i < categories.length; i++){
//      setState(() {
//        categoriesDropDown.insert(0, DropdownMenuItem(child: Text(categories[i]['category']),
//            value: categories[i]['category']));
//      });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(
                            color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                          child: new Icon(
                            Icons.add,
                            color: grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(
                            color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                          child: new Icon(
                            Icons.add,
                            color: grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(
                            color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                          child: new Icon(
                            Icons.add,
                            color: grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'enter a product name with 10 characters at maximum',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: red, fontSize: 12),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(hintText: 'Product name'),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the product name';
                    } else if (value.length > 10) {
                      return 'Product name cant have more than 10 letters';
                    }
                  },
                ),
              ),

//              select category

              Visibility(
                visible: _currentCategory != null || _currentCategory == '',
                child: Text(_currentCategory ?? "null",
                    style: TextStyle(color: red)),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      controller: categoryController,
                      decoration: InputDecoration(hintText: 'add category')),
                  suggestionsCallback: (pattern) async {
                    print(pattern);
                    print("gggg");

                    return await _categoryService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.library_add),
                      title: Text(suggestion['name']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      print("gg");
                      _currentCategory = suggestion['name'];
                      categoryController.text = _currentCategory;
                    });
                  },
                ),
              ),

//            select brand

              Visibility(
                visible: _currentBrand != null || _currentBrand == '',
                child:
                    Text(_currentBrand ?? "null", style: TextStyle(color: red)),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      controller: brandController,
                      decoration: InputDecoration(hintText: 'add brand')),
                  suggestionsCallback: (pattern) async {
                    return await _brandService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.library_add),
                      title: Text(suggestion['name']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _currentBrand = suggestion['name'];
                      brandController.text = _currentBrand;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Quantity'),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter the Quantity";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: 'Product Description'),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter Product Description";
                    }
                  },
                ),
              ),
              Text('---Avilable Szies---'),

              Row(
                children: <Widget>[
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('xS'),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('S  '),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('M '),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('L  '),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('XL'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('24'),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('26'),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('28'),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('30'),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('32'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('34'),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('36'),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('38'),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('40'),
                  Checkbox(
                    value: false,
                    onChanged: null,
                  ),
                  Text('42'),
                ],
              ),
              FlatButton(
                color: red,
                textColor: white,
                child: Text('add product'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  _getCategories() async {
//    List<DocumentSnapshot> data = await _categoryService.getCategories();
//    print(data.length);
//    setState(() {
//      categories = data;
//      print(categories.length);
//    });
  }

  _getBrands() async {
//    List<DocumentSnapshot> data = await _categoryService.getCategories();
//    print(data.length);
//    setState(() {
//      categories = data;
//      print(categories.length);
//    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedCategory) {
    setState(() => _currentBrand = selectedCategory);
  }
}
