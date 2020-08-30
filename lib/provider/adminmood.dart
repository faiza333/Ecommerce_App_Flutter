import 'package:flutter/cupertino.dart';

class AdminMood extends ChangeNotifier
{
  bool isAdmin  = false;

  changeIsAdmin(bool value)
  {
    isAdmin = value;
    notifyListeners();
  }
}