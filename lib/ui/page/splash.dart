import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/ui/page/announcement/create_announcement.dart';
import 'package:flutter_pensil_app/ui/page/auth/login.dart';
import 'package:flutter_pensil_app/ui/page/auth/signup.dart';
import 'package:flutter_pensil_app/ui/page/create_batch/create_batch.dart';
import 'package:flutter_pensil_app/ui/page/home/home_page.dart';
import 'package:flutter_pensil_app/ui/theme/light_color.dart';
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
    doAutoLogin();
  }
   void doAutoLogin() async {
    final getIt = GetIt.instance;
    final prefs = getIt<SharedPrefrenceHelper>();
    final accessToken = await prefs.getAccessToken();
    if (accessToken != null) {
      print("***************** Auto Login ***********************");
      Navigator.of(context)
          .pushAndRemoveUntil(HomePage.getRoute(), (_) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: PColors.black, child: Text("Home page")),
      ),
      body: Container(
        width: AppTheme.fullWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.push(context, LoginPage.getRoute());
              },
              color: Theme.of(context).primaryColor,
              child: Text("Login"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context, SignUp.getRoute());
              },
              color: Theme.of(context).primaryColor,
              child: Text("Signup"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context, CreateBatch.getRoute());
              },
              color: Theme.of(context).primaryColor,
              child: Text("Create Batch"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context, CreateAnnouncement.getRoute());
              },
              color: Theme.of(context).primaryColor,
              child: Text("Create Announement"),
            )
          ],
        ),
      ),
    );
  }
}
