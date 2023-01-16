import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Models/Database.dart';
import '../widgets/AddUpdateCategories.dart';
import 'ClientPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _formKey = GlobalKey<FormState>();
  final db = DatabaseServices();

  bool _isloading = true;
  List<dynamic> products = [];
  List<dynamic> pro = [];

  @override
  void initState() {
    getProducts();
    getPR();
    // TODO: implement initState
    super.initState();
  }

  getProducts() async {
    final value = await db.getCategoriesData(context);
    products = value;

    setState(() {});
  }
  getPR()async{
    FirebaseFirestore.instance.collection("Categories").get().then((value){
      for(int i=0;i<value.docs.length;i++){
        pro.add(value.docs[i]["Categories"]);}
      ;
    print(pro);}
    );}

  @override
  Widget build(BuildContext context) {


    if (products.length > 0) {
      setState(() {
        _isloading = false;
      });
    }

    return _isloading
        ? Container(
      // color: Colors.white,
        child: Expanded(
          // Expanded_A
            child: Container(
              // color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ))))
        :
    Expanded(
        // Expanded_A
        child: Container(
            child: Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Row(
            // alignment: Alignment.topLeft,
            children: [
              Text(
                "Categories",
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
                                                AddEditCategoryScreen(),
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
                                child: ExTExpample(products:products,pro: pro,),
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
                                            crossAxisCount: 5,
                                            crossAxisSpacing: 12.0,
                                            mainAxisSpacing: 10.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {

                                      return InkWell(
                                          onTap: () {},
                                          child: CategoryWidgets(index:index ,ImagePath:products.elementAt(index).ImagePath,title:products.elementAt(index).title,Gender:products.elementAt(index).Gender ,));
                                    }),
                              ]))))))
    ])));
  }
}

class CategoryWidgets extends StatelessWidget {
  //const CategoryWidgets({Key? key}) : super(key: key);
  String title,ImagePath,Gender;int index;

  CategoryWidgets({required this.index,required this.ImagePath,required this.title,required this.Gender});


  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          Positioned(
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              imageUrl: ImagePath,
            //  products[index]["ImagePath"],
              height: 180.0,
              width: 220,
              fit: BoxFit.fitWidth,
            ),
          ),


          Container(
            child: Positioned(

              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child:Row(
                 children: [
                   Text(title,style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 16,
                     color: Colors.black
                   ),),
                   SizedBox(width: 10,),
                   Gender=='Male'?Icon(Icons.man):Gender=="Female"? Icon(Icons.woman_sharp):Icon(Icons.people)
    ],
    )

              ),
            ),
          ),

          // icon != null || imageIcon != null
          //     ? Positioned(
          //   top: 0,
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: const Color(0x96FF0B0B),
          //         borderRadius: BorderRadius.circular(100.0),
          //       ),
          //       padding: const EdgeInsets.all(18.0),
          //       child: imageIcon != null
          //           ? Image.asset(
          //         imageIcon!,
          //         width: 50.0,
          //         height: 50.0,
          //       )
          //           : Icon(
          //         icon,
          //         size: 50.0,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // )
          //     : const SizedBox(),
        ],
      ),
    );
  }
}
