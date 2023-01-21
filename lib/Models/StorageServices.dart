
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:comp/Models/Database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;



class Storage {
  final db = DatabaseServices();


  List<String> listUrls = [];
  final firebase_storage.FirebaseStorage storage = firebase_storage
      .FirebaseStorage.instance;
  firebase_storage.Reference? ref;
  double val = 0;

  Future<void> deletePhoto(String photoId, String folder) async {
    final storageReference = storage.ref().child('$folder/$photoId');
    await storageReference.delete();
  }
//========================================Customer=============================================================
  Future<void> uploadFile(File file, String fileName, String id) async {
    try {
      await storage.ref('customers/$fileName' + ".jpg").putFile(file).then(
          await(taskSnapshot) {
            print("task done");

// download url when it is uploaded
            if (taskSnapshot.state == firebase_storage.TaskState.success) {
              firebase_storage.FirebaseStorage.instance.ref(
                  'customers/$fileName' + ".jpg")
                  .getDownloadURL()
                  .then((url) {
                // url;
                db.updateCategoryImage(url, id);
                print("Here is the URL of Image $url");
                return url;
              }).catchError((onError) {
                print("Got Error $onError");
              });
            }
          });
    }
    on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

//=============================================Photos=====================================================
  Future<void> uploadImage(File image,String Name,String id,BuildContext context) async {

    Uint8List imageData = await XFile(image.path).readAsBytes();
    final uploadTask =
    storage.ref('Photos/$Name' + ".jpg").putData(imageData);
    uploadTask.snapshotEvents.listen((event) async {
      switch (event.state) {
        case TaskState.running:
        // final progress = 100.0 * (event.bytesTransferred / event.totalBytes);
          break;
        case TaskState.paused:
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          break;
        case TaskState.success:
          String downloadUrl =
          await storage.ref('Photos/$Name' + ".jpg").getDownloadURL();
          db.updatePhotoImage(downloadUrl, id).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Photo Save")));
          });
          break;
      }});
    }
//==============================================Categories================================================
//   Future<void> uploadCategoryImage(File file,String fileName, String id) async {
//     Uint8List imageData = await XFile(file.path).readAsBytes();
//
//     try {
//        print(storage.ref('Categories/$fileName' + ".jpg").putFile(file));
//       await storage.ref('Categories/$fileName' + ".jpg").putData(imageData).then(
//           await(taskSnapshot) {
//             print("task done");
//
//              // download url when it is uploaded
//             if (taskSnapshot.state == firebase_storage.TaskState.success) {
//               firebase_storage.FirebaseStorage.instance.ref(
//                   'Categories/$fileName' + ".jpg")
//                   .getDownloadURL()
//                   .then((url) {
//                 // url;
//                 db.updateCatImage(url, id);
//                 print("Here is the URL of Image $url");
//                 return url;
//               }).catchError((onError) {
//                 print("Got Error $onError");
//               });
//             }
//           });
//     }
//     on firebase_core.FirebaseException catch (e) {
//       print(e);
//     }
//   }

  uploadCategoryImage(File file, String id,BuildContext context,
      void Function(double) updateProgress, void Function() closePage) async {
    Uint8List imageData = await XFile(file.path).readAsBytes();
    String fileName =file!
        .path
        .split('/')
        .last;
    final uploadTask =
    storage.ref('Categories/$fileName' + ".jpg").putData(imageData);
    uploadTask.snapshotEvents.listen((event) async {
      switch (event.state) {
        case TaskState.running:
          final progress = 100.0 * (event.bytesTransferred / event.totalBytes);
          updateProgress(progress);
          break;
        case TaskState.paused:
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          break;
        case TaskState.success:
          String downloadUrl =
          await storage.ref('Categories/$fileName' + ".jpg").getDownloadURL();
          db.updateCatImage(downloadUrl, id).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Category created")));
            closePage();
          });
          break;
      }
    });
  }

  //===========================================Photos=====================================================
String imagesURL(List<XFile> _images,String id) {

  _images.forEach((_image) async {
    List<String>? imagesURLS;
    final File? file = File(_image!.path);
    Uint8List imageData = await XFile(_image.path).readAsBytes();
    try {
      String fileName = file!
          .path
          .split('/')
          .last;

      storage.ref('Photos/$fileName' + 'jpg').putData(imageData).then(
              (taskSnapshot) async {
// download url when it is uploaded
            if (taskSnapshot.state == firebase_storage.TaskState.success) {
              await storage.ref(
                  'Photos/$fileName' + 'jpg')
                  .getDownloadURL()
                  .then((url) {
                  db.AddArray(url,id);
                print("Here is the URL of Image $url");
                return url;

              }).catchError((onError) {
                print("Got Error $onError");
              });
            }
          });
    }
    on firebase_core.FirebaseException catch (e) {
      print("hello$e");

    }
  });
  return '';
}
uploadPhotoImage(File file, String id,BuildContext context,
      void Function(double) updateProgress, void Function() closePage) async {
    Uint8List imageData = await XFile(file.path).readAsBytes();
    String fileName =file!
        .path
        .split('/')
        .last;
    final uploadTask =
    storage.ref('Photos/$fileName' + ".jpg").putData(imageData);
    uploadTask.snapshotEvents.listen((event) async {
      switch (event.state) {
        case TaskState.running:
          final progress = 100.0 * (event.bytesTransferred / event.totalBytes);
          updateProgress(progress);
          break;
        case TaskState.paused:
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          break;
        case TaskState.success:
          String downloadUrl =
          await storage.ref('Photos/$fileName' + ".jpg").getDownloadURL();
          db.updateCatImage(downloadUrl, id).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Photo Save")));
            closePage();
          });
          break;
      }
    });
  }
}