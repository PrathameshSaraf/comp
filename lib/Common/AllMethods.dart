import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
class allMethods{

  void fetchData(BuildContext context,Widget Nav) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            // backgroundColor: Colors.white,
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
    await Future.delayed(const Duration(seconds: 5));
    // Close the dialog programmatically
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Nav));
  }


  InputDecoration getInputDecoration() {
    return InputDecoration(

      focusedBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.blue, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.black, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.red, width: 1.5),
      ),
      border: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.black, width: 1.5),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.black, width: 1.5),
      ),
    );
  }

  // final snackBar = SnackBar(
  //   /// need to set following properties for best effect of awesome_snackbar_content
  //
  //   elevation: 0,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: 'Error!',
  //     color: Colors.orange,
  //     message:
  //     'This is an example error message!',
  //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
  //     contentType: ContentType.help,
  //   ),
  //


    static GetSnackBar SuccessSnackBar(
      {String title = 'Success', String message="hello", SnackPosition snackPosition = SnackPosition.BOTTOM}) {

    return GetSnackBar(
      titleText: Text(title.tr,
          style: TextStyle(color: Get.theme.primaryColor)),
      messageText: Text("helod", style: TextStyle(color: Get.theme.primaryColor)),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon: Icon(Icons.check_circle_outline,
          size: 32, color: Get.theme.primaryColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 5),
    );
  }
  // );

  SnackBar() {
    return MaterialBanner(

      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: 'Oh Hey!!',
        message:
        'This is an example error message that will be shown in the body of materialBanner!',
        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
        // to configure for material banner
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );
  }
}