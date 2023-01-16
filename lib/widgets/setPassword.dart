// import 'package:beep_com/widgets/Button.dart';
// import 'package:beep_com/widgets/createInputField.dart';
// import 'package:flutter/material.dart';
//
// class resetPass extends StatelessWidget {
//   final String id;
//   final _PassController = TextEditingController();
//   final _CpassController = TextEditingController();
//   resetPass({required this.id});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: GestureDetector(
//
//             // close keyboard on outside input tap
//             onTap: () {
//               FocusScope.of(context).requestFocus(FocusNode());
//             },
//             child: Builder(
//               builder: (context) => ListView(
//                 padding:EdgeInsets.symmetric(vertical: 0,horizontal: 0),
//                 children: <Widget>[
//                   // header text
//                   Text('Reset Password',),
//                   Text('Deco UI Kit',),
//                   CreateInput(title: 'New Password',controller: _PassController,obscureText: true,),
//                   CreateInput(title: 'Confirm Password',controller:_CpassController,obscureText: true,),
//
//                   // submit button
//                   ButtonW100(text: 'Reset', onTap:()=>{})
//                 ],
//               ),
//             )));
//   }
// }
