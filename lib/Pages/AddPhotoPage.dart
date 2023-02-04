
import 'package:comp/Admin/Dashbord.dart';
import 'package:comp/Models/AllMethods.dart';
import 'package:comp/Models/StorageServices.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Database.dart';
import '../screen/photoSlider.dart';
import '../widgets/AddUpdateCategories.dart';
import '../widgets/AddUpdatePhoto.dart';
import 'ClientPage.dart';

class AddPhotoPage extends StatefulWidget {
  String Gender;
  bool value;
  AddPhotoPage({required this.Gender, required this.value});
  @override
  State<AddPhotoPage> createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  final db = DatabaseServices();
  final st = Storage();
  final fb = FirebaseFirestore.instance;
  final all=allMethods();
  bool _isloading = true;
  List<dynamic> products = [];
  List<String> IDS = [];
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };

  @override
  void initState() {
    getProducts();

    // TODO: implement initState
    super.initState();
  }

  getProducts() async {
    final value = await db.getMData();
    products = value;
    setState(() {});
  }

  delete(List<String> IDS)async{
    for (var data in IDS) {
      DocumentSnapshot snapshot = await fb.collection("Photos").doc(data).get();
      if (snapshot.exists) {
        Map map = Map.from(snapshot.data() as Map<dynamic,dynamic>);
         List<dynamic> ph=map['AdditionalPhotos'];
         ph.forEach((element) {
           st.deleteImage(element,'Photos');
         });
        st.deleteImage(map['Imagepath'],'Photos');
      } else {
        print("Data not found for document: $data");
      }
    fb.collection("Photos").doc(data).delete().then((_) {
    print("success!");
    });
    }

  }
  
  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Not Select any Photo"),
      content: Text("Please selete atleast One Photo"),
      actions: [
        okButton,
      ],
    );
    if (products.length > 0) {
      setState(() {
        _isloading = false;
      });
    }


    return  Container(
            //  color: Colors.white,
            child: Expanded(
                // Expanded_A
                child: Container(
            //   color: Colors.white,
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                    // alignment: Alignment.topLeft,
                    children: [
                      Text(
                        " Photos ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.orange),
                      ),
                      Icon(
                        Icons.photo,
                        color: Colors.orange,
                        size: 40.0,
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                color: Colors.white,
                                width: 210,
                                child: Row(
                                  children: [

                                    ClipOval(
                                      child: Material(
                                        color: Colors.orange, // Button color
                                        child: InkWell(
                                          splashColor: Colors.red, // Splash color
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    content: Stack(

                                                      children: <Widget>[
                                                        Positioned(
                                                          right: -40.0,
                                                          top: -40.0,
                                                          child: InkResponse(
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: CircleAvatar(
                                                              child: Icon(Icons.close),
                                                              backgroundColor: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        AddUpdatePhoto(),
                                                      ],
                                                    ));
                                              },
                                            );
                                          },


                                          child: SizedBox(width: 56, height: 56, child: Icon(Icons.add)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    ClipOval(
                                      child: Material(
                                        color: Colors.orange, // Button color
                                        child: ExTExpample(products: products,),
                                      ),
                                    ),

                                    SizedBox(width: 20,),
                                    ClipOval(
                                      child: Material(
                                        color: Colors.orange, // Button color
                                        child: InkWell(
                                          splashColor: Colors.red, // Splash color
                                          onTap: () {
                                            if(!IDS.isEmpty){
                                            delete(IDS);
                                            all.fetchData(context,Dashbord(val: 4));
                                            }
                                            else{
                                            showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                            return alert;
                                            },
                                            );
                                          }},
                                          child: SizedBox(width: 56, height: 56, child: Icon(Icons.delete)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))),

                    ]),
              ),
              _isloading
                  ? Container(
                // color: Colors.white,
                  child: Expanded(
                    // Expanded_A
                      child: Container(
                        // color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ))))
                  :Expanded(
                child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: products.length, //images.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6,
                                    crossAxisSpacing: 6.0,
                                    mainAxisSpacing: 6.0),
                            itemBuilder: (BuildContext context, int index) {
                              if (products != null && products.length > index) {
                                return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => PhotoSlider(),)
                                                  );

                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          child: Stack(children: [
                                            Positioned(
                                              child: Image.network(
                                                products[index]['Imagepath'],
                                                height: 200.0,
                                                width: 170,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                            Positioned(
                                                top: 0,
                                                left: 0,
                                                right: 3,
                                                child: Container(
                                                    // color: Colors.white,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.black12,
                                                    ),
                                                    child: Checkbox(
                                                      value: IDS.contains(
                                                          products[index!]['id']),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          if (IDS.contains(products[index!]['id']!)) {
                                                            IDS.remove(products[index!]['id']); // unselect
                                                          } else {
                                                            IDS.add(products
                                                                    .elementAt(
                                                                        index!)[
                                                                'id']); // select
                                                          }
                                                           // value==true?IDS.add(products.elementAt(index!)['id']):IDS.remove(products.elementAt(index!)['id']);
                                                          print(IDS);
                                                        });
                                                      },
                                                    ))),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                decoration: const BoxDecoration(
                                                  color: Colors.black12,
                                                ),
                                                child: IconButton(
                                                  iconSize: 30,
                                                  icon: const Icon(
                                                    Icons.delete_forever,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () async {
                                                    setState(() {
                                                      String data =
                                                          products.elementAt(
                                                              index!)['id'];

                                                      fb
                                                          .collection(
                                                              "PhotosCategories")
                                                          .doc(data)
                                                          .delete()
                                                          .then((_) {
                                                        print("success!");
                                                      });
                                                      setState(() {
                                                        getProducts();
                                                      });
                                                    });
                                                    //Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ));
                              } else {
                                return Container();
                              }
                            },
                          )
                        ],
                      ),
                    ))),
              ),
            ]),
          )));
  }
}
