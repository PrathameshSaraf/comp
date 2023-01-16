

class Customer {

  String id;
  String fname;
  String lname;
  String phno;
  String Gender;
  String ImagePath;
  DateTime lastVi;

  Customer({required this.id,required this.fname,required this.lname,required this.Gender,required this.phno,required this.ImagePath,required this.lastVi});

  Map<String, dynamic> toMap() {
    return {
       "id":id,
      "fname": fname,
      "lname":lname,
      "ImagePath": ImagePath,
      "phno": phno,
      "Gender":Gender,
      "lastVi":lastVi,

    };
  }


  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      fname: map['fname'],
      lname: map['lname'],
      ImagePath: map['ImagePath'],
      phno: map['phno'],
      Gender: map['Gender'],
      lastVi: map['lastVi'].toDate(),
    );


  }
}