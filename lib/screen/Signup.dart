
import 'package:flutter/material.dart';
import '../Admin/Dashbord.dart';
import '../Models/AllMethods.dart';
import '../Models/Database.dart';
import '../Models/auth_servies.dart';
import '../widgets/Button.dart';
import '../widgets/createInputField.dart';

String dropdownValue = 'Male';
String dropdownValue1 = 'Senior';
String dropdownValue2 = '22';
class SignupPage extends StatefulWidget {
  static const routeName = '/signup';
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final db = DatabaseServices();
  final am=allMethods();
  final _formKey = GlobalKey<FormState>();
  final _productPriceController = TextEditingController();
  final _NameController = TextEditingController();
  final _PhoneController = TextEditingController();
  final _PassController = TextEditingController();
  final _CpassController = TextEditingController();
  final _mobileController = TextEditingController();
  List<TextEditingController> _controllers = [];
  List<RadioListTile> _fields = [];



  Widget _addTile() {
    return ListTile(
      title: Icon(Icons.add),
      onTap: () {
        int index=0;
        final controller = TextEditingController();
        final field = RadioListTile(
          title:  TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Value ",
            ),
          ),
          value: "male",
          groupValue: "Category Name",
          onChanged: (value){
            setState(() {

            });
          },
        );

        setState(() {
          _controllers.add(controller);
          _fields.add(field);

        });
      },
    );
  }

  Widget _listView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _fields.length,
      itemBuilder: (context, index) {
        return   _fields[index];

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Signup() {
    //    _fetchData(context);
    //   _authMethods
    //       .registerUsingEmailPassword( _NameController.text, _PhoneController.text,_CpassController.text).then(
    //       (value){
    //         if (value == null) {
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             const SnackBar(
    //               content: Text("Please check your credentials."),
    //             ),
    //           );
    //         } else{
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             const SnackBar(
    //               content: Text("User Register Complete."),
    //             ),
    //           );
    //           Navigator.of(context).pushNamed('/');
    //         }
    //       }
    //   ).catchError((e)=>
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(SnackBar(content: Text("Error$e")))
    //   );
    //   }
     Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Password and confirm password do not match."),
      actions: [
        okButton,
      ],
    );
     double width = MediaQuery.of(context).size.width;
    return   SingleChildScrollView(
      //padding: EdgeInsets.all(1),
          // padding:width<600? EdgeInsets.all(60):width<1000?EdgeInsets.symmetric(horizontal: 200,vertical: 50)
          //     :width<1400?EdgeInsets.symmetric(horizontal: 400,vertical: 50):EdgeInsets.symmetric(horizontal: 600,vertical: 50),
          child:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              child: Form(
              key: _formKey,
              child:
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Add Staff",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                      Padding(
                          // padding: EdgeInsets.all(60),
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          child: Column(children: [
                            CreateInput(title: 'Full Name',controller: _NameController,obscureText: false,),

                            Align(
                              child: Text("Phone Number",
                                  style:
                                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              alignment: Alignment.centerLeft,
                            ),
                            TextFormField(

                              keyboardType: TextInputType.numberWithOptions(),
                              controller: _mobileController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CreateInput(title: 'Email',controller: _PhoneController,obscureText: false,),
                            CreateInput(title: 'Password',controller: _PassController,obscureText: true,),
                            CreateInput(title: 'Confirm Password',controller: _CpassController,obscureText: true,),
                            Align(
                              child: Text("Gender",
                                  style:
                                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              alignment: Alignment.centerLeft,
                            ),

                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  //<-- SEE HERE
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                ),
                                filled: true,
                                //fillColor: Colors.greenAccent,
                              ),
                              // dropdownColor: Colors.greenAccent,
                              value: dropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>['Male', 'Female']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 30,)
                            // ),Align(
                            //   child: Text("Select Branch",
                            //       style:
                            //       TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            //   alignment: Alignment.centerLeft,
                            // ),
                            //
                            // DropdownButtonFormField(
                            //   decoration: InputDecoration(
                            //     enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.black, width: 2),
                            //     ),
                            //     focusedBorder: OutlineInputBorder(
                            //       //<-- SEE HERE
                            //       borderSide: BorderSide(color: Colors.black, width: 2),
                            //     ),
                            //     filled: true,
                            //     //fillColor: Colors.greenAccent,
                            //   ),
                            //   // dropdownColor: Colors.greenAccent,
                            //   value: dropdownValue2,
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       dropdownValue2 = newValue!;
                            //     });
                            //   },
                            //   items: <String>['22', '32']
                            //       .map<DropdownMenuItem<String>>((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(
                            //         value,
                            //         style: TextStyle(fontSize: 20),
                            //       ),
                            //     );
                            //   }).toList(),
                            // ),
                                ,CreateInput(title: 'Branch',controller: _CpassController,obscureText: false,),



                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Level",style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ),
                            RadioListTile(
                              title:  TextFormField(
                                validator: (v) {
                                  return v == null
                                      ? "Required field"
                                      : v.isEmpty
                                      ? "Required Field"
                                      : null;
                                },
                                controller: _productPriceController,
                                decoration: const InputDecoration(
                                  labelText: "Value",
                                ),
                              ),
                              value: "male",
                              groupValue: "Category Name",
                              onChanged: (value){
                                setState(() {

                                });
                              },
                            ),
                            Container(
                              child: Column(
                                children: [

                                  _listView(),
                                  _addTile(),
                                ],
                              ),
                            ),


                            SizedBox(
                              height: 30,
                            ),

                          ])),
                      ButtonW100(text: 'Add Staff',onTap: () {
                        final pass=_PassController.text;
                        final cpass=_CpassController.text;
                        int firstSpace = _NameController.text.indexOf(" "); // detect the first space character
                        String firstName = _NameController.text.substring(0, firstSpace);  // get everything upto the first space character
                        String lastName = _NameController.text.substring(firstSpace).trim(); // get everything after the first space, trimming the spaces off

                        if(pass==cpass){
                          db.addClient('',int.parse(_mobileController.text),firstName,lastName, _PassController.text,_PhoneController.text, context,dropdownValue,dropdownValue1,dropdownValue2).then((value) {
                            _PhoneController.clear();_NameController.clear();_PassController.clear();_CpassController.clear();_mobileController.clear();
                            am.fetchData(context,Dashbord(val: 3));
                          });
                        }
                        else{
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }
                      }
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have a Staff ? "),
                          new InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/');
                            },
                           child: Text(
                            "Staff Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          )],
                      )
                    ],
                  ),
              ),
            ),
          ),
        );
  }
}


