
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Admin/Dashbord.dart';
import '../Models/auth_servies.dart';
class SideMenu extends StatelessWidget {
  final bool web;
  final void Function(int, bool, bool) changeScreen;


  SideMenu({super.key, required this.web, required this.changeScreen});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      width: web
          ? width < 580
          ? 0.0
          : width <= 1000
          ? 0.0
          : 240
          : null,
      child: SingleChildScrollView(
        child: Column(

          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0x06000000),
              ),
              accountName: const Text(
                "Welcome Admin",
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text("",
                //_auth.getEmail(),""
                style: const TextStyle(color: Colors.black),
              ),
              otherAccountsPictures: [
                // CircleAvatar(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text("Other User", style: TextStyle(fontSize: 10.0)),
                //   ),
                // ),
                IconButton(
                    onPressed: () {
                    //  _auth.logout(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.square_arrow_right,
                      color: Colors.red,
                    )),
              ],
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(color: const Color(0x21000000))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    "assets/images/beep.png",
                    width: 100.0,
                    height: 100.0,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(0, web, false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>Dashbord(val: 1)
                    ));

              },
              title: const Text("Dashboard"),
              leading: const Icon(Icons.dashboard_outlined),
            ),
            ListTile(
              onTap: () {
                changeScreen(1, web, false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>Dashbord(val: 2)
                    ));
              },
              title: const Text("Customer"),
              leading: const Icon(Icons.people_alt_outlined),
            ),
            ListTile(
              onTap: () {
                changeScreen(2, web, false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>Dashbord(val: 3)
                    ));
              },
              title: const Text("Clients"),
              leading: const Icon(Icons.emoji_people),
            ),
            ListTile(
              onTap: () {
                changeScreen(0, web, false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>Dashbord(val: 4)
                    ));
              },
              title: const Text("Photos"),
              leading: const Icon(Icons.photo),
            ),
            ListTile(
              onTap: () {
                changeScreen(0, web, false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>Dashbord(val: 5)
                    ));
              },
              title: const Text("Categories"),
              leading: const Icon(Icons.category_outlined),
            ),
            ListTile(
              onTap: () {
                changeScreen(2, web, false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>Dashbord(val: 6)
                    ));
              },
              title: const Text("Location"),
              leading: const Icon(Icons.location_on),
            ),
            ListTile(
              onTap: () {
                changeScreen(0, web, false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>Dashbord(val: 6)
                    ));
              },
              title: const Text("Profile"),
              leading: const Icon(Icons.person),
            ),
            // const Spacer(),
            // ListTile(
            //   onTap: () {},
            //   title: Text("Logout"),
            //   leading: Icon(CupertinoIcons.square_arrow_right),
            // ),
          ],
        ),
      ),
    );
  }
}
