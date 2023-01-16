import 'package:flutter/material.dart';

class AppbarSample{
  AppBar getAppBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.orange,
    );
  }
}
