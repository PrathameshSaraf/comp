// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../Models/Database.dart';
// import '../Models/StorageServices.dart';
// import '../widgets/AppBar.dart';
// import '../widgets/Button.dart';
// import '../widgets/addPhoto.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:firebase_core/firebase_core.dart' as firebase_core;
//
// class AddPhotos extends StatefulWidget {
//   //const AddPhotos({Key? key}) : super(key: key);
//   static const routeName = '/addPhoto';
//
//   @override
//   State<AddPhotos> createState() => _AddPhotosState();
// }
//
// class _AddPhotosState extends State<AddPhotos> {
//   final db = DatabaseServices();
//   bool isMale = false;
//   bool isFemale = false;
//   bool isShort = false;
//   bool isBoyCut = false;
//   bool isLong = false;
//   bool isBlue = false;
//   bool isRed = false;
//   bool isYellow = false;
//   String Gender = '';
//   String HairStyle = '';
//   String Color = '';
//   String Ph_id = '';
//
//   final ImagePicker imgpicker = ImagePicker();
//   List<XFile>? imagefiles;
//   void _fetchData(BuildContext context) async {
//     // show the loading dialog
//     showDialog(
//         // The user CANNOT close this dialog  by pressing outsite it
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
//     Navigator.of(context).pushNamed('/');
//   }
//
//   openImages() async {
//     try {
//       var pickedfiles = await imgpicker.pickMultiImage();
//       //you can use ImageCourse.camera for Camera capture
//       if (pickedfiles != null) {
//         imagefiles = pickedfiles;
//         setState(() {});
//       } else {}
//     } catch (e) {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Storage storage = Storage();
//     return Column(children: <Widget>[
//       SizedBox.fromSize(
//         size: Size(150, 150),
//         child: ClipOval(
//           child: Material(
//             color: Colors.orange,
//             child: InkWell(
//               splashColor: Colors.green,
//               onTap: () {
//                 setState(() {});
//               },
//               child: InkWell(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Icon(
//                       Icons.add_a_photo,
//                       size: 50,
//                     ),
//                     Text("Add More Photo "), // <-- Text
//                   ],
//                 ),
//                 onTap: () {
//                   openImages();
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//       SizedBox(height: 30),
//       Padding(
//           padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//           child: Column(children: <Widget>[
//             Text(
//               "Selelct Categories",
//               style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.orange),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   " Gender",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//                 child: Row(children: <Widget>[
//                   Text("Male",
//                       style: TextStyle(
//                         fontSize: 17,
//                       )),
//                   Checkbox(
//                     checkColor: Colors.white,
//                     value: isMale,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isMale = value!;
//                         Gender = 'Male';
//                         isFemale = false;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text("Female",
//                       style: TextStyle(
//                         fontSize: 17,
//                       )),
//                   Checkbox(
//                     checkColor: Colors.white,
//                     // fillColor: MaterialStateProperty.resolveWith(getColor),
//                     value: isFemale,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isFemale = value!;
//                         isMale = false;
//                         Gender = 'Female';
//                       });
//                     },
//                   ),
//                 ])),
//             SizedBox(
//               height: 20,
//             ),
//             Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   " Hair Style",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//                 child: Row(children: <Widget>[
//                   Text("Short",
//                       style: TextStyle(
//                         fontSize: 17,
//                       )),
//                   Checkbox(
//                     checkColor: Colors.white,
//                     // fillColor: MaterialStateProperty.resolveWith(getColor),
//                     value: isShort,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isShort = value!;
//                         isBoyCut = false;
//                         isLong = false;
//                         HairStyle = 'Short';
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text("BoyCut",
//                       style: TextStyle(
//                         fontSize: 17,
//                       )),
//                   Checkbox(
//                     checkColor: Colors.white,
//                     // fillColor: MaterialStateProperty.resolveWith(getColor),
//                     value: isBoyCut,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isBoyCut = value!;
//                         isShort = false;
//                         isLong = false;
//                         HairStyle = 'BoyCut';
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text("Long",
//                       style: TextStyle(
//                         fontSize: 17,
//                       )),
//                   Checkbox(
//                     checkColor: Colors.white,
//                     // fillColor: MaterialStateProperty.resolveWith(getColor),
//                     value: isLong,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isLong = value!;
//                         isBoyCut = false;
//                         isShort = false;
//                         Gender = 'Long';
//                       });
//                     },
//                   ),
//                 ])),
//             SizedBox(
//               height: 15,
//             ),
//             Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   " Hair Color",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )),
//             Padding(
//                 padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//                 child: Row(children: <Widget>[
//                   Text("Blue",
//                       style: TextStyle(
//                         fontSize: 17,
//                       )),
//                   Checkbox(
//                     checkColor: Colors.white,
//                     // fillColor: MaterialStateProperty.resolveWith(getColor),
//                     value: isBlue,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isBlue = value!;
//                         isRed = false;
//                         isYellow = false;
//                         Color = "Blue";
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text("Red",
//                       style: TextStyle(
//                         fontSize: 17,
//                       )),
//                   Checkbox(
//                     checkColor: Colors.white,
//                     // fillColor: MaterialStateProperty.resolveWith(getColor),
//                     value: isRed,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isRed = value!;
//                         isBlue = false;
//                         isYellow = false;
//                         Color = 'Red';
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text("Yellow",
//                       style: TextStyle(
//                         fontSize: 17,
//                       )),
//                   Checkbox(
//                     checkColor: Colors.white,
//                     // fillColor: MaterialStateProperty.resolveWith(getColor),
//                     value: isYellow,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isYellow = value!;
//                         isRed = false;
//                         isBlue = false;
//                         Color = 'Yellow';
//                       });
//                     },
//                   ),
//                 ])),
//           ])),
//       SizedBox(
//         height: 30,
//       ),
//       ButtonW100(
//           text: "Upload",
//           onTap: () => {
//                 //  storage.uploadFiles(imagefiles!, '', DateTime.now().toString(), Gender, Color, HairStyle, context),
//                 //storage.uploadImage(DateTime.now().millisecondsSinceEpoch.toString(),imagefiles),
//                 _fetchData(context),
//               }),
//     ]);
//   }
// }
