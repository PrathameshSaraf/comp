import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/Database.dart';
import '../Models/customer.dart';
import 'package:firebase_database/firebase_database.dart';
class CustomerPage extends StatefulWidget {

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  TextEditingController controller = TextEditingController();

  final db = DatabaseServices();
  final fb=FirebaseFirestore.instance;
  List<Customer> products=[];
  bool _isloading=true;
  int i=0;
  bool sort = true;
  List<Customer>? filterData;
  List<String> IDS = [];

  @override
  void initState() {
    getProducts();

    // TODO: implement initState
    super.initState();
  }

  getProducts()async {
    final value=await db.getCustomerData();
    products=value;
    filterData=products;
    setState(() {

    });
  }
  onSelectedRow(bool selected, var product) async {
    setState(() {
      if (IDS.contains(product)) {
        IDS.remove(product); // unselect
      } else {
        IDS.add( product); // select
      }
      //selected==true?IDS.add(product):IDS.remove(product);
      //print(IDS);
    });

  }
  onsortColum(int columnIndex, bool ascending) {

    if (columnIndex == 1) {
      if (ascending) {
        products!.sort((a, b) => a.fname!.compareTo(b.fname!));
      } else {
        products!.sort((a, b) => b.fname!.compareTo(a.fname!));
      }
    }

    if (columnIndex == 2) {
      if (ascending) {
        products!.sort((a, b) => a.lname!.compareTo(b.lname!));
      } else {
        products!.sort((a, b) => b.lname!.compareTo(a.lname!));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if(products.length>0){
      setState(() {
        _isloading=false;
      });
    }

    return _isloading? Container(
        child: Expanded(
          // Expanded_A
          child: Container(
              child:Center(
      child: CircularProgressIndicator(),
    ))
        )):  Container(

          child: Expanded(
              // Expanded_A
              child: Container(

                child: Column(children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                    child: Row(
                     // alignment: Alignment.topLeft,
                      children :[
                        Text(
                        "Customers ",style: TextStyle(
                        fontWeight:FontWeight.bold,
                        fontSize: 40,
                        color: Colors.orange
                      ),
                      ),
                        Icon(Icons.people_alt_outlined,
                          color: Colors.orange,
                          size: 40.0,),

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

                                        },
                                        child: SizedBox(width: 56, height: 56, child: Icon(Icons.filter_alt_sharp)),
                                      ),
                                    ),
                                  ),
                                 SizedBox(width:20),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                    child: Row(
                      // alignment: Alignment.topLeft,
                        children :[
                          Flexible(
                            child: Container(
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: "Enter something to filter",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    filterData = products!
                                        .where((element) =>
                                        element.fname!.contains(value))
                                        .toList();
                                  });
                                },
                              ),
                            ),
                          ),

                        ]
                    ),
                  ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: DataTable(
                  sortAscending: sort,
                  sortColumnIndex: 1,

                  columns: [
                    const DataColumn(
                      label: Text(
                        "Photo",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    DataColumn(
                        label: const Text(
                          "First Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            sort = !sort;
                          });
                          onsortColum(columnIndex, ascending);
                        }),
                    DataColumn(
                        label: const Text(
                          "Last Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            sort = !sort;
                          });
                          onsortColum(columnIndex, ascending);
                        }),
                    const DataColumn(
                      label: Text(
                        "Last Visit Date",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        "Mobile No.",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        "Gender",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        "Edit",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        "Delete",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                    const DataColumn(
                      label: Text(
                        "View",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                  ],
                  rows: filterData!
                      .map(
                        (product) => DataRow(
                      selected: IDS.contains(product.id.toString()),
                      onSelectChanged: (b) {
                        print("Onselect");
                        onSelectedRow(b!, product.id.toString());
                      },
                      cells: [
                        DataCell(ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder: (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            imageUrl:products[i].ImagePath,
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.cover,
                          ),
                        )),
                        DataCell(Text(product.fname)),
                        DataCell(Text(product.lname)),
                        DataCell(Text(product.lastVi.toString())),
                        DataCell(Text(product.phno)),
                        DataCell(Text(product.Gender)),
                        DataCell(Icon(Icons.edit)),
                        DataCell(IconButton(icon:Icon(Icons.delete), onPressed: () {  },)),
                        DataCell(IconButton(icon:Icon(Icons.remove_red_eye,color: Colors.blue,), onPressed: () {
                          showDialog(
                            context: context,

                            builder: (ctx) => AlertDialog(

                              title: const Text("Browse Data"),
                              content: Container(
                                 child: Stack(
                                   children: [
                                     Container(

                                       decoration: BoxDecoration(
                                         color: Colors.orange[50],
                                         borderRadius: BorderRadius.circular(10),
                                       ),
                                       child: Column(
                                         children: [
                                           Text("Name: Saraf dd", style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold)),
                                           Text("Gender: Male", style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold)),
                                           Text("Mobile: 8564789", style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold)),
                                         ],
                                       ),
                                     ),
                                      Flexible(
                                       child: ListView.builder(
                                         itemCount: 4,
                                          itemBuilder: (context, index) {
                                     //       //final record = historyRecords[index];
                                           return Container(
                                     //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                     //         decoration: BoxDecoration(
                                     //           color: Colors.orange[100],
                                     //           borderRadius: BorderRadius.circular(10),
                                     //         ),
                                     //         child: ListTile(
                                     //           title: Text("10-20-2022", style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold)),
                                     //           subtitle: Text("asdfghjmn b yjhnbv  bghn bvfghtnb cfthgb cretgbv cfrtgbv vcftgbv vcfrtgbv vftgb vfthgb vftrgb vfrthgb cfrtrghb cfrtgb v", style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold)),
                                     //         ),
                                          );
                                         },
                                       ),
                                      ),
                                   ],
                                 ),
                                ),
                              ),

                          );
                          },)),
                      ],
                    ),
                  ).toList(),
                ),
              ),

                        ]),
        ),
          ))
                ]),
              )));
  }
}

















