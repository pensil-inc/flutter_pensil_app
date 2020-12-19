import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/states/auth/auth_state.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/page/auth/login.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class HomeScaffold<T> extends StatelessWidget {
  const HomeScaffold(
      {Key key,
      this.floatingActionButton,
      this.floatingButtons,
      this.showFabButton,
      this.slivers,
      this.onNotificationTap,
      this.builder})
      : super(key: key);
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Widget floatingActionButton;
  final Widget floatingButtons;
  final ValueNotifier<bool> showFabButton;
  final Function onNotificationTap;
  final List<Widget> slivers;
  void deleteBatch(context) async {
    Alert.yesOrNo(context,
        message: "Are you sure, you want to logout ?",
        title: "Message",
        barrierDismissible: true,
        onCancel: () {}, onYes: () async {
      Provider.of<HomeState>(context, listen: false).logout();
      Provider.of<AuthState>(context, listen: false).logout();
      Navigator.pushReplacement(context, LoginPage.getRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Image.asset(AppConfig.of(context).config.appIcon).p(8),
          title: Title(
              color: PColors.black,
              child: Text(AppConfig.of(context).config.appName)),
          actions: <Widget>[
            IconButton(
              onPressed: onNotificationTap,
              icon: Icon(Icons.notifications_none),
            ),
            IconButton(
              onPressed: () {
                deleteBatch(context);
              },
              icon: Icon(Icons.login),
            ),
          ]),
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: <Widget>[
          Consumer<T>(
            builder: (context, state, child) {
              return builder(context, state, child);
            },
          ),
          AnimatedPositioned(
            bottom: 16 + 60.0,
            right: 25,
            duration: Duration(milliseconds: 500),
            child: floatingButtons ?? SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
