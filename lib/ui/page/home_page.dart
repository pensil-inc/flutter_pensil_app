import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/page/create_batch.dart';
import 'package:flutter_pensil_app/ui/theme/light_color.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

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
                Navigator.push(
                    context, CreateBatch.getRoute());
              },
              color: Theme.of(context).primaryColor,
              child: Text("Create Batch"),
            )
          ],
        ),
      ),
    );
  }
}
