
import 'package:flutter/material.dart';

import '../Models/AuthExceptionHandler.dart';
import '../Models/Clients.dart';
import '../Models/Database.dart';
import '../Models/auth_servies.dart';
import '../widgets/AppBar.dart';
import '../widgets/Button.dart';

class forgot extends StatefulWidget {
  // const forgot({Key? key}) : super(key: key);
  static const routeName = '/forgot';

  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  final _EmailController = TextEditingController();
  final _PassController = TextEditingController();
  final _CPassController = TextEditingController();
  String id="";
  final _formKey = GlobalKey<FormState>();
  final db = DatabaseServices();
  List<Client> products=[];
  bool isclick=true;

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

  @override
  Widget build(BuildContext context) {

    Widget _addTile() {

      return Column(
        children: [
          TextFormField(
              controller:_PassController,
              decoration: InputDecoration(labelText: 'Enter New Password',focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.blue, width: 1.5),
              ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.black, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.red, width: 1.5),
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
              validator: (value) {
                return value != null
                    ? value.length >= 6
                    ? null
                    : value.isEmpty
                    ? "Enter Password"
                    : "Minimum password length is 6"
                    : "Enter Password";
              }
          ),
          SizedBox(height: 30,),TextFormField(
              controller:_CPassController,
              decoration: InputDecoration(labelText: 'Enter Confirm Password',
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
                            BorderSide(color: Colors.red, width: 1.5),
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
              validator: (value) {
                return value != null
                    ? value.length >= 6
                    ? null
                    : value.isEmpty
                    ? "Enter Password"
                    : "Minimum password length is 6"
                    : "Enter Password";
              }
          ),
          SizedBox(height: 30,),
          ButtonW100(
              text: 'Change Password',
              onTap: () {
                if(_PassController.text==_CPassController.text){
                db.updateClient(_CPassController.text, id);
              }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password Does Not Match"),
                    ),
                  );
          }}
          )
        ],
      );
    }

    return Scaffold(
        appBar: AppbarSample().getAppBar('CUNSULTATION PRO'),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: ListView(children: <Widget>[
                      TextFormField(
                         controller:_EmailController,
                          decoration: InputDecoration(labelText: 'Enter Gmail',focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue, width: 1.5),
                          ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red, width: 1.5),
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
                          validator: (value) {
                            return value != null
                                ? RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)
                                ? null
                                : "Enter valid email"
                                : "Enter email";
                          }
                      ),
                      SizedBox(height: 30,),
                      isclick?ButtonW100(
                          text: 'Proceed',
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                            products.forEach((element) {
                             if( element.username==_EmailController.text){
                               setState(() {
                                 id=element.id;
                                 print(id);
                                 isclick=false;
                               });
                             }});
                             if(id==""){
                               ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                   content: Text("User Not Found Please Check Username"),
                                 ),
                               );
                             }

                          }}):_addTile()
                    ])))));
  }
}