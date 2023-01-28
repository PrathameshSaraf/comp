import 'package:flutter/material.dart';

import '../widgets/Button.dart';
import 'Dashbord.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/adminlogin';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String user = "Saraf@gmail.com";
  String pass = "123456";

  InputDecoration getInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Colors.orange),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Padding(
        padding: width < 600
            ? EdgeInsets.all(60)
            : width < 1000
                ? EdgeInsets.symmetric(horizontal: 200, vertical: 50)
                : width < 1400
                    ? EdgeInsets.symmetric(horizontal: 400, vertical: 50)
                    : EdgeInsets.symmetric(horizontal: 600, vertical: 50),
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/");
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.centerLeft,
              height: height * 0.27,
              child: Text(
                MediaQuery.of(context).size.width > 540
                    ? "Admin Login"
                    : "Welcome \n$user",
                style: const TextStyle(
                  fontSize: 36.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                return value != null
                                    ? RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)
                                        ? null
                                        : "Enter valid email"
                                    : "Enter email";
                              },
                              decoration: getInputDecoration("Username"),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                return value != null
                                    ? value.length >= 6
                                        ? null
                                        : value.isEmpty
                                            ? "Enter Password"
                                            : "Minimum password length is 6"
                                    : "Enter Password";
                              },
                              obscureText: true,
                              decoration: getInputDecoration("Password"),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     const Spacer(),
                      //     InkWell(
                      //       onTap: () {},
                      //       child: const Text(
                      //         "Forget Password?",
                      //         style: TextStyle(color: Colors.blue),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 45,
                      ),
                      ButtonW100(
                          text: 'Login',
                          onTap: () => {
                                if (!_formKey.currentState!.validate())
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Unable to Login")))
                                  },
                                //  if(_formKey.currentState!.validate()  && user==_emailController.text && pass==_passwordController.text){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Dashbord(val: 1))).then((value) {
                                  _passwordController.clear();
                                  _emailController.clear();
                                })
                              }
                          //}
                          ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
