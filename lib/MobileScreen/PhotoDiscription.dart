import 'package:flutter/material.dart';

import '../services/Database.dart';
import '../widgets/AppBar.dart';

class PhotoDiscription extends StatefulWidget {
  String name, id, Imagepath, summary;
  List<dynamic> Categories, AdditionalPhotos;
  String LongDes1 = '';
  PhotoDiscription(
      {required this.name,
      required this.id,
      required this.Categories,
      required this.AdditionalPhotos,
      required this.Imagepath,
      required this.summary,
      required this.LongDes1});
  @override
  _PhotoDiscriptionState createState() => _PhotoDiscriptionState();
}

class _PhotoDiscriptionState extends State<PhotoDiscription> {
  int? activePage;
  PageController? _pageController;
  String _title = "Image Title";
  String _gender = "Female";
  List<String> _categories = [
    "Nature",
    "Outdoor",
    "Nature",
    "Outdoor",
    "Nature",
    "Outdoor",
    "Nature",
    "Outdoor"
  ];
  String _summary =
      "This is a beautiful image of nature taken during sunset. kjhgfdxc bgftrdc vbhgftcv bhgfcv bnhygtfv bnhygtfgv bnhgyv bhgyfv nbhgfv nbhgfc vbhgtfcv bhgfcv nbhgfcv bhgfv bhgv bhgv bhgvf nbhgv nhbgvb ";
  String _imageURL =
      "https://firebasestorage.googleapis.com/v0/b/comp-fe7ff.appspot.com/o/Photos%2Fsdfbg.jpg?alt=media&token=c9553f34-3f7c-4d73-9c48-26feb7ce29d5";
  List<String> _additionalImages = [
    "https://firebasestorage.googleapis.com/v0/b/comp-fe7ff.appspot.com/o/Photos%2Fsdfbg.jpg?alt=media&token=c9553f34-3f7c-4d73-9c48-26feb7ce29d5",
    "https://firebasestorage.googleapis.com/v0/b/comp-fe7ff.appspot.com/o/Photos%2Fsdfbg.jpg?alt=media&token=c9553f34-3f7c-4d73-9c48-26feb7ce29d5",
    "https://firebasestorage.googleapis.com/v0/b/comp-fe7ff.appspot.com/o/Photos%2Fsdfbg.jpg?alt=media&token=c9553f34-3f7c-4d73-9c48-26feb7ce29d5"
  ];
  List<String> _additionalDescriptions = [
    "Additional image 1 taken ajkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk hjv jkhvg njkhb nmkijuhybnjkihnb mkjhbn mkjhbn mkjhbn mjhbn mkjhbn mkjn t the same location",
    "Additional image 2 taken during  hbnjhbnjhbn jhn jhn mjnb nmjn mjn mjn mjn jnn jn mjnb mjn mkjn mjn n nn the daytime",
    "Additional image 3 taken during the night"
  ];
  final db = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSample().getAppBar('Photo Descriptions'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  image: DecorationImage(
                    image: NetworkImage(widget.Imagepath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Gender : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                    decoration: TextDecoration.none)),
                            TextSpan(
                              text: _gender,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Category : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                    decoration: TextDecoration.none)),
                            TextSpan(
                              text: widget.Categories.join(", "),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'description : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.none)),
                        TextSpan(
                          text: widget.summary,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Additional Photos : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.none)),
                      ],
                    ),
                  )),

              Expanded(
                flex: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),

                        //child:

                        Container(
                            height: 300,
                            child: GridView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  _additionalImages.length, //images.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0),
                              itemBuilder: (BuildContext context, int index) {
                                if (_additionalImages != null &&
                                    _additionalImages.length > index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PageView.builder(
                                                        itemCount:
                                                            _additionalImages
                                                                .length,
                                                        pageSnapping: true,
                                                        controller:
                                                            _pageController,
                                                        onPageChanged: (page) {
                                                          setState(() {
                                                            activePage = page;
                                                          });
                                                        },
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder: (context,
                                                            pagePosition) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Container(
                                                              color:
                                                                  Colors.white,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child: Image
                                                                        .network(
                                                                            _additionalImages[pagePosition]),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        })));
                                      },
                                      child: Container(
                                        height: 400,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                _additionalImages
                                                    .elementAt(index!)),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ));
                                } else {
                                  return Container();
                                }
                              },
                            )
                            //       Card(
                            //         child: ListTile(
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(10.0),
                            //             side: BorderSide(width: 1.5, color: Colors.orange),
                            //           ),
                            //           leading: Image.network(widget.AdditionalPhotos[index]),
                            //           title: Text(_additionalDescriptions[index],textAlign: TextAlign.justify,),
                            //         ),
                            //       );

                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
