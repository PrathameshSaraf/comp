//
// import 'dart:io';
// import 'package:beep_com/screen/categories.dart';
// import 'package:flutter/material.dart';
// import '../Models/StorageServices.dart';
// import 'package:image_picker/image_picker.dart';
// import '../Models/Database.dart';
// import '../widgets/AppBar.dart';
// import '../widgets/Button.dart';
// import '../widgets/createInputField.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class EditScreen extends StatefulWidget {
//   //static const routeName = '/edit';
//   final String id;
//   EditScreen(@required this.id);
//
//   @override
//   State<EditScreen> createState() => _EditScreenState();
// }
//
// class _EditScreenState extends State<EditScreen> {
//
//   final db =DatabaseServices();
//   final fb=FirebaseFirestore.instance;
//   final Storage storage=Storage();
//   String? Cu_id;
//   PickedFile? pickedFile;
//   File? imageFile;
//   final _formKey = GlobalKey<FormState>();
//
//   Map<String,dynamic>? products;
//   String? name;
//   String ?phno;
//   bool _isLoading=false;
//   String? dropdownValue;
//   String? imageUrl;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getProducts() ;
//   }
//
// var items = [
//     'Male',
//     'Female',
//   ];
//
//
//   void _fetchData(BuildContext context) async {
//     // show the loading dialog
//     showDialog(
//       // The user CANNOT close this dialog  by pressing outsite it
//         barrierDismissible: false,
//         context: context,
//         builder: (_) {
//           return Dialog(
//             // The background color
//             backgroundColor: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   // The loading indicator
//                   CircularProgressIndicator(),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   // Some text
//                   Text('Loading...')
//                 ],
//               ),
//             ),
//           );
//         });
//
//     // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
//     await Future.delayed(const Duration(seconds: 10));
//
//     // Close the dialog programmatically
//     Navigator.of(context)
//         .pushNamed('/Edit');
//   }
//
//
//   getProducts() {
//   fb.collection("custmer").doc(widget.id).get().then((value){
//
//     name=value.data()!['name'];
//     setState(() {
//
//     });
//   });
//   fb.collection("custmer").doc(widget.id).get().then((value){
//
//     phno=value.data()!['phno'];
//     setState(() {
//
//     });
//   });
//
//   fb.collection("custmer").doc(widget.id).get().then((value){
//
//     dropdownValue=value.data()!['Gender'];
//     setState(() {
//
//     });
//   });
//   fb.collection("custmer").doc(widget.id).get().then((value){
//
//     imageUrl=value.data()!['ImagePath'];
//     setState(() {
//
//     });
//   });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     if(name==null){
//       _isLoading=true;
//     }else{
//       _isLoading=false;
//     }
//
//     final _NameController = TextEditingController(text: name);
//     final _PhoneController = TextEditingController(text: phno);
//     setState(() {
//       name=_NameController.text;
//       phno=_PhoneController.text;
//       imageUrl= imageUrl;
//
//     });
//        return _isLoading
//            ? const Center(
//          child: CircularProgressIndicator(),
//        ) :
//        Scaffold(
//         appBar: AppbarSample().getAppBar('CUNSULTATION PRO'),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(60),
//               child: Column(children: <Widget>[
//                 SizedBox(
//                   height: 30,
//                 ),
//                 CreateInput(title: 'Client Name.',controller:_NameController,obscureText: false),
//                 CreateInput(title: 'Contact No.',controller:_PhoneController,obscureText: false, ),
//
//                 Align(
//                   child: Text("Gender",
//                       style:
//                       TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                   alignment: Alignment.centerLeft,
//                 ),
//
//                 DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       //<-- SEE HERE
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                     filled: true,
//                     //fillColor: Colors.greenAccent,
//                   ),
//                   // dropdownColor: Colors.greenAccent,
//                   value: dropdownValue,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       dropdownValue = newValue!;
//                     });
//                   },
//                   items: <String>['Male', 'Female']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(
//                         value,
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 GestureDetector(
//                   onTap: (){},
//                   // onTap: () async {
//                   //   PickedFile? pickedFile = await ImagePicker().getImage(
//                   //     source: ImageSource.camera,
//                   //     maxWidth: 1800,
//                   //     maxHeight: 1800,
//                   //   );
//                   //   if (pickedFile != null) {
//                   //     imageFile = File(pickedFile.path);
//                   //     setState(() {
//                   //       pickedFile=pickedFile;
//                   //     });
//                   //   }
//                   // },
//                   child: Container(
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(color: Colors.red[200]),
//                     child: imageFile != null
//                         ? Image.file(
//                       imageFile!,
//                       width: 200.0,
//                       height: 200.0,
//                       fit: BoxFit.fitHeight,
//                     )
//                         : Container(
//                       decoration: BoxDecoration(color: Colors.white),
//                       width: 200,
//                       height: 200,
//                       child:Image.network(imageUrl!)
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 ButtonW100(text: 'Update',onTap:() async{
//                   db.UpdateCostomer(widget.id,_NameController.text,dropdownValue.toString(),_PhoneController.text,context);
//                  // storage.uploadFile(imageFile!, DateTime.now().toString(),widget.id).then((value)=>print('done'));
//                   _fetchData(context);
//                 } ,
//                 )
//               ]),
//             ),
//           ),
//         )
//     );
//   }
// }