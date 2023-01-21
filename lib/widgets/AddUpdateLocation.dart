import 'package:comp/Admin/Dashbord.dart';
import 'package:comp/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import '../Models/AllMethods.dart';
import '../Models/Database.dart';
import 'createInputField.dart';





class addLocation extends StatefulWidget {
  const addLocation({Key? key}) : super(key: key);

  @override
  State<addLocation> createState() => _addLocationState();
}

class _addLocationState extends State<addLocation> {
  final db = DatabaseServices();
  final am=allMethods();
  final _NameController = TextEditingController();
  final _PhoneController = TextEditingController();
  final _AddController = TextEditingController();
  final _branchController = TextEditingController();

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
            child: Text("Add New Location"
              // widget.product == null ? "Add Product" : "Update Product",
              ,style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 500,
                child: Column(
                  children: [
                    CreateInput(title: 'Name',controller: _NameController,obscureText: false,),
                    CreateInput(title: 'Branch',controller: _branchController,obscureText: false,),

                    CSCPicker(
                      ///Enable disable state dropdown [OPTIONAL PARAMETER]
                      showStates: true,

                      /// Enable disable city drop down [OPTIONAL PARAMETER]
                      showCities: true,

                      ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                      flagState: CountryFlag.DISABLE,

                      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                      ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300,
                          border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                      ///placeholders for dropdown search field
                      countrySearchPlaceholder: "Country",
                      stateSearchPlaceholder: "State",
                      citySearchPlaceholder: "City",

                      ///labels for dropdown
                      countryDropdownLabel: "*Country",
                      stateDropdownLabel: "*State",
                      cityDropdownLabel: "*City",

                      ///Default Country
                      //defaultCountry: DefaultCountry.India,

                      ///Disable country dropdown (Note: use it with default country)
                      //disableCountry: true,

                      ///selected item style [OPTIONAL PARAMETER]
                      selectedItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                      dropdownHeadingStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),

                      ///DropdownDialog Item style [OPTIONAL PARAMETER]
                      dropdownItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///Dialog box radius [OPTIONAL PARAMETER]
                      dropdownDialogRadius: 10.0,

                      ///Search bar radius [OPTIONAL PARAMETER]
                      searchBarRadius: 10.0,

                      ///triggers once country selected in dropdown
                      onCountryChanged: (value) {
                        setState(() {
                          ///store value in country variable
                          countryValue = value;
                        });
                      },

                      ///triggers once state selected in dropdown
                      onStateChanged: (value1) {
                        setState(() {
                          ///store value in state variable
                          stateValue = value1.toString();
                        });
                      },

                      ///triggers once city selected in dropdown
                      onCityChanged: (value2) {
                        setState(() {
                          ///store value in city variable
                          cityValue = value2.toString();
                        });
                      },
                    ),

                    Align(
                      child: Text("Address",
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      alignment: Alignment.centerLeft,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,//Normal textInputField will be displayed
                      maxLines:null,
                      controller: _AddController,
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
                    CreateInput(title: 'Contact',controller: _PhoneController,obscureText: false,),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonW100(text: "Add", onTap: (){
                      db.addLocation('', _PhoneController.text, _NameController.text,cityValue, _branchController.text, countryValue, stateValue, _AddController.text, context);
                      am.fetchData(context, Dashbord(val: 6));
                    })

                  ],
                ),
              ),

          ),
        ],
      ),
    );
  }
}

