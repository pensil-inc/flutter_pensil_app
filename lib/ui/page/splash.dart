import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/ui/page/auth/login.dart';
import 'package:flutter_pensil_app/ui/page/home/home_page_student.dart';
import 'package:flutter_pensil_app/ui/page/home/home_page_teacher.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // doAutoLogin();
  }

  void doAutoLogin() async {
    final getIt = GetIt.instance;
    final prefs = getIt<SharedPrefrenceHelper>();
    final accessToken = await prefs.getAccessToken();
    if (accessToken != null) {
      print("***************** Auto Login ***********************");
      final isStudent = await prefs.isStudent();
      Navigator.of(context).pushAndRemoveUntil(
        isStudent ? StudentHomePage.getRoute() : TeacherHomePage.getRoute(),
        (_) => false,
      );
    } else {
      Navigator.pushReplacement(context, LoginPage.getRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Container(
        height: AppTheme.fullHeight(context) - 50,
        width: AppTheme.fullWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(AppConfig.of(context).config.appIcon,
                width: AppTheme.fullWidth(context) * .7),
            // Image.asset(Images.logoText, height: 70),
          ],
        ),
      ),
    );
  }
}
