import 'package:comp/services/Database.dart';
import 'package:flutter/material.dart';

class CustomerHistory extends StatefulWidget {
  String customerID;
  CustomerHistory({required this.customerID});
  @override
  _CustomerHistoryState createState() => _CustomerHistoryState();
}
String? name,gender,mobile,imagepath;
class _CustomerHistoryState extends State<CustomerHistory> {
   List HistoryData=[];

   bool _isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    getHisotyData();
    super.initState();
  }
  final db=DatabaseServices();

  getHisotyData()async{
  final value= await db.fetchHistoryData(widget.customerID);
  HistoryData=value;
  setState(() {
  });
  final Map<String, dynamic> doc= await db.getSingleValueCustomer(widget.customerID);
  print(doc);
    setState(() {
      name= doc['fname'] + " " + doc["lname"];
      gender=doc['Gender'];
      mobile=doc['phno'];
      imagepath=doc["ImagePath"];
    });
  }



  @override
  Widget build(BuildContext context) {
    print(widget.customerID);
    if (HistoryData.length > 0 && name!=null) {
      setState(() {
        _isloading = false;
      });
    }
    return  Scaffold(
      backgroundColor: Colors.white,
      body: _isloading ? const Center(
        child: CircularProgressIndicator(),
      ):SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: imagepath!=null?CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imagepath!),
              ):Container(
                decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle,border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),),
                margin: EdgeInsets.only(top: 30),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Icon(
                    size: 60.0,
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
            "Name - ${name!}",
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
              "Gender - ${gender!}",
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
             "Mobile No. - ${mobile!}",
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
                          itemCount: HistoryData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: HistoryData[index]['Aimage']!=null ||HistoryData[index]['Aimage']==''?Image.network( HistoryData[index]['Aimage']):Container(
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Icon(
                                    size: 100.0,
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                subtitle:Text("Date - ${(DateTime.fromMicrosecondsSinceEpoch((int.parse(HistoryData[index]['Date'].toString().split("=")[1].split(",")[0]) ?? 0 )* 1000000)).toLocal().toString().split(' ')[0]}"),
                                title: Text("Service - ${HistoryData[index]['Service']}"),

                              trailing: HistoryData[index]['Bimage']!=null||HistoryData[index]['Bimage']==""?Image.network(HistoryData[index]['Bimage']):Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Icon(
                                  size: 30.0,
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),

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
