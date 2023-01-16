//
// import 'package:beep_com/Admin/editDelete.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../Models/Database.dart';
// import '../Models/customer.dart';
//
//
//
// class editDeleteScreen extends StatefulWidget {
//
//   static const routeName = '/Edit';
//
//   @override
//   State<editDeleteScreen> createState() => _editDeleteScreenState();
// }
//
// class _editDeleteScreenState extends State<editDeleteScreen> {
//   final fb=FirebaseFirestore.instance;
//
//   final db = DatabaseServices();
//
//
//   @override
//   Widget build(BuildContext context) {
//
// List<Customer> data;
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Your History'),
//
//         ),
//         body:  StreamBuilder<QuerySnapshot>(
//
//           stream: fb.collection('custmer').snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else
//               //QuerySnapshot<Object?>? data = snapshot.data;
//
//               return ListView(
//
//                 children: snapshot.data!.docs.map((doc) {
//                   return Card(
//                     child: ListTile(
//                       title: Text((doc.data() as dynamic)['name'],),
//                       leading:(doc.data() as dynamic)['ImagePath']==null? const Center(
//                         child: CircularProgressIndicator(),
//                       ):CircleAvatar(
//                         backgroundImage: NetworkImage((doc.data() as dynamic)['ImagePath']),
//
//                       ),
//                       trailing: Container(
//                         width: 100,
//                         child: Row(
//                           children: <Widget>[
//                             IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () {
//                                 String data=(doc.data() as dynamic)['id'];
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                     builder: (context) => EditScreen(data)
//                                 ));
//
//
//                                 //Navigator.of(context).pushNamed(EditScreen.routeName,arguments:data );
//                               },
//                               color: Theme.of(context).primaryColor,
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () async {
//                                 setState(() {
//                                   String data=(doc.data() as dynamic)['id'];
//                                   print(data);
//                                       fb.collection("custmer")
//                                       .doc(data)
//                                       .delete()
//                                       .then((_) {
//                                   print("success!");   });
//
//                                 });
//                                 //Navigator.of(context).pop();
//                                 }
//                               ,
//                               color: Theme.of(context).errorColor,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//           },
//         ),
//
//     );
//   }
// }
