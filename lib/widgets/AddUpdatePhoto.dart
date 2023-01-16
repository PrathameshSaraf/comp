
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comp/Admin/Dashbord.dart';
import 'package:comp/widgets/Button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/AllMethods.dart';
import '../Models/Database.dart';
import '../Models/StorageServices.dart';
import 'TextEditor.dart';

class AddUpdatePhoto extends StatefulWidget {

  @override
  State<AddUpdatePhoto> createState() => _AddUpdatePhotoState();
}

class _AddUpdatePhotoState extends State<AddUpdatePhoto> {

  final _productTitleController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  final ImagePicker _picker = ImagePicker();
  File? image;
  final Storage storage=Storage();
  final db =DatabaseServices();
  bool isWeb = false;
  String uploadPercentage = "";
  List<String>? items;
  final all=allMethods();


  @override
  void initState() {
    getProducts();
    super.initState();
  }
  getProducts() async {
    final value = await db.getCategoriesValues();
    items = value;
    setState(() {});
  }
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles != null){
        imagefiles = pickedfiles;
        setState(() {
        print(imagefiles);
        });
      }else{
      }
    }catch (e) {
    }
  }

  List<String> _selectedItems = [];
  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API


    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items!);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });

    }
  }

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
                  child: Text("Add Photo"
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
                        "Add Photo"
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
                          labelText: "Photo name",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),Align(
                        child: Text("Photo Description",
                            style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        alignment: Alignment.centerLeft,
                      ),

                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 3,//Normal textInputField will be displayed
                        maxLines:null,
                        controller: _productDescriptionController,
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

      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // use this button to open the multi-select dialog
            Row(
                children: [
                  Text("Select Category",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: _showMultiSelect,
                    child: const Text('Select Photo Categories '),
                  ),]),
            const Divider(
              height: 30,
            ),
            // display selected items
            Wrap(
              children: _selectedItems
                  .map((e) => Chip(
                label: Text(e),
              ))
                  .toList(),
            )]),

                      SizedBox(
                        height: 30,
                      ),
                      Row(children: [
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          onPressed: (){
                               openImages();
                          },
                          child: const Text('Add Additional Photos'),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        HtmlEditorExample()
                                      ],
                                    ));
                              },
                            );
                          },
                          child: const Text("Add Long Description with Image"),
                        ),


                     ] ),
                      SizedBox(
                        height: 30,
                      ),
                      ButtonW100(text: "Add", onTap: (){
                        List<String> Categori=[_productPriceController.text,];
                        for(var i = 0; i< _controllers.length; i++) {
                          _controllers.forEach((element) {
                            Categori.add(element.text);
                          });
                        }
                        db.addPhotos('',_productTitleController.text.isEmpty?image!.path.split('/').last:_productTitleController.text,
                          _selectedItems,image.toString(),context,_productDescriptionController.text,imagefiles!.toList(),"",).then((value) {
                          storage.uploadImage(image!, _productTitleController
                              .text.isEmpty ? image!
                              .path
                              .split('/')
                              .last : _productTitleController.text, value,
                              context);
                          storage.imagesURL(imagefiles!,value);
                          all.fetchData(context,Dashbord(val: 4));
                        }  );



                        //.then((value) =>
                          //  storage.uploadCategoryImage(image!,value,context, (double progress) {
                              //uploading status
                            //   setState(() {
                            //     uploadPercentage = progress.toStringAsFixed(2);
                            //   });
                            // }, closePage));
                      }),
                    ],
                  ),
                ),
              ]),
        ));
  }
}



class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
            value: _selectedItems.contains(item),
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => _itemChange(item, isChecked!),
          ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}




