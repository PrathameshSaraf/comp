
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comp/widgets/Button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/Database.dart';
import '../Models/StorageServices.dart';

class AddEditCategoryScreen extends StatefulWidget {

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _AddController = TextEditingController();
  String dropdownValue = 'Gender';
  final _productTitleController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  File? image;
  bool isRecommended = false;
  bool isTopPicks = false;
  bool isTopSelling = false;
  bool isNonVeg = false;
  bool _isLoading = true;
  var items = [
    'Gender'
    'Male',
    'Female',
  ];
  final Storage storage=Storage();
  final db =DatabaseServices();
  bool isWeb = false;
  String uploadPercentage = "";

  @override
  void initState() {
    super.initState();
    //load categories first
    // if (widget.product != null) {
    //   //edit
    //   _productTitleController.text = widget.product!.title;
    //   _productPriceController.text = widget.product!.price;
    //   _productDescriptionController.text = widget.product!.description;
    //   isRecommended = widget.product!.recommended;
    //   isTopPicks = widget.product!.topPicks;
    //   isTopSelling = widget.product!.topSelling;
    //   isNonVeg = widget.product!.isNonVeg;
    // }
    // loadCategories();
  }

  // loadCategories() async {
  //   categories = await _db.getCategories(context);
  //   categories.insert(
  //       0, CategoryModel(category: "None", image: "", id: "none"));
  //   selectedCategory = categories[0];
  //   if (widget.product != null) {
  //     for (var c in categories) {
  //       if (c.id == widget.product!.categoryId) {
  //         selectedCategory = c;
  //       }
  //     }
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  pickImage(ImageSource source) async {
    _picker.pickImage(source: source, maxHeight: 480, maxWidth: 480).then((i) {
      final imageTemp = File(i!.path);
      setState(() {
        image = imageTemp;
      });
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Unable to get image")));
    });
  }

  List<TextEditingController> _controllers = [];
  List<RadioListTile> _fields = [];

  Widget _addTile() {
    return ListTile(
      title: Icon(Icons.add),
      onTap: () {
        int index=0;
        final controller = TextEditingController();
        final field = RadioListTile(
          title:  TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Value ",
            ),
          ),
          value: "male",
          groupValue: "Category Name",
          onChanged: (value){
            setState(() {

            });
          },
        );

        setState(() {
          _controllers.add(controller);
          _fields.add(field);

        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return   _fields[index];

      },
    );
  }

  closePage() {
    if (isWeb) {
      //hide the page
      // widget.addEditCategory!(null, true);
      //Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  // addUpdateCategory() {
  //   if (_formKey.currentState!.validate()) {
  //     String category = categoryTitleController.text;
  //     if (widget.category == null) {
  //       //add category
  //       if (image == null) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text("Please Select Image.")));
  //         return;
  //       }
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       final categoryData = CategoryModel(
  //           category: category, image: image == null ? "" : image!.path);
  //       db.addCategory("default", category, context).then((value) {
  //         if (value == "") {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text("Unable to update data.")));
  //           return;
  //         }
  //         categoryData.id = value;
  //         storage.uploadCategoryImage(image!, categoryData, context,
  //                 (double progress) {
  //               //uploading status
  //               setState(() {
  //                 uploadPercentage = progress.toStringAsFixed(2);
  //               });
  //             }, closePage);
  //       });
  //     } else {
  //       widget.category!.category = category;
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       db.updateCategoryTitle(category, widget.category!.id).then((value) {
  //         widget.category!.category = category;
  //         if (image != null) {
  //           _storage.uploadCategoryImage(image!, widget.category!, context,
  //                   (double progress) {
  //                 //uploading status
  //                 setState(() {
  //                   uploadPercentage = progress.toStringAsFixed(2);
  //                 });
  //               }, closePage);
  //         } else {
  //           closePage();
  //         }
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    isWeb = width >= 1000;
    return  Container(
        width: width > 1000
            ? (width - 240) / 2 - 10
            : width > 700
            ? 700.0
            : width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
                child: Text("Add Category"
                 // widget.product == null ? "Add Product" : "Update Product",
                  ,style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child:
                image == null
                    ? 0>1
                    ? SizedBox(
                  width: width-200,
                  height: 200.0,
                  child:CachedNetworkImage(
                      progressIndicatorBuilder:
                          (context, url, progress) => Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/saloonapp-e9508.appspot.com/o/Photos%2F097485443073593922?alt=media&token=76cc1642-6f48-488a-8d12-22c120249e24"),

                )
                    : Container(
                  width: width,
                  height: 240.0,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0x170000FF),
                  ),
                  child: const Text(
                    "No image selected",
                    style: TextStyle(fontSize: 22.0),
                  ),
                )
                    : kIsWeb
                    ? Image.network(
                  image!.path,
                  width: width - 200,
                  height: 240.0,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  image!,
                  width: width - 200,
                  height: 240.0,
                  fit: BoxFit.cover,
                ),
              ),
              uploadPercentage != ""
                  ? Center(
                child: Text(
                  "Uploading image :- $uploadPercentage% uploaded",
                ),
              )
                  : const SizedBox(),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Browse image"),
                        content: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.camera),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text("Camera"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                   print(pickImage(ImageSource.gallery).runtimeType);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.photo_album_outlined),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text("Gallery"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text(
                      "Add Image"
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (v) {
                        return v == null
                            ? "Required field"
                            : v.isEmpty
                            ? "Required Field"
                            : null;
                      },
                      controller: _productTitleController,
                      decoration: const InputDecoration(
                        labelText: "Category Title",
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),Align(
                      child: Text("Category Description",
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      alignment: Alignment.centerLeft,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,//Normal textInputField will be displayed
                      maxLines:null,
                      controller: _AddController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          //<-- SEE HERE
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        filled: true,
                        //fillColor: Colors.greenAccent,
                      ),
                      // dropdownColor: Colors.greenAccent,
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Gender','Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 30,
                    ),


                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Category Values",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                    RadioListTile(
                      title:  TextFormField(
                        validator: (v) {
                          return v == null
                              ? "Required field"
                              : v.isEmpty
                              ? "Required Field"
                              : null;
                        },
                        controller: _productPriceController,
                        decoration: const InputDecoration(
                          labelText: "Value",
                        ),
                      ),
                      value: "male",
                      groupValue: "Category Name",
                      onChanged: (value){
                        setState(() {

                        });
                      },
                    ),
                    Container(
                      child: Column(
                        children: [

                      _listView(),
                          _addTile(),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 20.0,
              ),
                    ButtonW100(text: "Add", onTap: (){
                      List<String> Categori=[_productPriceController.text,];
                      for(var i = 0; i< _controllers.length; i++) {
                       _controllers.forEach((element) {
                         Categori.add(element.text);
                       });
                      }


                      db.addCategory('', _productTitleController.text, Categori, '', context,dropdownValue,_AddController.text).then((value) =>
                          storage.uploadCategoryImage(image!,value,context, (double progress) {
                            //uploading status
                            setState(() {
                              uploadPercentage = progress.toStringAsFixed(2);
                            });
                          }, closePage));
                    }),
            ],
          ),
        ),
      ]),
    ));
  }
}

