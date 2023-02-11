import 'dart:io';
import 'package:comp/screen/categories.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/Database.dart';
import '../Models/StorageServices.dart';
import '../Models/customer.dart';
import '../widgets/AppBar.dart';
import '../widgets/Button.dart';
import 'package:flutter/services.dart';

String dropdownValue = 'Male';
String? imageUrl;
String? imagePath;
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
  final db = DatabaseServices();
  String? Cu_id;
  PickedFile? pickedFile;
  File? imageFile;
  final _formKey = GlobalKey<FormState>();
  List<Customer> dataList = [];
  final _NameController = TextEditingController();
  final _PhoneController = TextEditingController();
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppbarSample().getAppBar('CUNSULTATION PRO'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: width < 600
                  ? EdgeInsets.all(60)
                  : width < 1000
                      ? EdgeInsets.symmetric(horizontal: 200, vertical: 50)
                      : width < 1500
                          ? EdgeInsets.symmetric(horizontal: 400, vertical: 50)
                          : EdgeInsets.symmetric(horizontal: 500, vertical: 50),
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      child: Text("Contact Number",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      alignment: Alignment.centerLeft,
                    ),
                    TextFormField(
                      controller: _PhoneController,

                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 10,
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mobile number is required";
                        }
                        RegExp regExp = RegExp(r'^\d{10}$');
                        if (!regExp.hasMatch(value)) {
                          return "Enter a valid mobile number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      child: Text("Name",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      alignment: Alignment.centerLeft,
                    ),
                    TextFormField(
                      controller: _NameController,
                      onTap: (){
                        db.getDataFromMobile(_PhoneController.text).then((value) {
                          _NameController.text = value.single.fname + " " + value.single.lname;
                          setState(() {
                            dropdownValue=value.single.Gender;
                            imagePath=value.single.ImagePath;
                          });
                         // print(value.single.ImagePath);
                        }
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      child: Text("Gender",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      alignment: Alignment.centerLeft,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                      // dropdownColor: Colors.greenAccent,
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          print(imagePath);
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
                            pickedFile = pickedFile;
                          });
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(color: Colors.red[200]),
                        child: imageFile != null || imagePath!=null
                            ? imagePath!=null?
                          Image.network(imagePath!, width: 200.0,
                          height: 200.0,
                          fit: BoxFit.fitHeight,)
                            : Image.file(
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
                    ButtonW100(
                      text: 'Proceed',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                        if (_NameController.text != '' &&
                            _PhoneController.text != '' && imageUrl == null) {
                          int firstSpace = _NameController.text
                              .indexOf(" "); // detect the first space character
                          String firstName = _NameController.text.substring(0,
                              firstSpace); // get everything upto the first space character
                          String lastName = _NameController.text
                              .substring(firstSpace)
                              .trim(); // get everything after the first space, trimming the spaces off

                           db.addCostomer('', firstName, lastName, dropdownValue.toString(), _PhoneController.text, imageUrl.toString(), context)
                              .then((value) => setState(() {
                                    Cu_id = value;
                                  }))
                              .then((value) {
                            print(imageFile);
                            storage.uploadFile(imageFile!,DateTime.now().toString(), Cu_id!).then((value) => print('done'));
                          }).then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoriesData(
                                          data: dropdownValue.toString(),mobile: Cu_id!,
                                        ))).then((value) {
                              _PhoneController.clear();
                              _NameController.clear();
                              setState(() {
                                imageFile = null;
                                imagePath=null;
                                dropdownValue = "Male";
                                pickedFile = null;
                              });
                            });
                          });

                        } }
                      },
                    )
                  ])),
            ),
          ),
        ));
  }
}
