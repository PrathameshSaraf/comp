// import 'dart:convert';
// import 'dart:html';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'dart:html' as html;
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   Color? primaryColor;
//   String? fontFamily;
//   bool? isDarkMode;
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   String? _logo;
//   @override
//   void initState() {
//     super.initState();
//
//     primaryColor = Colors.indigo;
//     fontFamily = 'Arial';
//     isDarkMode = false;
//   }
//
//   void _pickLogo() {
//     // Create an input element with type 'file' and accept attribute set to 'image/*'
//     InputElement input = InputElement();
//     input.type = 'file';
//     input.accept = 'image/*';
//
//     input.onChange.listen((e) {
//       final files = input.files;
//       if (files?.length! == 1) {
//         final file = files![0];
//         final reader = FileReader();
//         reader.onLoadEnd.listen((e) {
//           setState(() {
//             _logo = reader.result as String;
//           });
//         });
//
//         reader.readAsDataUrl(file);
//       }
//     });
//
//     input.click();
//   }
//   //In this example, an InputElement of type "file" is created and its accept attribute is
//
//
//
//   void _changePrimaryColor(Color color) {
//     setState(() {
//       primaryColor = color;
//     });
//   }
//
//   void _changeFontFamily(String? font) {
//     setState(() {
//       fontFamily=font;
//     });
//   }
//
//   void _changeMode(bool value) {
//     setState(() {
//       isDarkMode = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Container(
//               height: 200,
//               width: double.infinity,
//               child: _logo != null
//                   ? Image.network(_logo!)
//                   : Text('No logo selected'),
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Text('Logo'),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.image),
//                   onPressed: _pickLogo,
//                 ),
//               ],
//             ),
//
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Text('Primary Color'),
//                 ),
//                 ColorPickerButton(
//                   color: primaryColor!,
//                   onColorChanged: _changePrimaryColor,
//                 ),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Text('Font Family'),
//                 ),
//                 DropdownButton<String>(
//                   value: fontFamily,
//                   items: <String>['Arial', 'Helvetica', 'Times New Roman']
//                       .map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: _changeFontFamily,
//                 ),
//               ],
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Text('Dark Mode'),
//                 ),
//                 Switch(
//                   value: isDarkMode!,
//                   onChanged: _changeMode,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ColorPickerButton extends StatelessWidget {
//   final Color color;
//   final ValueChanged<Color> onColorChanged;
//
//   ColorPickerButton({
//   Key? key,
//     required this.color,
//     required this.onColorChanged,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.color_lens),
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Pick color'),
//               content: SingleChildScrollView(
//                 child: ColorPicker(
//                   pickerColor: color,
//                   onColorChanged: onColorChanged,
//                  // enableLabel: true,
//                   pickerAreaHeightPercent: 0.8,
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   child: const Text('Save'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }