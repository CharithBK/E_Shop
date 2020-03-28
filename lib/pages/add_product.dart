import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp_tut/db/brand.dart';
import 'package:shopapp_tut/db/category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopapp_tut/db/product.dart';


import 'admin.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController oldpriceController = TextEditingController();
  TextEditingController conditionController = TextEditingController();


  List<DropdownMenuItem<String>> categoriesDropDown =<DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  String _currentCategory;
  String _currentBrand;

  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  List<String> selectedSizes = <String>[];

  File _image1;
  var img1;
  File _image2;
  File _image3;

  @override
  void initState() {
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
        leading: new IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Admin()),
              );
            }),

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
                        onPressed: () {

                          _selectImage(ImagePicker.pickImage(source: ImageSource.gallery),1);
                        },
                        child: _displayChild1(),
                      ),
                    ),
                  ),
//                  Expanded(
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: OutlineButton(
//                        borderSide: BorderSide(
//                            color: grey.withOpacity(0.5), width: 2.5),
//                        onPressed: () {  _selectImage(ImagePicker.pickImage(source: ImageSource.gallery),2);},
//                        child: _displayChild2(),
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: OutlineButton(
//                        borderSide: BorderSide(
//                            color: grey.withOpacity(0.5), width: 2.5),
//                        onPressed: () {  _selectImage(ImagePicker.pickImage(source: ImageSource.gallery),3);},
//                        child: _displayChild3(),
//                      ),
//                    ),
//                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: red, fontSize: 12),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration( labelText: 'Product name', hintText: 'name'),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the product name';
                    }
                    else if (value.length > 10) {
                      return 'Product name cant have more than 10 letters';
                    }
                  },
                ),
              ),

//              select category

//              Visibility(
//                visible: _currentCategory != null || _currentCategory == '',
//                child: Text(_currentCategory ?? "null",
//                    style: TextStyle(color: red)),
//              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      controller: categoryController,
                      decoration: InputDecoration(labelText: 'Category' ,hintText: 'add category')),
                  suggestionsCallback: (pattern) async {
                    //print(pattern);
                    //print("gggg");

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
                      //print("gg");
                      _currentCategory = suggestion['name'];
                      categoryController.text = _currentCategory;
                    });
                  },
                ),
              ),

//            select brand

//              Visibility(
//                visible: _currentBrand != null || _currentBrand == '',
//                child:
//                    Text(_currentBrand ?? "null", style: TextStyle(color: red)),
//              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      controller: brandController,
                      decoration: InputDecoration(labelText: 'Brand' ,hintText: 'add brand') ,
                    // ignore: missing_return

                  ),

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
                    // ignore: missing_return
                    setState(() {

                      _currentBrand = suggestion['name'];
                      print(_currentBrand);
                      if(_currentBrand != null) {
                        brandController.text = _currentBrand;
                      }
                      else {
                        Fluttertoast.showToast(msg: 'select the brand');
                      }

                    });
                  },
                  // ignore: missing_return
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please select a city';
//                    }
//                  },
//                  onSaved: (value) => this._currentBrand = value,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: quantityController,
                  //initialValue: '1',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Quantity' , hintText: 'qty'),
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
                  decoration: InputDecoration( labelText: 'Product Description', hintText: ' Description'),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter Product Description";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: conditionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration( labelText: 'Condition', hintText: 'condition'),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter Product Condition";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: oldpriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Product Old Price', hintText: ' Old Price'),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter Product Old Price";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'ProductPrice', hintText: ' Price'),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return "You must enter Product Price";
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
                onPressed: () {
                  validateAndUpload();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedCategory) {
    setState(() => _currentBrand = selectedCategory);
  }

  void changeSelectedSize(String size) {
    //print(selectedSizes);
    if (selectedSizes.contains(size)){
      setState(() {
        selectedSizes.remove(size);

      });
            }
    else {
       setState(() {
         //selectedSizes.insert(0,size);
         selectedSizes.add(size);
         print(selectedSizes);
         //print(size);
       });

    }
  }

  void _selectImage(Future<File> pickImage ,int imageNumber) async{
    //File tempImg = await pickImage;
    var tempImg = await pickImage;
    //print("oo");
    //print(tempImg);
    switch(imageNumber){
      case 1: setState(() {
        _image1 = tempImg;
        img1 = tempImg;
      });
      break;
      case 2: setState(() => _image2 = tempImg);
      break;
      case 3: setState(() => _image3 = tempImg);
      break;
    }

  }

  Widget _displayChild1() {
    if(_image1 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: grey,),
      );
    }else{
      return Image.file(_image1, fit: BoxFit.fill, width: double.infinity,);
    }
  }
//
//  Widget _displayChild2() {
//    if(_image2 == null){
//      return Padding(
//        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
//        child: new Icon(Icons.add, color: grey,),
//      );
//    }else{
//      return Image.file(_image2, fit: BoxFit.fill, width: double.infinity,);
//    }
//  }
//
//  Widget _displayChild3() {
//    if(_image3 == null){
//      return Padding(
//        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
//        child: new Icon(Icons.add, color: grey,),
//      );
//    }else{
//      return Image.file(_image3, fit: BoxFit.fill, width: double.infinity,);
//    }
//  }

  void validateAndUpload() {

        if(_formKey.currentState.validate()){
      if(_image1 != null){
        //String gg = "XL";
        if(selectedSizes.isNotEmpty){
          String size = selectedSizes[0];
          _productService.uploadProduct(productNameController.text,categoryController.text,brandController.text,quantityController.text,descriptionController.text,conditionController.text,oldpriceController.text,priceController.text,size,img1);
          Fluttertoast.showToast(msg: 'all done');
        }else{
          Fluttertoast.showToast(msg: 'select atleast one size');
        }
      }else{
        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}
