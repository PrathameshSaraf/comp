// import 'package:beep_com/widgets/Button.dart';
// import 'package:flutter/material.dart';
//
// import '../Models/Database.dart';
//
// class addMorePhoto extends StatefulWidget {
//
//   @override
//   State<addMorePhoto> createState() => _addMorePhotoState();
// }
//
// class _addMorePhotoState extends State<addMorePhoto> {
//   final db =DatabaseServices();
//   bool isMale = false;
//   bool isFemale = false;
//   bool isShort = false;
//   bool isBoyCut = false;
//   bool isLong=false;
//   bool isBlue=false;
//   bool isRed=false;
//   bool isYellow=false;
//   String Gender='';
//   String HairStyle='';
//   String Color='';
//
//
//   @override
//
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//         child: Column(children: <Widget>[
//           Text(
//             "Selelct Categories",
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.orange),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Align(alignment: Alignment.centerLeft,
//               child:Text(" Gender", textAlign: TextAlign.left,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),)),
//         Padding(
//             padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//          child: Row(children: <Widget>[
//
//             Text("Male",style: TextStyle(fontSize: 17,)),
//             Checkbox(
//               checkColor: Colors.white,
//
//               value: isMale,
//               onChanged: (bool? value) {
//                 setState(() {
//                   isMale = value!;
//                   Gender='Male';
//                   isFemale=false;
//                 });
//               },
//             ),
//            SizedBox(
//              width: 15,
//            ),
//            Text("Female",style: TextStyle(fontSize: 17,)),
//            Checkbox(
//              checkColor: Colors.white,
//              // fillColor: MaterialStateProperty.resolveWith(getColor),
//              value: isFemale,
//              onChanged: (bool? value) {
//                setState(() {
//                  isFemale = value!;
//                  isMale=false;
//                  Gender='Female';
//                });
//              },
//            ),
//           ])
//         ),
//           SizedBox(
//             height: 20,
//           ),
//           Align(alignment: Alignment.centerLeft,
//               child:Text(" Hair Style", textAlign: TextAlign.left,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),)),
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//               child: Row(children: <Widget>[
//
//                 Text("Short",style: TextStyle(fontSize: 17,)),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   // fillColor: MaterialStateProperty.resolveWith(getColor),
//                   value: isShort,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isShort = value!;
//                       isBoyCut=false;
//                       isLong=false;
//                       HairStyle='Short';
//                     });
//                   },
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Text("BoyCut",style: TextStyle(fontSize: 17,)),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   // fillColor: MaterialStateProperty.resolveWith(getColor),
//                   value: isBoyCut,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isBoyCut = value!;
//                       isShort=false;
//                       isLong=false;
//                       HairStyle='BoyCut';
//                     });
//                   },
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Text("Long",style: TextStyle(fontSize: 17,)),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   // fillColor: MaterialStateProperty.resolveWith(getColor),
//                   value: isLong,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isLong = value!;
//                       isBoyCut=false;
//                       isShort=false;
//                       Gender='Long';
//                     });
//                   },
//                 ),
//               ])
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Align(alignment: Alignment.centerLeft,
//               child:Text(" Hair Color", textAlign: TextAlign.left,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),)),
//
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//               child: Row(children: <Widget>[
//
//                 Text("Blue",style: TextStyle(fontSize: 17,)),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   // fillColor: MaterialStateProperty.resolveWith(getColor),
//                   value: isBlue,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isBlue = value!;
//                       isRed=false;
//                       isYellow=false;
//                       Color="Blue";
//                     });
//                   },
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Text("Red",style: TextStyle(fontSize: 17,)),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   // fillColor: MaterialStateProperty.resolveWith(getColor),
//                   value: isRed,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isRed = value!;
//                       isBlue=false;
//                       isYellow=false;
//                       Color='Red';
//                     });
//                   },
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Text("Yellow",style: TextStyle(fontSize: 17,)),
//                 Checkbox(
//                   checkColor: Colors.white,
//                   // fillColor: MaterialStateProperty.resolveWith(getColor),
//                   value: isYellow,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isYellow = value!;
//                       isRed=false;
//                       isBlue=false;
//                       Color='Yellow';
//                     });
//                   },
//                 ),
//               ])
//           ),
//         ]));
//
//   }
//   }
