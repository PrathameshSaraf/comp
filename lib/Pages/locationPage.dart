import 'package:comp/Models/Database.dart';
import 'package:flutter/material.dart';

import '../widgets/AddUpdateLocation.dart';
import '../widgets/category.dart';

class locationPage extends StatefulWidget {
  const locationPage({Key? key}) : super(key: key);

  @override
  State<locationPage> createState() => _locationPageState();
}

class _locationPageState extends State<locationPage> {
  final db = DatabaseServices();

  bool _isloading = true;
  List<dynamic> products = [];

  @override
  void initState() {
    getProducts();

    // TODO: implement initState
    super.initState();
  }

  getProducts() async {
    final value = await db.getLocationData(context);
    products = value;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
  //  print(width);
    return Expanded(
      // Expanded_A
        child: Container(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                  // alignment: Alignment.topLeft,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.orange),
                      ),
                      Icon(
                        Icons.category_outlined,
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
                                                        addLocation(),
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
                                        child: InkWell(
                                          splashColor: Colors.red, // Splash color
                                          onTap: () {

                                          },
                                          child: SizedBox(width: 56, height: 56, child: Icon(Icons.delete)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    ClipOval(
                                      child: Material(
                                        color: Colors.orange, // Button color
                                        child: InkWell(
                                          splashColor: Colors.red, // Splash color
                                          onTap: () {

                                          },
                                          child: SizedBox(width: 56, height: 56, child: Icon(Icons.filter_alt_sharp)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                    ]),
              ),
              Expanded(
                  child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Container(
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        GridView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: products.length,
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: width>1328?4:width>800?3:2,

                                                crossAxisSpacing: 12.0,
                                                mainAxisSpacing: 10.0),
                                            itemBuilder:
                                                (BuildContext context, int index) {

                                              return InkWell(
                                                  onTap: () {},
                                                  child: StylistCard(name: products.elementAt(index).name,id: products.elementAt(index).id,branch: products.elementAt(index).branch,address: products.elementAt(index).address,state: products.elementAt(index).state,city: products.elementAt(index).city,
                                                    contact: products.elementAt(index).contact,location: products.elementAt(index).location,));
                                            }),
                                      ]))))))

            ])));
  }
}

