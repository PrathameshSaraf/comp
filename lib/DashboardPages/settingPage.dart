
import 'package:comp/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  Color? primaryColor;
  String? fontFamily;
  bool? isDarkMode;
  String? _logo;

  @override
  void initState() {
    super.initState();

    primaryColor = Colors.indigo;
    fontFamily = 'Arial';
    isDarkMode = false;
  }

  void _pickLogo() {
    // Create an input element with type 'file' and accept attribute set to 'image/*'

  }
  //In this example, an InputElement of type "file" is created and its accept attribute is



  void _changePrimaryColor(Color color) {
    setState(() {
      primaryColor = color;
    });
  }

  void _changeFontFamily(String? font) {
    setState(() {
      fontFamily=font;
    });
  }

  void _changeMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              child: _logo != null
                  ? Image.network(_logo!)
                  : Text('No logo selected'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Logo'),
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _pickLogo,
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Primary Color'),
                ),
                ColorPickerButton(
                  color: primaryColor!,
                  onColorChanged: _changePrimaryColor,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: primaryColor!,
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Font Family'),
                ),
                DropdownButton<String>(
                  value: fontFamily,
                  items: <String>['Arial', 'Helvetica', 'Times New Roman']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: _changeFontFamily,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Dark Mode'),
                ),
                Switch(
                  value: isDarkMode!,
                  onChanged: _changeMode,
                ),
              ],
            ),

            ButtonW100(text: "Save", onTap: (){

            })],
        ),
      ),
    );
  }
}

class ColorPickerButton extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  ColorPickerButton({
  Key? key,
    required this.color,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.color_lens),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Pick color'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: color,
                  onColorChanged: onColorChanged,
                 // enableLabel: true,
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class SettingsPage1 extends StatefulWidget {
  @override
  _SettingsPageState1 createState() => _SettingsPageState1();
}

class _SettingsPageState1 extends State<SettingsPage1> {
  Color _primaryColor = Colors.blue;
  String _fontFamily = 'MyFont';
  Brightness _brightness = Brightness.light;
  Image? _logo;

  void _updatePrimaryColor(Color color) {
    setState(() {
      _primaryColor = color;
    });
  }

  void _updateFontFamily(String fontFamily) {
    setState(() {
      _fontFamily = fontFamily;
    });
  }

  void _updateBrightness(Brightness brightness) {
    setState(() {
      _brightness = brightness;
    });
  }

  void _updateLogo(Image logo) {
    setState(() {
      _logo = logo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Primary Color'),
              trailing: Container(
                width: 50.0,
                height: 50.0,
                color: _primaryColor,
              ),
              onTap: () {
                // Show a color picker and update the primary color when the user selects a new color
              },
            ),
            ListTile(
              title: Text('Font Family'),
              trailing: Text(_fontFamily),
              onTap: () {
                // Show a list of available font families and update the font family when the user selects a new font
              },
            ),
            ListTile(
              title: Text('Brightness'),
              trailing: _brightness == Brightness.light ? Text('Light') : Text('Dark'),
              onTap: () {
                // Show a toggle to switch between light and dark brightness and update the brightness when the user changes the toggle
              },
            ),
            ListTile(
              title: Text('Logo'),
              trailing: _logo,
              onTap: () {
                // Show an image picker and update the logo when the user selects a new image
              },
            ),
          ],
        ),
      ),
    );
  }
}
