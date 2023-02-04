// import 'dart:io';
// import 'package:flutter_font_picker/flutter_font_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   File? _image;
//   Color _selectedColor = Colors.blue;
//   String _selectedFont = "Roboto";
//   TextStyle? _selectedFontTextStyle;
//   final List<String> _myGoogleFonts = [
//     "Abril Fatface",
//     "Aclonica",
//     "Alegreya Sans",
//     "Architects Daughter",
//     "Archivo",
//     "Archivo Narrow",
//     "Bebas Neue",
//     "Bitter",
//     "Bree Serif",
//     "Bungee",
//     "Cabin",
//     "Cairo",
//     "Coda",
//     "Comfortaa",
//     "Comic Neue",
//     "Cousine",
//     "Croissant One",
//     "Faster One",
//     "Forum",
//     "Great Vibes",
//     "Heebo",
//     "Inconsolata",
//     "Josefin Slab",
//     "Lato",
//     "Libre Baskerville",
//     "Lobster",
//     "Lora",
//     "Merriweather",
//     "Montserrat",
//     "Mukta",
//     "Nunito",
//     "Offside",
//     "Open Sans",
//     "Oswald",
//     "Overlock",
//     "Pacifico",
//     "Playfair Display",
//     "Poppins",
//     "Raleway",
//     "Roboto",
//     "Roboto Mono",
//     "Source Sans Pro",
//     "Space Mono",
//     "Spicy Rice",
//     "Squada One",
//     "Sue Ellen Francisco",
//     "Trade Winds",
//     "Ubuntu",
//     "Varela",
//     "Vollkorn",
//     "Work Sans",
//     "Zilla Slab",
//   ];
//   void _pickImage() async {
//     // Add your image picker logic here
//   }
//
//   void _saveChanges() {
//     // Add your save changes logic here
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: <Widget>[
//               Container(
//                 height: 200,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     image:NetworkImage(
//                       'https://picsum.photos/200',
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Align(
//                   alignment: Alignment.bottomRight,
//                   child: IconButton(
//                     icon: Icon(Icons.edit),
//                     onPressed: _pickImage,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Company Name',
//                 ),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               ColorPicker(
//                 onColorChanged: (color) {
//                   setState(() {
//                     _selectedColor = color;
//                   });
//                 },
//                pickerColor: _selectedColor,
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//
//               ElevatedButton(
//                 child: const Text('Pick a font (with a screen)'),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => FontPicker(
//                         recentsCount: 10,
//                         onFontChanged: (font) {
//                           setState(() {
//                             _selectedFont = font.fontFamily;
//                             _selectedFontTextStyle = font.toTextStyle();
//                           });
//                           debugPrint(
//                             "${font.fontFamily} with font weight ${font.fontWeight} and font style ${font.fontStyle}. FontSpec: ${font.toFontSpec()}",
//                           );
//                         },
//                         googleFonts: _myGoogleFonts,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//
//               SizedBox(
//                 height: 16,
//               ),
//               TextButton(
//                 child: Text('Save'),
//                 onPressed: _saveChanges,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
