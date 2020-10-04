import 'package:flutter/material.dart';

class Utility{
  static void displaySnackbar(BuildContext context,{ String msg = "Feature is under development", GlobalKey<ScaffoldState> key}) {
    final snackBar = SnackBar(content: Text(msg));
    if(key != null && key.currentState != null){
      key.currentState.hideCurrentSnackBar();
      key.currentState.showSnackBar(snackBar);
    }
    else{
       Scaffold.of(context).hideCurrentSnackBar();
       Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}