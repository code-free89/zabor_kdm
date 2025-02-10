import 'package:flutter/material.dart';

class HelperMethods {
  static void showSnackBar(BuildContext context, String message,
      GlobalKey<ScaffoldState>? _scaffoldkey, SnackBarAction? action) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      action: action,
    ));
  }
}
