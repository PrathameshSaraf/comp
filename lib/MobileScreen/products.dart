import 'package:flutter/material.dart';
import 'ABPhtoclick.dart';
import '../services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../widgets/AppBar.dart';
import 'PhotoDiscription.dart';

class Product extends StatefulWidget {
  bool value;
  String Gender,mobile;
  Product({required this.value, required this.Gender,required this.mobile});
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final db = DatabaseServices();
  final fb = FirebaseFirestore.instance;
  bool _isloading = true;
  List<dynamic> products = [];
  int? activePage;
  PageController? _pageController;
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

  @override
  Widget build(BuildContext context) {
    if (products.length > 0) {
      setState(() {
        _isloading = false;
      });
    }
    //
    return  Scaffold(
        appBar: AppbarSample().getAppBar('CUNSULTATION PRO'),
    body: _isloading ? const Center(
    child: CircularProgressIndicator(),
    ): SafeArea(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
            Padding(
             padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length, //images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0),
                itemBuilder: (BuildContext context, int index) {
                  if (products != null && products.length > index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageView.builder(
                                      itemCount: products.length,
                                      pageSnapping: true,
                                      controller: _pageController,
                                      onPageChanged: (page) {
                                        setState(() {
                                          activePage = page;
                                        });
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, pagePosition) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Image.network(
                                                      products[pagePosition]
                                                          ['Imagepath']),
                                                ),
                                                Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 30,
                                                        vertical: 20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all(Colors.orange),
                                                          ),
                                                          child: Text(
                                                              'See Description'),
                                                          onPressed: () {
                                                            // button 1 action
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PhotoDiscription(
                                                                    name: products
                                                                        .elementAt(
                                                                            index!)['name'],
                                                                    id: products
                                                                        .elementAt(
                                                                            index!)['id'],
                                                                    Categories:
                                                                        products
                                                                            .elementAt(index!)['Categories'],
                                                                    Imagepath: products
                                                                        .elementAt(
                                                                            index!)['Imagepath'],
                                                                    summary: products
                                                                        .elementAt(
                                                                            index!)['summary'],
                                                                    LongDes1: products
                                                                        .elementAt(
                                                                            index!)['LongDes1'],
                                                                    AdditionalPhotos:
                                                                        products
                                                                            .elementAt(index!)['AdditionalPhotos'],
                                                                  ),
                                                                ));
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty.all(Colors.orange),
                                                            ),
                                                          child:
                                                              Text('Proceed'),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                builder:
                                                                (context) =>ABPhtoclick(Time:"Before",mobile: widget.mobile,)));}
                                               ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })));
                        },
                        child:
                           Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(16.0),
                               border: Border.all(color: Colors.black, width: 1.2,),
                             ),
                             child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                                   child: Image.network(
                                     products.elementAt(index!)['Imagepath'],
                                     height: 200.0,
                                     width: 170,
                                     fit: BoxFit.cover,    ),
                                ),
                           ),
                        );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ))]))));
  }
}
