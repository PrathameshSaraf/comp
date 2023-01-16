import 'package:flutter/material.dart';
import '../Admin/adminlogin.dart';
import '../Models/Clients.dart';
import '../Models/Database.dart';
import '../widgets/Button.dart';
import '../widgets/TextEditor.dart';
import 'RecordCustomer.dart';
import 'Signup.dart';
import 'forgatePage.dart';

class LoginState extends StatefulWidget {
  @override
  State<LoginState> createState() => _LoginState();
}

class _LoginState extends State<LoginState> {
  // const Login({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final _PhoneController = TextEditingController();
  final _PassController = TextEditingController();
  final db = DatabaseServices();
  List<Client> products=[];
  bool pd=false;
  @override
  void initState() {

    getProducts();
    // TODO: implement initState
    super.initState();
  }

   getProducts()async {
     final val= await db.getClientData();

     products=val;
     setState(() {
     });
   }

  loginUser(String Username,String Password) {

    products.forEach((element) {
      if(element.username==Username && element.pass==Password){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User Logged In "),
          ),
        );
        setState(() {
          pd=true;
        });
        Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) =>RecordCostomer()
                     )).then((value) {
          _PhoneController.clear();
          _PassController.clear();
        });
      }});
      if(pd==false){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username And Password Wrong."),
          ),
        );
        _PhoneController.clear();
        _PassController.clear();
      }
    }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return
    Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:width<600? EdgeInsets.all(60):width<1000?EdgeInsets.symmetric(horizontal: 200,vertical: 50)
              :width<1400?EdgeInsets.symmetric(horizontal: 400,vertical: 50):EdgeInsets.symmetric(horizontal: 600,vertical: 50),
          child: Column(children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(LoginScreen.routeName);
                },
                child: Image.asset(
                  "assets/images/beep.png",
                  height: 150,
                  fit: BoxFit.fitHeight,
                )),
            SizedBox(
              height: 40,
            ),
            Text(
              "CONSULTION PRO ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Align(
                      child: Text("Email ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      alignment: Alignment.centerLeft,
                    ),
                    TextFormField(
                      validator: (value) {
                        return value != null
                            ? RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)
                                ? null
                                : "Enter valid email"
                            : "Enter email";
                      },
                      controller: _PhoneController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      child: Text("Password",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      alignment: Alignment.centerLeft,
                    ),
                    TextFormField(
                      controller: _PassController,
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
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  //return (forgot());
                                  return HtmlEditorExample();

                                });
                            //Navigator.of(context).pushNamed(forgot.routeName);
                          },
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ButtonW100(text: 'Login', onTap: (){
                      loginUser(_PhoneController.text,_PassController.text);
                    }),
                    SizedBox(
                      height: 50,
                    ),

                    TextButton(onPressed: (){
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return SignupPage();
                          });
                    }, child:Text("Sign Up",style: TextStyle(color: Colors.orange),))
                  ]),
                ))
          ]),
        ),
      ),
    ));
  }
}
