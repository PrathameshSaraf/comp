
import 'dart:io';

import 'package:comp/screen/categories.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/Database.dart';
import '../Models/StorageServices.dart';
import '../widgets/AppBar.dart';
import '../widgets/Button.dart';
import '../widgets/createInputField.dart';

String dropdownValue = 'Male';
String? imageUrl;

class RecordCostomer extends StatefulWidget {
  static const routeName = '/Record';


  @override
  State<RecordCostomer> createState() => _RecordCostomerState();
}

class _RecordCostomerState extends State<RecordCostomer> {



  var items = [
    'Male',
    'Female',
  ];
  final db =DatabaseServices();

  String? Cu_id;
  PickedFile? pickedFile;
  File? imageFile;

  final _formKey = GlobalKey<FormState>();

  final _NameController = TextEditingController();

  final _PhoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final Storage storage=Storage();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppbarSample().getAppBar('CUNSULTATION PRO'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(

              padding:width<600? EdgeInsets.all(60):width<1000?EdgeInsets.symmetric(horizontal: 200,vertical: 50)
                  :width<1500?EdgeInsets.symmetric(horizontal: 400,vertical: 50):EdgeInsets.symmetric(horizontal: 500,vertical: 50),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                CreateInput(title: 'Client Name.',controller: _NameController,obscureText: false),
                CreateInput(title: 'Contact No.',controller: _PhoneController,obscureText: false),
                Align(
                  child: Text("Gender",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  alignment: Alignment.centerLeft,
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
                  items: <String>['Male', 'Female']
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
                    width: 200,
                    height: 200,
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
                SizedBox(
                  height: 30,
                 ),
                ButtonW100(text: 'Proceed',onTap:() async{
                  if(_NameController.text!='' && _PhoneController.text!='' && imageUrl==null){
                  int firstSpace = _NameController.text.indexOf(" "); // detect the first space character
                  String firstName = _NameController.text.substring(0, firstSpace);  // get everything upto the first space character
                  String lastName = _NameController.text.substring(firstSpace).trim(); // get everything after the first space, trimming the spaces off

                  db.addCostomer('',firstName,lastName,dropdownValue.toString(),_PhoneController.text,imageUrl.toString(),context).then((value)=>
                  setState(() {
                  Cu_id=value;
                  })
                  ).then((value) {
                    print(imageFile);
                    storage.uploadFile(
                        imageFile!, DateTime.now().toString(), Cu_id!).then((
                        value) => print('done'));
                  } ).then((value) {
                    db.getMData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>CategoriesData(data: dropdownValue.toString(),)
                        )).then((value) {
                      _PhoneController.clear();
                      _NameController.clear();
                      setState(() {
                        imageFile=null;
                        dropdownValue="Male";
                        pickedFile=null;
                      });
                   });
                  });

                 Future<List?> Data= db.getMData( );
                    }else{
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Please Provide Correct Infomation")));
                  }
                  },
                )

              ]),
            ),
          ),
        )
    );
  }
}
