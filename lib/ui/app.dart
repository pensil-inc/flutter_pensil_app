import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/states/auth/auth_state.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class PensilApp extends StatefulWidget {
  final Widget home;

  const PensilApp({
    Key key,
    @required this.home,
  }) : super(key: key);

  @override
  _PensilAppState createState() => _PensilAppState();
}

class _PensilAppState extends State<PensilApp> {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
                ChangeNotifierProvider<HomeState>(create: (_) => HomeState()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (BuildContext context) => "Pensil",
                theme: AppTheme.lightTheme,
                home: widget.home,
              ),
            );
  }
}
