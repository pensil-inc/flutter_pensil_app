import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class CustomLoader {
  static CustomLoader _customLoader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_customLoader != null) {
      return _customLoader;
    } else {
      _customLoader = CustomLoader._createObject();
      return _customLoader;
    }
  }

  //static OverlayEntry _overlayEntry;
  OverlayState _overlayState; //= new OverlayState();
  OverlayEntry _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Container(
            height: AppTheme.fullHeight(context),
            width: AppTheme.fullWidth(context),
            child: buildLoader(context));
      },
    );
  }

  showLoader(context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState.insert(_overlayEntry);
  }

  hideLoader() {
    try {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {
      print("Exception:: $e");
    }
  }

  buildLoader(BuildContext context, {Color backgroundColor}) {
    if (backgroundColor == null) {
      backgroundColor = const Color(0xffa8a8a8).withOpacity(.5);
    }
    var height = 140.0;
    return CustomScreenLoader(
      height: height,
      width: height,
      backgroundColor: backgroundColor,
    );
  }
}

class CustomScreenLoader extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double width;
  const CustomScreenLoader(
      {Key key,
      this.backgroundColor = const Color(0xfff8f8f8),
      this.height = 40,
      this.width = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Container(
        height: height,
        width: height,
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Platform.isIOS
                  ? CupertinoActivityIndicator(
                      radius: 45,
                    )
                  : CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
              Center(
                child: Image.asset(
                  AppConfig.of(context).config.appIcon,
                  height: 40,
                  width: 40,
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
