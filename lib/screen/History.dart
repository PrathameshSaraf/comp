import 'package:flutter/material.dart';

class CustomerHistory extends StatefulWidget {
  @override
  _CustomerHistoryState createState() => _CustomerHistoryState();
}

class _CustomerHistoryState extends State<CustomerHistory> {
  String _name = "John Doe";
  String _gender = "Male";
  String _mobile = "555-555-5555";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/comp-fe7ff.appspot.com/o/Photos%2Fsdfbg.jpg?alt=media&token=c9553f34-3f7c-4d73-9c48-26feb7ce29d5"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.orange,
                letterSpacing: 2.5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _gender,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                letterSpacing: 2.5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              _mobile,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                letterSpacing: 2.5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/comp-fe7ff.appspot.com/o/Photos%2Fsdfbg.jpg?alt=media&token=c9553f34-3f7c-4d73-9c48-26feb7ce29d5"),
                                title:   Text("12-02-2023"),subtitle: Text("sdfghb hgtfnjhn hjyb jhb njhb jnhb mjnbh mknjbh nknjbh jnbh nmjnbh nmkjb mnjb mkmnjb jb nv nhgtfvc bhgfdcmmmmmmmmmmmmmmmmmmnjjjjjjjjjjjjjknkkkkkkkkkkkj hbbbbbb"),

                              trailing: Image.network(
                                     "https://firebasestorage.googleapis.com/v0/b/comp-fe7ff.appspot.com/o/Photos%2Fsdfbg.jpg?alt=media&token=c9553f34-3f7c-4d73-9c48-26feb7ce29d5"),

                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
