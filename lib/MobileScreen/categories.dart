import 'package:comp/MobileScreen/category.dart';
import 'package:flutter/material.dart';
import '../services/Database.dart';
import 'products.dart';
import 'History.dart';
class CategoriesData extends StatefulWidget {
String data,mobile;
CategoriesData({required this.data,required this.mobile});
  @override
  State<CategoriesData> createState() => _CategoriesDataState();
}

class _CategoriesDataState extends State<CategoriesData> {
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
  setState(() {});
}

  //static const routeName = '/CategoriesData';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar:AppBar(
            title: Text('CUNSULTATION PRO'),
            backgroundColor: Colors.orange,
            actions: [
              IconButton(
              icon: Icon(Icons.history,size: 32,),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>CustomerHistory(customerID: widget.mobile,),
                    ));
              },
            ),]
          ) ,
        body:  SafeArea(
            child: SingleChildScrollView(
            child:Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical:10),
                    child:
                     Column(
                  children: [
                    GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products.length,
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:2 ,
                             crossAxisSpacing: 1.0,
                             mainAxisSpacing: 1.0
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                                      onTap: () {},
                                      child: Category(onTap: ()=>{
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) =>Product(Gender: widget.data,mobile: widget.mobile,value: false,)
                                      ))
                                      }, title:products.elementAt(index)['title'], ImageUrl:products.elementAt(index)['ImagePath'],Gender:products.elementAt(index)['Gender'], ),
                                  );

                          //     ],
                          //   ),
                          // )
                           })]
                    )
        )

      ),
    )
    );
  }
}
