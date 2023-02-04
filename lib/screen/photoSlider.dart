

import 'package:flutter/material.dart';

import '../Models/Database.dart';

class PhotoSlider extends StatefulWidget {
  const PhotoSlider({Key? key}) : super(key: key);

  @override
  State<PhotoSlider> createState() => _PhotoSliderState();
}

class _PhotoSliderState extends State<PhotoSlider> {
  List<dynamic> products = [];
  final db = DatabaseServices();
  bool _isloading = true;

  @override
  void initState() {
    getProducts();
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }
  getProducts() async {
    final value = await db.getMData();
    products = value;
    setState(() {});
  }
  int? activePage;
  late PageController _pageController;
  @override
  Widget build(BuildContext context) {

    if (products.length > 0) {
      setState(() {
        _isloading = false;
      });
    }

    // return _isloading
    //     ? Container(
    //   // color: Colors.white,
    //     child: Expanded(
    //       // Expanded_A
    //         child: Container(
    //           // color: Colors.white,
    //             child: Center(
    //               child: CircularProgressIndicator(),
    //             ))))
    //     :
    return SizedBox(


      child: PageView.builder(

          itemCount: products.length,
          pageSnapping: true,
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              activePage = page;
            });
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, pagePosition) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image.network(products[pagePosition]['Imagepath'], ),
                ),

                SizedBox(
                  height: 10,
                ),Container(
                    child: TextButton(onPressed: (){}, child: Text("See Datails"),),color: Colors.orange,
                )
              ],
            );
          }),
    );
  }
}
