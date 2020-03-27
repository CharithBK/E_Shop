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

  List<DropdownMenuItem<String>> categoriesDropDown =<DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  String _currentCategory;
  String _currentBrand;

  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  List<String> selectedSizes = <String>[];

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
                    value: selectedSizes.contains('XS'),
                    onChanged: (value) => changeSelectedSize('XS')),
                  Text('XS'),
                  Checkbox(
                      value: selectedSizes.contains('S'),
                      onChanged: (value) => changeSelectedSize('S')),
                  Text('S  '),
                  Checkbox(
                      value: selectedSizes.contains('M'),
                      onChanged: (value) => changeSelectedSize('M')),
                  Text('M '),
                  Checkbox(
                      value: selectedSizes.contains('L'),
                      onChanged: (value) => changeSelectedSize('L')),
                  Text('L  '),
                  Checkbox(
                      value: selectedSizes.contains('XL'),
                      onChanged: (value) => changeSelectedSize('XL')),
                  Text('XL'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: selectedSizes.contains('24'),
                      onChanged: (value) => changeSelectedSize('24')),
                  Text('24'),
                  Checkbox(
                      value: selectedSizes.contains('26'),
                      onChanged: (value) => changeSelectedSize('26')),
                  Text('26'),
                  Checkbox(
                      value: selectedSizes.contains('28'),
                      onChanged: (value) => changeSelectedSize('28')),
                  Text('28'),
                  Checkbox(
                      value: selectedSizes.contains('30'),
                      onChanged: (value) => changeSelectedSize('30')),
                  Text('30'),
                  Checkbox(
                      value: selectedSizes.contains('32'),
                      onChanged: (value) => changeSelectedSize('32')),
                  Text('32'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: selectedSizes.contains('34'),
                      onChanged: (value) => changeSelectedSize('34')),
                  Text('34'),
                  Checkbox(
                      value: selectedSizes.contains('36'),
                      onChanged: (value) => changeSelectedSize('36')),
                  Text('36'),
                  Checkbox(
                      value: selectedSizes.contains('38'),
                      onChanged: (value) => changeSelectedSize('38')),
                  Text('38'),
                  Checkbox(
                      value: selectedSizes.contains('40'),
                      onChanged: (value) => changeSelectedSize('40')),
                  Text('40'),
                  Checkbox(
                      value: selectedSizes.contains('42'),
                      onChanged: (value) => changeSelectedSize('42')),
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

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)){
      setState(() {
        selectedSizes.remove(size);
      });
            }
    else {
       setState(() {
         selectedSizes.insert(0,size);
       });

    }
  }
}
