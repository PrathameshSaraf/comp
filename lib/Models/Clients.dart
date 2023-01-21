import 'package:flutter/material.dart';


class Client{

  String id,fname,lname,pass,username,location,branch,level;
  int mobile;
  Client({
   required this.mobile, required this.id,required this.lname, required this.fname,required this.pass,required this.username,required this.branch,required this.level,required this.location
});
  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "fname": fname,
      "lname":lname,
      "Password":pass,
      "Username":username,
      "mobile":mobile,
      "level":level,
      "location":location,
      "branch":branch,
    };
  }


  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
        id: map['id'],
        fname: map['fname'],
        lname: map['lname'],
        pass: map['Password'],
        username: map['Username'],
        mobile: map['mobile'],
        level: map['level'],
        location: map['location'],
        branch: map['branch'],
    );
  }

}