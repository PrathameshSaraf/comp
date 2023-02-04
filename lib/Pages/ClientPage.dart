
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import '../Admin/Dashbord.dart';
import '../Models/AllMethods.dart';
import '../Models/Clients.dart';
import '../Models/Database.dart';
import '../screen/Signup.dart';
import 'package:file_picker/file_picker.dart';
class ClientPage extends StatefulWidget {

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  TextEditingController controller = TextEditingController();

  final db = DatabaseServices();
  final all=allMethods();
  List<String> IDS = [];
  bool _isloading=true;
  int i=0;
  PlatformFile? objFile;
  bool sort = true;
  List<Client>? filterData;
  List<Client> products=[];
  final fb = FirebaseFirestore.instance;
  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
        print(objFile!.extension);
      });
    }
  }

  getg() async{

    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );
    if (pickedFile != null) {
      var bytes = pickedFile.files.single.bytes;
      var excel = Excel.decodeBytes(bytes!);
      final sheet = excel.tables.values.first;
      final headers = sheet.rows.first.map((cell) => cell!.value).toList();
      print(headers);
      final data = sheet.rows.skip(1).map((row) {
        final values = row.map((cell) => cell!.value).toList();
        return Map.fromIterables(headers, values);
      }).toList();
       data.map((e) => e.map((k, v) => MapEntry(k.toString(), v))).forEach((map)async {
             String id=map['id'].toString();
             String fname=map['fname'].toString();
             String lname=map['lname'].toString();
             String mobile=map['mobile'].toString();
             String location=map['location'].toString();
             String pass=map['pass'].toString();
             String username=map['username'].toString();
             String branch=map['branch'].toString();
             String level=map['level'].toString();


      await db.addClient(id, int.parse(mobile), fname, lname, pass, username, context, location, branch, level);

       });


    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>Dashbord(val: 3,)
        ));
      }


  @override
  void initState() {
    getProducts();

    // TODO: implement initState
    super.initState();
  }



  getProducts()async {
    final val= await db.getClientData();
     products=val;
    filterData=products;
    setState(() {
    });
  }
  delete(List<String> IDS)async{
    for (var data in IDS) {
      fb.collection("Clients").doc(data).delete().then((_) {
        print("success!");
      });
    }
  }

  onSelectedRow(bool selected, var product) async {
    setState(() {
      if (IDS.contains(product)) {
        IDS.remove(product); // unselect
      } else {
        IDS.add( product); // select
      }
      //selected==true?IDS.add(product):IDS.remove(product);
      print(IDS);
    });

  }

  onsortColum(int columnIndex, bool ascending) {

    if (columnIndex == 0) {
      if (ascending) {
        products!.sort((a, b) => a.fname!.compareTo(b.fname!));
      } else {
        products!.sort((a, b) => b.fname!.compareTo(a.fname!));
      }
    }
    if (columnIndex == 1) {
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
                          "Clients ",style: TextStyle(
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
                                  width: 290,
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Material(
                                          color: Colors.orange, // Button color
                                          child: InkWell(
                                            splashColor: Colors.red, // Splash color
                                            onTap: () {
                                              db.getCsv();
                                            },
                                            child: SizedBox(width: 56, height: 56, child: Icon(Icons.download)),
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
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: const Text("Browse Data"),
                                                  content: Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            showDialog(

                                                              context: context,
                                                              builder: (ctx) => AlertDialog(
                                                                content: SignupPage(),
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(10.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: const [
                                                                Icon(Icons.add_box_outlined),
                                                                SizedBox(
                                                                  height: 10.0,
                                                                ),
                                                                Text("Add Manually"),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            //chooseFileUsingFilePicker();
                                                            getg();
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(10.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: const [
                                                                Icon(Icons.file_copy_outlined),
                                                                SizedBox(
                                                                  height: 10.0,
                                                                ),
                                                                Text("Excel Or CSV"),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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
                                              all.fetchData(context,Dashbord(val: 3));
                                              }
                                              else{
                                              showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                              return alert;
                                              },
                                              );}},
                                            child: SizedBox(width: 56, height: 56, child: Icon(Icons.delete)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),

                      ]
                  ),
                ),Padding(
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
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(

                                sortAscending: sort,
                                sortColumnIndex: 0,

                               // columnSpacing: width>1472?50:width>1380?40:width>1300?30:width>1280?20:10,
                                columns: [

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
                                        onsortColum(1, ascending);
                                      }),
                                  const DataColumn(
                                    label: Text(
                                      "Phone Number",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 14),
                                    ),
                                  ),
                                  const DataColumn(
                                    label: Text(
                                      "Username (Gmail)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 14),
                                    ),
                                  ),
                                  const DataColumn(
                                    label: Text(
                                      "Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 14),
                                    ),
                                  ),
                                  const DataColumn(
                                    label: Text(
                                      "location",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 14),
                                    ),
                                  ),
                                  const DataColumn(
                                    label: Text(
                                      "branch",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 14),
                                    ),
                                  ),
                                  const DataColumn(
                                    label: Text(
                                      "level",
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


                                        DataCell(Text(product.fname)),
                                        DataCell(Text(product.lname)),
                                        DataCell(Text(product.mobile.toString())),
                                        DataCell(Text(product.username)),
                                        DataCell(Text(product.pass)),
                                        DataCell(Text(product.location)),
                                        DataCell(Text(product.branch)),
                                        DataCell(Text(product.level)),
                                        DataCell(Icon(Icons.edit)),
                                        DataCell(IconButton(icon: Icon(Icons.delete), onPressed: () {},)),
                                      ],
                                      ),
                                )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),

                  ),
                ),
              ]),
            )));
  }
}


class ExTExpample extends StatefulWidget {
  List<dynamic> products=[];List<dynamic>? pro = [];

  ExTExpample({required this.products,this.pro});

  @override
  State<ExTExpample> createState() => _ExTExpampleState();
}

class _ExTExpampleState extends State<ExTExpample> {
  // you can use map or model class or bot
  List<String> filter_data = [];
  List<String> brands = ["Apple", "SamSung"];
  List<String> os = ["iOS", "Android"];
  var value = false;

  _showFilter() async {
    await showDialog(
      context: context,
      builder: (c) {
       return AlertDialog(
          title: Text("My Alert Dialog"),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(widget.products[index].title),
                  initiallyExpanded: () {
                    // you can do different aproach
                    for (final f in widget.pro![index]) {
                      if (filter_data.contains(f)) return true;
                    }
                    return false;
                  }(),
                  children: <Widget>[
                      ...widget.pro![index].map(
                            (brandName) => CheckboxListTile(
                          value: filter_data.contains(brandName),
                          selected: value,
                          title: Text(brandName),
                          onChanged: (v) {
                            value = v ?? false;
                            if (filter_data.contains(brandName)) {
                              filter_data.remove(brandName);
                            } else {
                              filter_data.add(brandName);
                            }
                            setState(() {
                              print(filter_data.contains(brandName));
                            });
                            //you need to reflect the main ui, also call `setState((){})`
                          },
                        ),
                      ),
                    ],
                    //  Text(widget.pro![index].toString())

                );
              },
            ),
          ),
        );}
        // you can replace [AlertDialog]
        // return AlertDialog(
        //   content: StatefulBuilder(
        //     builder: (context, setSBState) => SingleChildScrollView(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Text("Filter Data"),
        //           SizedBox(height: 10,),
        //
        //           ExpansionTile(
        //             title:  Text(widget.products[2].title),
        //
        //             /// check any of its's item is checked or not
        //             initiallyExpanded: () {
        //               // you can do different aproach
        //               for (final f in widget.pro![2]) {
        //                 if (filter_data.contains(f)) return true;
        //               }
        //               return false;
        //             }(),
        //             children: [
        //               ...widget.pro![2].map(
        //                     (brandName) => CheckboxListTile(
        //                   value: filter_data.contains(brandName),
        //                   title: Text(brandName),
        //                   onChanged: (v) {
        //                     if (filter_data.contains(brandName)) {
        //                       filter_data.remove(brandName);
        //                     } else {
        //                       filter_data.add(brandName);
        //                     }
        //
        //                     setSBState(() {
        //
        //                     });
        //                     //you need to reflect the main ui, also call `setState((){})`
        //                   },
        //                 ),
        //               ),
        //             ],
        //           ),
        //           // ExpansionTile(
        //           //   title: const Text("select OS"),
        //           //
        //           //   /// check any of its's item is checked or not
        //           //   initiallyExpanded: () {
        //           //     // you can do different aproach
        //           //     for (final f in os) {
        //           //       if (filter_data.contains(f)) return true;
        //           //     }
        //           //     return false;
        //           //   }(),
        //           //   children: [
        //           //     ...os.map(
        //           //           (osName) => CheckboxListTile(
        //           //         value: filter_data.contains(osName),
        //           //         title: Text(osName),
        //           //         onChanged: (v) {
        //           //           if (filter_data.contains(osName)) {
        //           //             filter_data.remove(osName);
        //           //           } else {
        //           //             filter_data.add(osName);
        //           //           }
        //           //
        //           //           setSBState(() {});
        //           //           //you may need to reflect the main ui, also call `setState((){})`
        //           //         },
        //           //       ),
        //           //     ),
        //           //   ],
        //           // ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );

    );
  }

  @override
  Widget build(BuildContext context) {
    return   Center(
        child: InkWell(
          splashColor: Colors.red, // Splash color
          onTap: () {
            _showFilter();
          },
          child: SizedBox(width: 56, height: 56, child: Icon(Icons.filter_alt_sharp)),
        ),
    ) ;
  }
}

class EntryItem extends StatefulWidget {
  int index;
  List<dynamic>?products,pro;
  EntryItem({required this.products,this.pro,required this.index});

  @override
  State<EntryItem> createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {

  List<String> filter_data = [];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title:  Text(widget.products![widget.index].title),

      /// check any of its's item is checked or not
      initiallyExpanded: () {
        // you can do different aproach
        for (final f in widget.pro![widget.index]) {
          if (filter_data.contains(f)) return true;
        }
        return false;
      }(),
      children: [
        ...widget.pro![widget.index].map(
              (brandName) => CheckboxListTile(
            value: filter_data.contains(brandName),
            title: Text(brandName),
            onChanged: (v) {
              if (filter_data.contains(brandName)) {
                filter_data.remove(brandName);
              } else {
                filter_data.add(brandName);
              }

              setState(() {

              });
              //you need to reflect the main ui, also call `setState((){})`
            },
          ),
        ),
      ],
    );
  }
}
