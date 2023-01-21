
import 'package:flutter/material.dart';
import '../Models/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Product extends StatefulWidget {

  bool value;
  String Gender;
  Product({required this.value,required this.Gender});
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final db =DatabaseServices();
  final fb=FirebaseFirestore.instance;
  bool _isloading=true;
  List<dynamic> products=[];
  @override
  void initState() {
    getProducts();
    // TODO: implement initState
    super.initState();
  }
  getProducts()async {
    final value=await db.getMData();

    products=value;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    if(products.length>0){
      setState(() {
        _isloading=false;
      });
    }

    return _isloading?const Center(
      child: CircularProgressIndicator(),
    ):
    SingleChildScrollView(
    child: Column(children: <Widget>[


           GridView.builder(
             physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount:products.length,//images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0
              ),
              itemBuilder: (BuildContext context, int index){
                 if(products != null && products.length > index){
                 return InkWell(
                     onTap: (){
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                           builder: (context) =>Container(
                            // color: Colors.white,
                             child: SingleChildScrollView(
                               child: Container(
                                 //color: Colors.white,
                                 child: Padding(
                                   padding: const EdgeInsets.all(15.0),
                                   child: Column(
                                     children: <Widget>[
                                       SizedBox(height: 100,),
                                       Image.asset("assets/images/beep.png"),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: <Widget>[
                                          ElevatedButton(
                                             child: Text('Button 1'),
                                             onPressed: () {
                                               // button 1 action
                                             },
                                           ),
                                           ElevatedButton(
                                             child: Text('Button 2'),
                                             onPressed: () {
                                               // button 2 action
                                             },
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           ),
                           ));
                     },
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(16.0),
                       child:Stack(

                           children: [
                             Positioned(
                               child: Image.network(
                                 products.elementAt(index!)['Imagepath'],
                                 height: 200.0,
                                 width: 170,
                                 fit: BoxFit.cover,
                               ),
                             ),
                             Positioned(
                               bottom: 0,
                               left: 0,
                               right: 0,
                               child: Container(
                                 alignment: Alignment.center,
                                 padding: const EdgeInsets.all(10.0),
                                 decoration: const BoxDecoration(
                                   color: Colors.black45,
                                 ),
                                 child:   IconButton(
                                   iconSize: 50,
                                   icon: const Icon(Icons.delete_forever,color: Colors.blue,),
                                   onPressed: () async {
                                     setState(() {
                                       String data=products.elementAt(index!)['id'];
                                       print(data);
                                       fb.collection("PhotosCategories")
                                           .doc(data)
                                           .delete()
                                           .then((_) {
                                         print("success!");   });
                                       setState(() {
                                         getProducts();
                                       });

                                     });
                                     //Navigator.of(context).pop();
                                   },
                                 ),
                               ),
                             ),
                           ]),)
                 );
                 }
                 else{
                   return Container();
                 }
              },)

         ],
       ));
  }
}