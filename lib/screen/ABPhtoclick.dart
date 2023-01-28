import 'package:comp/screen/ProductScreen.dart';
import 'package:comp/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../Models/Database.dart';
import '../Models/StorageServices.dart';
import '../widgets/AppBar.dart';

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
  File? imageFile;

  @override
  Widget build(BuildContext context) {
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
              GestureDetector(
                onTap: () async {
                  PickedFile? pickedFile = await ImagePicker().getImage(
                    source: ImageSource.camera,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    imageFile = File(pickedFile.path);
                    setState(() {
                      pickedFile=pickedFile;
                    });
                  }
                },
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(color: Colors.red[200]),
                  child: imageFile != null
                      ? Image.file(
                    imageFile!,
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
              widget.Time!="After"?ButtonW100(text: "Proceed", onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder:
                          (context) =>ABPhtoclick(Time:"After",mobile: widget.mobile,)));}):
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Add Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 10,),
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
                      ButtonW100(text: "Save", onTap: () {
                   print(widget.mobile);
                db.addDataForCustomerByMobileNumber(widget.mobile,{"hii":"heeloo"});
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
