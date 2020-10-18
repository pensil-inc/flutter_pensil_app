import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom;

class Utility {
  static void displaySnackbar(BuildContext context, {String msg = "Feature is under development", GlobalKey<ScaffoldState> key}) {
    final snackBar = SnackBar(content: Text(msg));
    if (key != null && key.currentState != null) {
      key.currentState.hideCurrentSnackBar();
      key.currentState.showSnackBar(snackBar);
    } else {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  static launchOnWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } 
  }

  static String toDMYformate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String toDMformate(DateTime date) {
    return DateFormat('dd MMM').format(date);
  }

  static String toformattedDate2(DateTime date) {
    return DateFormat('dd-MMM-yyyy hh:mm a').format(date);
  }

  static String toTimeOfDay(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static String toTimeOfDate(DateTime date) {
    return DateFormat('hh:mm a dd MMM').format(date);
  }

  static String timeFrom24(String date) {
    final hr = date.split(":")[0];
    final mm = date.split(":")[1];
    final time = DateTime(2020, 1, 1, int.parse(hr), int.parse(mm));
    return DateFormat('hh:mm a').format(time);
  }

  static String getPassedTime(String date) {
    if (date == null || date.isEmpty) {
      return '';
    }
    String msg = '';
    var dt = DateTime.parse(date).toLocal();

    if (DateTime.now().toLocal().isBefore(dt)) {
      return DateFormat.jm().format(DateTime.parse(date).toLocal()).toString();
    }

    var dur = DateTime.now().toLocal().difference(dt);
    if (dur.inDays > 0) {
      msg = '${dur.inDays} d';
      // return dur.inDays == 1 ? '1d' : DateFormat("dd MMM").format(dt);
    } else if (dur.inHours > 0) {
      msg = '${dur.inHours} h';
    } else if (dur.inMinutes > 0) {
      msg = '${dur.inMinutes} m';
    } else if (dur.inSeconds > 0) {
      msg = '${dur.inSeconds} s';
    } else {
      msg = 'now';
    }
    return msg;
  }
  static void launchURL(BuildContext context, String url) async {
    if(url == null){
      return;
    }
    try {
      await custom.launch(
        url,
        option: new custom.CustomTabsOption(
          toolbarColor: Colors.white,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new custom.CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
