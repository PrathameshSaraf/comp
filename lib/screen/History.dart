//
// import 'package:flutter/material.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../Models/Database.dart';
//
//
// class HistoryScreen extends StatefulWidget {
//   static const routeName = '/History';
//
//
//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> {
//   bool _isloading=true;
//   final fb=FirebaseFirestore.instance;
//   final db = DatabaseServices();
//   List<dynamic> products=[];
//
//   @override
//   void initState() {
//     getProducts();
//     // TODO: implement initState
//     super.initState();
//   }
//   getProducts()async {
//     final value=await db.getHistoryData();
//     products=value;
//     setState(() {
//
//     });
//   }
//
//
//   @override
//
//   Widget build(BuildContext context) {
//
//     if(products.length>0){
//       setState(() {
//         _isloading=false;
//       });
//     }
//     // print("111111111111111111111111111111111111111111111111111");
//     // print(products.length);
//     // print("111111111111111111111111111111111111111111111111111");
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Your History'),
//
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//
//             stream: fb.collection('custmer').snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else
//                 //QuerySnapshot<Object?>? data = snapshot.data;
//                 return  _isloading?const Center(
//                   child: CircularProgressIndicator(),
//                 ): GridView.builder(
//                   physics: ScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount:products.length,//images.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 6.0,
//                       mainAxisSpacing: 6.0
//                   ),
//                   itemBuilder: (BuildContext context, int index){
//                     if(products != null && products.length > index){
//                       return Image.network( products.elementAt(index!)['ImagePath'],height: 10.0,width: 10,fit: BoxFit.cover,);}
//                     else{
//                       return Container();
//                     }
//                   },);
//             }
//         )
//     );
//   }
// }