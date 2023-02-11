
import 'package:flutter/material.dart';
import '../DashboardPages/AddPhotoPage.dart';
import '../DashboardPages/CategoriesPage.dart';
import '../DashboardPages/ClientPage.dart';
import '../DashboardPages/CustomerPage.dart';
import '../DashboardPages/DashbordPage.dart';
import '../DashboardPages/locationPage.dart';
import '../DashboardPages/settingPage.dart';
import '../widgets/HeaderCards.dart';
import '../widgets/Responsive.dart';
import '../widgets/SideMenu.dart';

class Dashbord extends StatefulWidget {
  int val;
  Dashbord({required this.val});
  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  int currentIndex = 0;

  void changeScreen(int index, bool web, bool homeNav) {
    setState(() {
      currentIndex = index;
      if (!web && !homeNav) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Size _size = MediaQuery.of(context).size;
    bool isWeb = width >= 1000;
    // if (!isWeb && isEditCategory) {
    //   setState(() {
    //     isEditCategory = !isEditCategory;
    //   });
    // }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          elevation: 0.0,
        ),
        drawer: width < 1100
            ? SideMenu(
                web: false,
                changeScreen: changeScreen,
              )
            : null,
        body: SafeArea(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // //We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            Container(
              color: Colors.white,
              width: 280,
              child: SideMenu(
                web: true,
                changeScreen: changeScreen,
              ),
            ),
          widget.val == 1
              ? DashbordPage()
              : widget.val == 2
                  ? CustomerPage()
                  : widget.val == 3
                      ? ClientPage()
                      : widget.val == 4
                          ? AddPhotoPage(
                              Gender: "Male",
                              value: true,
                            )
                          : widget.val == 5
                              ? CategoriesPage()
                              :  widget.val == 6?locationPage():AlertDialog(
              content: Stack(
                children: <Widget>[
                  Positioned(

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
                  SettingsPage()
                ],
              )),
          //            AddPhotoPage(Gender: "Male", value: true)
        ])));
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => HeaderCard(
        info: demoMyFiles[index],
      ),
    );
  }
}
