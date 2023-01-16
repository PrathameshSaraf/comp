import 'package:flutter/material.dart';

class ButtonW100 extends StatelessWidget {
  final String text;
  final void Function() onTap;


  const ButtonW100({super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
      return SizedBox(
          width: 280.0,
          height: 50.0,
          child: ElevatedButton(
            onPressed: onTap,
            child: Text(
             text,
              style: TextStyle(fontSize: 18),
            ),
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.orange),
            ),
          ));
  }
}