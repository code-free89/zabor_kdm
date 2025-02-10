import 'package:flutter/material.dart';

class ResBloc extends ChangeNotifier {
  int? _selectRes;
  String _selectResTitle = "ALL";

  set selectRes(int value) {
    _selectRes = value;
  }

  int get selectRes => this._selectRes ?? 0;

  set selectResTitle(String value) {
    _selectResTitle = value;
  }

  String get selectResTitle => this._selectResTitle;
}
