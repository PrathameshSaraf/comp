
import 'package:comp/widgets/category.dart';
import 'package:flutter/material.dart';

import '../Models/Database.dart';
import '../widgets/AppBar.dart';
import 'History.dart';
import 'ProductScreen.dart';


class CategoriesData extends StatefulWidget {
  //const CategoriesData({Key? key}) : super(key: key);
String data,mobile;
CategoriesData({required this.data,required this.mobile});

  @override
  State<CategoriesData> createState() => _CategoriesDataState();
}

class _CategoriesDataState extends State<CategoriesData> {
void _fetchData(BuildContext context) async {
  // show the loading dialog
  showDialog(
    // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                // Some text
                Text('Loading...')
              ],
            ),
          ),
        );
      });

  // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
  await Future.delayed(const Duration(seconds: 10));

  // Close the dialog programmatically
  //Navigator.of(context).pushNamed(HistoryScreen.routeName);
}
final db = DatabaseServices();
List<dynamic> products = [];

@override
void initState() {
  getProducts();

  // TODO: implement initState
  super.initState();
}

getProducts() async {
  final value = await db.getCategoryGender(widget.data=="Female"?"Male":"Female");
  products = value;
  print(widget.data);
  print(products);
  print(products.elementAt(0)['title']);
  setState(() {});
}

  //static const routeName = '/CategoriesData';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppbarSample().getAppBar('CUNSULTATION PRO'),
        body:  SafeArea(
            child: SingleChildScrollView(
            child:Padding(

                    padding: EdgeInsets.symmetric(horizontal: 90,vertical:30),
                    child: Column(children: <Widget>[
                     Column(
                  children: [
                    GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                             crossAxisSpacing: 12.0,
                            // mainAxisSpacing: 10.0
                        ),
                        itemBuilder:
                            (BuildContext context, int index) {

                          return InkWell(
                              onTap: () {},
                              child: Category(onTap: ()=>{
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) =>ProductScreen(Gender: widget.data,mobile: widget.mobile,)
                              ))
                              }, title:products.elementAt(index)['title'], ImageUrl:products.elementAt(index)['ImagePath'],Gender:products.elementAt(index)['Gender'], ),

                          ); }),
                    // Category(onTap: ()=>{
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>ProductScreen(Gender: widget.data)
                    //       ))
                    // }, title: 'HAIRCUTS', ImageUrl:widget.data=='Male'?"assets/images/male.jpg":"assets/images/rashmika.jpg" ),
                    // SizedBox(
                    //         height: 40,
                    //       ),
                    // Category(onTap: ()=>{
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>ProductScreen(Gender: widget.data)
                    //       ))
                    // },title: "HAIR COLOR", ImageUrl:widget.data=='Male'?"assets/images/maleColor.png":"assets/images/girlsColor.jpg"),
                    SizedBox(
                            height: 40,
                          ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                          onTap: (){
                            Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>CustomerHistory(),
                                      ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child:Stack(

                                children: [
                                  Positioned(
                                    child:Image.asset(
                                      "assets/images/beep.png",
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
                                      child: Text(
                                        "History",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),)
                      ),
                    )

                    ]
                      )


                    ]
      )
        )

      ),
    )
    );
  }
}
