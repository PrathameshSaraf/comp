
import 'package:firebase_storage/firebase_storage.dart';
import 'package:comp/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/Database.dart';
import '../services/StorageServices.dart';
import '../widgets/AppBar.dart';
import 'lastPage.dart';
String? Cu_id;
class ABPhtoclick extends StatefulWidget {
  String Time,mobile;
  ABPhtoclick({required this.Time,required this.mobile});
  @override
  State<ABPhtoclick> createState() => _ABPhtoclickState();
}

class _ABPhtoclickState extends State<ABPhtoclick> {
  ///const ABPhtoclick({Key? key}) : super(key: key);
  PickedFile? pickedFile;
  final Storage storage=Storage();
  final db =DatabaseServices();
  final _productDescriptionController = TextEditingController();
  final _serviceController = TextEditingController();
  File? imageFile1;
  String? image1;
  File? imageFile2;
  String? image2;
  final _db = FirebaseFirestore.instance;

  void updateCuId(String value) {
    setState(() {
      print(value);
      Cu_id = value;
      print(Cu_id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //print("fff$Cu_id");
    return Scaffold(
      appBar: AppbarSample().getAppBar('Click  ${widget.Time} Photo'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text("Click The Photo ${widget.Time} the creatation",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20,),
              widget.Time=="Before"?GestureDetector(
                onTap: () async {
                  PickedFile? pickedFile = await ImagePicker().getImage(
                    source: ImageSource.camera,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    imageFile1 = File(pickedFile.path);
                    setState(() {
                      pickedFile=pickedFile;
                    });
                  }
                },
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(color: Colors.red[200]),
                  child: imageFile1 != null
                      ? Image.file(
                    imageFile1!,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.fitHeight,
                  )
                      : Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: 200,
                    height: 200,
                    child: Icon(
                      size: 100.0,
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ):GestureDetector(
                onTap: () async {
                  PickedFile? pickedFile = await ImagePicker().getImage(
                    source: ImageSource.camera,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    imageFile2 = File(pickedFile.path);
                    setState(() {
                      pickedFile=pickedFile;
                    });
                  }
                },
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(color: Colors.red[200]),
                  child: imageFile2 != null
                      ? Image.file(
                    imageFile2!,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.fitHeight,
                  )
                      : Container(
                    decoration: BoxDecoration(color: Colors.white),
                    width: 200,
                    height: 200,
                    child: Icon(
                      size: 100.0,
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              widget.Time!="After"?ButtonW100(text: "Proceed", onTap: ()async{
                db.addDataForCustomerByMobileNumber(widget.mobile,{"Date":DateTime.now(),"Aimage":'',"Bimage":'',"Description":'',"Service":''}).then((value) {
                  updateCuId(value);
                  setState((){
                    updateCuId(value);
                  //  Cu_id = value;
                });}).then((_)async{
                  print(Cu_id);
                  image1=await storage.uploadFile1(imageFile1!,Cu_id,widget.mobile);
                });


                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder:
                          (context) =>ABPhtoclick(Time:"After",mobile: widget.mobile,)));}):
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Service",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: _serviceController,
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Add Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        onTap:()async{
                          print(Cu_id);
                          image2=await storage.uploadFile2(imageFile2!,Cu_id,widget.mobile);
                        },
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
                      ButtonW100(text: "Save", onTap: () async{
                        _db.collection("custmer").doc(widget.mobile).collection(widget.mobile).doc(Cu_id).update({"Description":_productDescriptionController.text,"Service":_serviceController.text});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>SuccessPage(),
                            ));
                      })
                    ],
                  )
            ],
          ),
        ),
      ),

    );
  }
}
