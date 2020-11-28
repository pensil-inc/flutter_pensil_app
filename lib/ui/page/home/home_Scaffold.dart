import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/states/auth/auth_state.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
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
      this.builder})
      : super(key: key);
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Widget floatingActionButton;
  final Widget floatingButtons;
  final ValueNotifier<bool> showFabButton;
  final List<Widget> slivers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Title(color: PColors.black, child: Text("Pensil Institute")),
          actions: <Widget>[
            Center(
              child: SizedBox(
                height: 40,
                child: OutlineButton(
                    onPressed: () {
                      Provider.of<HomeState>(context, listen: false).logout();
                      Provider.of<AuthState>(context, listen: false).logout();
                      Navigator.pushReplacement(context, LoginPage.getRoute());
                    },
                    child: Text("Sign out")),
              ),
            ).hP16,
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
            child: floatingButtons,
          ),
        ],
      ),
    );
  }
}
