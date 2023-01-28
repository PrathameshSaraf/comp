
import 'package:flutter/material.dart';
import '../widgets/AppBar.dart';
import '../widgets/Button.dart';
import '../widgets/products.dart';
class ProductScreen extends StatefulWidget {
  // const ProductScreen ({Key? key}) : super(key: key);
  static const routeName = '/Product';
  String Gender,mobile;
  ProductScreen({required this.Gender,required this.mobile});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _ProductScreenState extends State<ProductScreen> {

  bool check2 = false;
  bool check1 = false;
  bool check3 = false;
  bool _isLoading=true;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _isLoading=false;
    });


    return Scaffold(
        appBar: AppbarSample().getAppBar('CUNSULTATION PRO'),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(children: <Widget>[

                      SizedBox(
                        height: 30,
                      ),
                      // ButtonW100(
                      //     text: 'filter',
                      //     onTap: () {
                      //       showModalBottomSheet(
                      //           context: context,
                      //           isScrollControlled: true,
                      //           builder: (BuildContext context) {
                      //             return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
                      //             return   Column
                      //                   (children: <Widget>[
                      //               SizedBox(
                      //                 height: 40,
                      //               ),
                      //               AppBar(
                      //                 leading: Icon(Icons.filter_alt),
                      //                 title: Text('Filter'),
                      //                 automaticallyImplyLeading: false,
                      //               ),
                      //               SizedBox(
                      //                 height: 40,
                      //               ),
                      //                   Column(
                      //                     children: [
                      //                       Text(
                      //                         "Hair Color",
                      //                         textAlign: TextAlign.left,
                      //                         style: TextStyle(
                      //                           fontSize: 16,
                      //                           fontWeight: FontWeight.bold,
                      //                         ),
                      //                       ),
                      //                       CheckboxListTile(
                      //                         //checkbox positioned at right
                      //                         controlAffinity:
                      //                             ListTileControlAffinity
                      //                                 .leading,
                      //
                      //
                      //                         value: check1,
                      //                         onChanged: (bool? value) {
                      //                           mystate(() {
                      //                             check1 = value!;
                      //                           });
                      //                         },
                      //                         title: Text("Red"),
                      //                       ),
                      //                       CheckboxListTile(
                      //                         //checkbox positioned at right
                      //                         controlAffinity:
                      //                             ListTileControlAffinity
                      //                                 .leading,
                      //                         value: check2,
                      //                         onChanged: (bool? value) {
                      //                           mystate(() {
                      //                             check2 = value!;
                      //                           });
                      //                         },
                      //                         title: Text("Blue"),
                      //                       ),
                      //                       CheckboxListTile(
                      //                         //checkbox positioned at right
                      //                         controlAffinity:
                      //                             ListTileControlAffinity
                      //                                 .leading,
                      //                         value: check3,
                      //                         onChanged: (bool? value) {
                      //                           mystate(() {
                      //                             check3 = value!;
                      //                           });
                      //                         },
                      //                         title: Text("Black"),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   Column(
                      //                     children: [
                      //                       Text(
                      //                         "Hair Style",
                      //                         textAlign: TextAlign.left,
                      //                         style: TextStyle(
                      //                           fontSize: 15,
                      //                           fontWeight: FontWeight.bold,
                      //                         ),
                      //                       ),
                      //                       CheckboxListTile(
                      //                         //checkbox positioned at right
                      //                         controlAffinity:
                      //                             ListTileControlAffinity
                      //                                 .leading,
                      //                         value: check1,
                      //                         onChanged: (bool? value) {
                      //                           mystate(() {
                      //                             check1 = value!;
                      //                           });
                      //                         },
                      //                         title: Text("bob"),
                      //                       ),
                      //                       CheckboxListTile(
                      //                         //checkbox positioned at right
                      //                         controlAffinity:
                      //                             ListTileControlAffinity
                      //                                 .leading,
                      //                         value: check2,
                      //                         onChanged: (bool? value) {
                      //                           mystate(() {
                      //                             check2 = value!;
                      //                           });
                      //                         },
                      //                         title: Text("braids"),
                      //                       ),
                      //                       CheckboxListTile(
                      //                         //checkbox positioned at right
                      //                         controlAffinity:
                      //                             ListTileControlAffinity
                      //                                 .leading,
                      //                         value: check3,
                      //                         onChanged: (bool? value) {
                      //                           mystate(() {
                      //                             check3 = value!;
                      //                           });
                      //                         },
                      //                         title: Text("bun"),
                      //                       ),
                      //                     ],
                      //                   ),
                      //
                      //                   Column(
                      //                     children: [
                      //                       Text(
                      //                         "Hair Types",
                      //                         textAlign: TextAlign.left,
                      //                         style: TextStyle(
                      //                           fontSize: 15,
                      //                           fontWeight: FontWeight.bold,
                      //                         ),
                      //                       ),
                      //                       CheckboxListTile(
                      //                         //checkbox positioned at right
                      //                         controlAffinity:
                      //                             ListTileControlAffinity
                      //                                 .leading,
                      //                         value: check1,
                      //                         onChanged: (bool? value) {
                      //                           mystate(() {
                      //                             check1 = value!;
                      //                           });
                      //                         },
                      //                         title: Text("Long"),
                      //                       ),
                      //                       CheckboxListTile(
                      //                         //checkbox positioned at right
                      //                         controlAffinity:
                      //                             ListTileControlAffinity
                      //                                 .leading,
                      //                         value: check2,
                      //                         onChanged: (bool? value) {
                      //                           mystate(() {
                      //                             check2 = value!;
                      //                           });
                      //                         },
                      //                         title: Text("Short"),
                      //                       ),
                      //                       CheckboxListTile(
                      //                         //checkbox positioned at right
                      //                         controlAffinity:
                      //                             ListTileControlAffinity
                      //                                 .leading,
                      //                         value: check3,
                      //                         onChanged: (bool? value) {
                      //                           mystate(() {
                      //                             if(check3==false){
                      //                               check3=true;
                      //                             }else{
                      //                               check3=false;
                      //                             }
                      //
                      //                           });
                      //                         },
                      //                         title: Text("stepcut"),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   Padding(
                      //                       padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                      //             child:Row(
                      //
                      //                     children: [
                      //                       ElevatedButton(
                      //                         onPressed: () => {},
                      //                         child: Text('Apply'),
                      //                         style: ElevatedButton.styleFrom(
                      //                           primary: Colors.lightGreen,
                      //                         ),
                      //                       ),
                      //                       SizedBox(width: 50),
                      //                       TextButton(
                      //                         onPressed: () => {},
                      //                         child: Text('Reset'),
                      //                         style: ElevatedButton.styleFrom(
                      //                           primary: Colors.red,
                      //                         ),
                      //                       )
                      //                    ],
                      //
                      //                   ))
                      //             ],
                      //
                      //             );
                      //           }
                      //           );
                      //
                      //     });}
                      //     ),
                      SizedBox(
                        height: 30,
                      ),
                      Product(value: false,Gender: widget.Gender,mobile: widget.mobile,),
                    ]
                      ))
                      )));
  }
}
