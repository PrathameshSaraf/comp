import 'package:flutter/material.dart';

class CreateInput extends StatelessWidget {

  String title;
  final  controller;
  bool obscureText=false;
 final onChange;

  CreateInput({required this.title,required this.controller,required this.obscureText,this.onChange});
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
        Align(
          child: Text(title,
              style:
              TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          alignment: Alignment.centerLeft,
        ),

        TextFormField(
          obscureText: obscureText,
           onChanged: onChange,
           controller: controller,
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
        )
  ]  );
  }
}

class CreateInputFor extends StatelessWidget {

  String title;
  final  controller;
  bool obscureText=false;
  String?  initial_value='';

  CreateInputFor({required this.title,required this.controller,required this.obscureText,this.initial_value});
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Align(
            child: Text(title,
                style:
                TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            alignment: Alignment.centerLeft,
          ),

          TextFormField(
            obscureText: obscureText,

            controller: controller,
            initialValue: this.initial_value!,
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
          )
        ]  );
  }
}
