

import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String title,Gender;
  final String ImageUrl;
  final void Function() onTap;


  Category({
   required this.onTap,
   required this.title,
   required this.ImageUrl,required this.Gender,
});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: onTap,
   child: Container(
    decoration: BoxDecoration(
    //borderRadius: BorderRadius.circular(12.0),
    border: Border.all(color: Colors.black, width: 1.2,),
    ),
    child: ClipRRect(
          // borderRadius: BorderRadius.circular(16.0),
            child:Stack(

                children: [
                  Positioned(
                    child:Image.network(
                      ImageUrl,
                      height: 200.0,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 1,
                    right: 0,
                    child:
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            //border:
                          ),
                         child: Row(
                            children: [
                              Text(title,style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black
                          ),),
                        Gender=='Male'?Icon(Icons.man):Gender=="Female"? Icon(Icons.woman_sharp):Icon(Icons.people)])

                    )
                  ),
                ]),)
      ),
      ));
  }
}




class StylistCard extends StatelessWidget {
  String id,name,location,contact,city,branch,address,state;

  StylistCard({
    required this.id,
    required this.name,
    required this.location,
    required this.state,
    required this.address,
    required this.branch,
    required this.city,
    required this.contact
  });


  @override
  Widget build(BuildContext context) {
    return Container(

      // width: double.infinity,
       height: 600,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white24,

      ),
      child: Stack(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(top: 40, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children:
                      [
                        Icon(Icons.home_filled,),
                    Text(
                     branch,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      " | "+location,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on,),
                    Text(
                      state,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      " | "+city,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,

                      size: 16,
                     // color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      contact,
                      style: TextStyle(
                        color: Color(0xff4E295B),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  address,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child:IconButton(onPressed: (){}, icon:Icon(Icons.edit))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}