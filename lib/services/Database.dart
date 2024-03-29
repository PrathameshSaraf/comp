import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp/Models/location.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/Categories.dart';
import '../Models/Clients.dart';
import '../Models/Photos.dart';
import '../Models/customer.dart';
import 'package:firebase_database/firebase_database.dart';
class DatabaseServices {
  final _db = FirebaseFirestore.instance;



//=================================Customer===============================================================
  Future<String> addCostomer(String id, String fName, String lName,
      String Gender, String phno, String image, BuildContext context) async {
    final categoryData = Customer(
        id: id,
        fname: fName,
        lname: lName,
        Gender: Gender,
        phno: phno,
        ImagePath: image,
        lastVi: DateTime.now());
    try {
      DocumentReference ref = await _db
          .collection("custmer")
          .add(categoryData.toMap())
          .catchError((e) {
        print(e);
      });
      await _db.collection("custmer").doc(ref.id).update({"id": ref.id});
      return ref.id;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to update data $e")));
      return "";
    }
  }

  Future<String> addDataForCustomerByMobileNumber(String mobileNumber, Map<String, dynamic> data) async {
    try {
      DocumentReference ref= await _db.collection("custmer").doc(mobileNumber).collection(mobileNumber).add(data);
      return ref.id;
    }catch(e){
      print(e);
    }
    return '';
    }

  Future<List> fetchHistoryData(String mobileNumber) async {
    List dataList = [];

    QuerySnapshot<Object> snapshot = await _db.collection("custmer").doc(mobileNumber).collection(mobileNumber).get();
    print(snapshot.docs);
    for (QueryDocumentSnapshot snap in snapshot.docs) {

      dataList.add(
        {
          "Aimage":snap["Aimage"],
          "Bimage":snap["Bimage"],
          "Date":snap["Date"],
          "Description":snap["Description"],
          "Service":snap["Service"],
        }
      );
    }
    print(dataList);
    return dataList;
  }

  Future<Map<String, dynamic>>  getSingleValueCustomer(String userId) async{
    Map<String, dynamic>? doc;
    CollectionReference ref = FirebaseFirestore.instance.collection('custmer');
    await ref.doc(userId).get().then((DocumentSnapshot documentSnapshot) {

      if (documentSnapshot.exists) {
       doc= documentSnapshot.data() as Map<String, dynamic>;
        print('Document exists on the database');
      }
      else{

      }
    });
    return doc!;
  }

  Future<List> getDataFromMobile(String mobileNumber) async {
    List dataList = [];
    QuerySnapshot snapshots =await _db
        .collection('custmer')
        .where('phno', isEqualTo: mobileNumber)
        .get();
    for (QueryDocumentSnapshot snap in snapshots.docs) {
      dataList.add(Customer(
        Gender: snap["Gender"],
        ImagePath: snap["ImagePath"],
        fname: snap["fname"],
        lname: snap["lname"],
        id: snap['id'],
        phno: snap['phno'],
        lastVi: snap['lastVi'].toDate(),
      ));
    }
    print(dataList);
    return dataList;
  }

  Future<void> UpdateCostomer(String id, String Name, String Gender, String phno, BuildContext context) async {
    int firstSpace = Name.indexOf(" ");
    String firstName = Name.substring(0,firstSpace); // get everything upto the first space character
    String lastName = Name.substring(firstSpace).trim();
    try {
       print(id);
      await _db.collection("custmer").doc(id).update({
        "Gender": Gender,
        "fname": firstName,
        "lname":lastName,
        "phno": phno,
        "lastVi":DateTime.now(),
      });

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to update data $e")));
      return;
    }
  }

  Future<void> updateCategoryImage(String image, String id) {
    // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    //print(id);
    //  print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    return _db.collection("custmer").doc(id).update({
      "ImagePath": image,
    }).then((value) => print("done"));
  }

  // Future<String> addPhoto(String id, String ImageUrl, String Gender,
  //     String HairStyle, String Color, BuildContext context) async {
  //   final categoryPhoto = PhotoUpload(
  //       id: id,
  //       imageUrl: ImageUrl,
  //       Gender: Gender,
  //       HairStyle: HairStyle,
  //       Color: Color);
  //   try {
  //     DocumentReference ref = await _db
  //         .collection("PhotosCategories")
  //         .add(categoryPhoto.toMap())
  //         .catchError((e) {
  //       print(e);
  //     });
  //     await _db
  //         .collection("PhotosCategories")
  //         .doc(ref.id)
  //         .update({"id": ref.id});
  //
  //     return ref.id;
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Unable to update data $e")));
  //     return "";
  //   }
  // }

  // Future<List> getHistoryData() async {
  //   List dataList = [];
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('custmer')
  //         .get()
  //         .then((QuerySnapshot querySnapshot) => {
  //               querySnapshot.docs.forEach((doc) {
  //                 dataList.add(doc.data());
  //               }),
  //             });
  //
  //     return dataList;
  //   } catch (e) {
  //     // print(e.toString());
  //     return [];
  //   }
  // }

  Future<List<Customer>> getCustomerData() async {
    List<Customer> dataList = [];
    QuerySnapshot snapshots =
        await _db.collection("custmer").get().catchError((e) {
      print("Error :- $e");
    });
    for (QueryDocumentSnapshot snap in snapshots.docs) {
      dataList.add(Customer(
        Gender: snap["Gender"],
        ImagePath: snap["ImagePath"],
        fname: snap["fname"],
        lname: snap["lname"],
        id: snap['id'],
        phno: snap['phno'],
        lastVi: snap['lastVi'].toDate(),
      ));
    }
    return dataList;
  }

  //======================================Photos=========================================================
  Future<void> updatePhotos(String image, String id) {
    return _db.collection("PhotosCategories").doc(id).update({
      "imageUrl": image,
    });
  }


  // Future<List<PhotoUpload>> getCategories(BuildContext context) async {
  //   List<PhotoUpload> categories = [];
  //   QuerySnapshot snapshots =
  //       await _db.collection("PhotosCategories").get().catchError((e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Error :- $e")));
  //   });
  //   for (QueryDocumentSnapshot snap in snapshots.docs) {
  //     categories.add(PhotoUpload(
  //       id: snap['id'],
  //       imageUrl: snap['imageUrl'],
  //       Gender: snap['Gender'],
  //       HairStyle: snap['hairStyle'],
  //       Color: snap['color'],
  //     ));
  //   }
  //   return categories;
  // }

  Future<List> getMData() async {
    List dataList = [];

    try {
      await FirebaseFirestore.instance
          .collection('Photos')
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  dataList.add(doc.data());
                }),
              });
      print(dataList);
      return dataList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

//===================================Clients=======================================
  Future<String> addClient(
      String id,
      int mobile,
      String FName,
      String LName,
      String pass,
      String username,
      BuildContext context,
      String location,
      String branch,
      String level) async {
    final categoryData = Client(
        id: id,
        fname: FName,
        lname: LName,
        mobile: mobile,
        pass: pass,
        username: username,
        location: location,
        level: level,
        branch: branch);

    try {
      DocumentReference ref = await _db
          .collection("Clients")
          .add(categoryData.toMap())
          .catchError((e) {
        print(e);
      });
      await _db.collection("Clients").doc(ref.id).update({"id": ref.id});
      return ref.id;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to update data $e")));
      return "";
    }
  }




  Future<File> get _localFile async {
    //final path = await _localPath;
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/data.csv').create();
  }
  getCsv() async {

    List<List<dynamic>> rows = <List<dynamic>>[];

    var cloud =  await FirebaseFirestore.instance
        .collection('custmer')
        .get();

    rows.add([
      "Name",
      "Gender",
      "Phone Number",
      "Email",
      "Age",
      "Area",
      "Assembly",
      "Meal Ticket"
    ]);

    if (cloud.docs != null) {
      for (int i = 0; i < cloud.docs.length; i++) {
        List<dynamic> row = <dynamic>[];
        row.add(cloud.docs[i]["fname"]);
        row.add(cloud.docs[i]["fname"]);
        row.add(cloud.docs[i]["fname"]);
        row.add(cloud.docs[i]["fname"]);
        row.add(cloud.docs[i]["fname"]);
        rows.add(row);
      }

      File f = await _localFile;

      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
    }
  }

  Future<List<Client>> getClientData() async {
    List<Client> dataList = [];

    QuerySnapshot snapshots =
        await _db.collection("Clients").get().catchError((e) {
      print("Error1 :- $e");
    });

    for (QueryDocumentSnapshot snap in snapshots.docs) {
      try {
        dataList.add(Client(
          id: snap["id"],
          fname: snap["fname"],
          lname: snap["lname"],
          mobile: snap["mobile"],
          username: snap['Username'],
          pass: snap['Password'],
          level: snap['level'],
          location: snap['location'],
          branch: snap['branch'],
        ));
      } catch (e) {
        print("hello $e");
      }
    }

    return dataList;
  }

  Future<void> updateClient(String Pass, String username) {
    print(_db.collection("Clients").doc(username));
    return _db.collection("Clients").doc(username).update({
      "Password": Pass,
    });
  }

  //====================================Categories=========================================
  Future<String> addCategory(
      String id,
      String title,
      List<String> Categories,
      String imagePath,
      BuildContext context,
      String Gender,
      String Description) async {
    final categoryData = Categorie(
        id: id,
        title: title,
        Cateories: Categories,
        ImagePath: imagePath,
        Gender: Gender,
        Description: Description);
    try {
      DocumentReference ref = await _db
          .collection("Categories")
          .add(categoryData.toMap())
          .catchError((e) {
        print(e);
      });
      await _db.collection("Categories").doc(ref.id).update({"id": ref.id});

      return ref.id;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to update data $e")));
      return "";
    }
  }

  Future<void> updateCatImage(String image, String id) {
    // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    // print(id);
    // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    return _db.collection("Categories").doc(id).update({
      "ImagePath": image,
    }).then((value) => print("Done"));
  }

  Future<List<dynamic>> getCategoriesData(BuildContext context) async {
    List<dynamic> categoriesList = [];
    QuerySnapshot snapshots =
        await _db.collection("Categories").get().catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error :- $e")));
    });
    for (QueryDocumentSnapshot snap in snapshots.docs) {
      categoriesList.add(Categorie(
        id: snap['id'],
        title: snap['title'],
        ImagePath: snap['ImagePath'],
        Cateories: snap['Categories'],
        Gender: snap['Gender'],
        Description: snap['Description'],
      ));
    }
    // print(categoriesList);
    return categoriesList;
  }

  Future<List<String>> getCategoriesValues() async {
    List<dynamic> categoriesvalue = [];
    List<String> output = [];
    await _db.collection("Categories").get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        categoriesvalue.add((value.docs[i]["Categories"]));
      }
    });
    for (final d in categoriesvalue) {
      output.add(d[0]);
    }
    return output;
  }

  Future<List> getCategoryGender(String Gender) async {
    List dataList = [];

    try {
      await _db
          .collection('Categories')
          .where('Gender', isNotEqualTo: Gender)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  dataList.add(doc.data());
                }),
              });
      print(dataList);
      return dataList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
//====================================Location===================================================

  Future<String> addLocation(
      String id,
      String contact,
      String Name,
      String location,
      String branch,
      String city,
      String state,
      String Add,
      BuildContext context) async {
    final categoryData = Location(
      id: id,
      name: Name,
      location: location,
      branch: branch,
      city: city,
      state: state,
      address: Add,
      contact: contact,
    );
    try {
      print(Add);
      DocumentReference ref = await _db
          .collection("location")
          .add(categoryData.toMap())
          .catchError((e) {
        print(e);
      });
      await _db.collection("location").doc(ref.id).update({"id": ref.id});
      return ref.id;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to update data $e")));
      return "";
    }
  }

  Future<List<Location>> getLocationData(BuildContext context) async {
    List<Location> dataList = [];

    QuerySnapshot snapshots =
        await _db.collection("location").get().catchError((e) {
      print("Error1 :- $e");
    });

    for (QueryDocumentSnapshot snap in snapshots.docs) {
      try {
        dataList.add(Location(
            id: snap['id'],
            name: snap['name'],
            location: snap['location'],
            contact: snap['contact'],
            address: snap['address'],
            branch: snap['branch'],
            city: snap['city'],
            state: snap['state']));
      } catch (e) {
        print(e);
      }
    }
    return dataList;
  }

//=====================================Photos=================================================
  Future<String> addPhotos(
    String id,
    String name,
    List<String> Categories,
    String Imagepath,
    BuildContext context,
    String summary,
    List<XFile> AdditionalPhotos,
    String LongDes1,
  ) async {
    final categoryData = Photos(
      id: id,
      name: name,
      summary: summary,
      Imagepath: Imagepath,
      Categories: Categories,
      LongDes1: LongDes1,
      AdditionalPhotos: [],
    );
    try {
      DocumentReference ref = await _db
          .collection("Photos")
          .add(categoryData.toMap())
          .catchError((e) {
        print(e);
      });
      await _db.collection("Photos").doc(ref.id).update({"id": ref.id});
      return ref.id;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to update data $e")));
      return "";
    }
  }

  Future<void> AddArray(String image, String id) {
    return _db.collection("Photos").doc(id).update({
      'AdditionalPhotos': FieldValue.arrayUnion([image]),
    });
  }

  Future<void> updatePhotoImage(String image, String id) {
    return _db.collection("Photos").doc(id).update({
      "Imagepath": image,
    }).then((value) => print("Done"));
  }


  Future<List<String>> getPhotosData() async {
    List<String> Photos1 = [];

    await _db.collection("Photos").get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        Photos1.add((value.docs[i]["Imagepath"]));
      }
    });
    print(Photos1);
    return Photos1;
  }
}
