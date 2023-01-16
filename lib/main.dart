import 'package:comp/screen/LoginPage.dart';
import 'package:comp/screen/RecordCustomer.dart';
import 'package:comp/screen/Signup.dart';
import 'package:flutter/material.dart';
import 'Admin/addPhotos.dart';
import 'Admin/adminlogin.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options
        : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/":(context)=>LoginState(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        //forgot.routeName:(ctx)=>forgot(),

        RecordCostomer.routeName:(ctx)=>RecordCostomer(),
        SignupPage.routeName:(ctx)=>SignupPage(),
        AddPhotos.routeName: (ctx) =>AddPhotos(),
        //editDeleteScreen.routeName:(ctx)=>editDeleteScreen( ),
       // HistoryScreen.routeName:(ctx)=>HistoryScreen(),
      },
    );
  }
}
