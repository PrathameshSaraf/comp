
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:comp/services/Database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;



class Storage {
  final db = DatabaseServices();
  final _db = FirebaseFirestore.instance;

  List<String> listUrls = [];
  final firebase_storage.FirebaseStorage storage = firebase_storage
      .FirebaseStorage.instance;
  firebase_storage.Reference? ref;
  double val = 0;

  Future<void> deleteImage(String imageUrl, String folder) async {
    final storageReference = storage.refFromURL(imageUrl);
    // Check if the image exists
    var imageExists = await storageReference.getMetadata().then((metadata) => true, onError: (error) => false);
    // If the image exists, delete it
    if (imageExists) {
      await storageReference.delete().then((value) => print("sucess"));
    }
     }
  // Future<void> deletePhoto(String photoId, String folder) async {
  //   final storageReference = storage.ref().child('$folder/$photoId');
  //   await storageReference.delete();
  //   print('sucess');
  // }
//========================================Customer=============================================================
  Future<void> uploadFile(File file, String fileName, String id) async {
    String url1='';
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
                url1 = url;
                db.updateCategoryImage(url, id);
                print("Here is the URL of Image $url");
                return url;
              }).catchError((onError) {
                print("Got Error $onError");
              });
            }
            else{
              return '';
            }
          });
    }
    on firebase_core.FirebaseException catch (e) {
      print(e);
    }

  }

  Future<String> uploadFile1(File file,id,comid) async {
    String fileName =file!
        .path
        .split('/')
        .last;
    String url1='';
    try {
      await storage.ref('customers/$fileName' ).putFile(file).then(
          await(taskSnapshot) {
            print("task done");

// download url when it is uploaded
            if (taskSnapshot.state == firebase_storage.TaskState.success) {
              firebase_storage.FirebaseStorage.instance.ref(
                  'customers/$fileName')
                  .getDownloadURL()
                  .then((url) {
                url1 = url;
                try {
                  print("Here is the URL of Image $url");
                  _db.collection("custmer").doc(comid).collection(comid).doc(id).update({'Bimage':url});
                } catch (e) {
                  print(e);
                }
                return url;
              }).catchError((onError) {
                print("Got Error $onError");
              });
            }
            else{
              return '';
            }
          });
    }
    on firebase_core.FirebaseException catch (e) {
      print(e);
    }
    return url1;
  }
  Future<String> uploadFile2(File file,id,comid) async {
    String fileName =file!
        .path
        .split('/')
        .last;
    String url1='';
    try {
      await storage.ref('customers/$fileName').putFile(file).then(
          await(taskSnapshot) {
            print("task done");

// download url when it is uploaded
            if (taskSnapshot.state == firebase_storage.TaskState.success) {
              firebase_storage.FirebaseStorage.instance.ref(
                  'customers/$fileName')
                  .getDownloadURL()
                  .then((url) {
                url1 = url;

                try {
                  print("Here is the URL of Image $url");
                  _db.collection("custmer").doc(comid).collection(comid).doc(id).update({'Aimage':url});
                } catch (e) {
                  print(e);
                }
                return url;
              }).catchError((onError) {
                print("Got Error $onError");
              });
            }
            else{
              return '';
            }
          });
    }
    on firebase_core.FirebaseException catch (e) {
      print(e);
    }
    return url1;
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