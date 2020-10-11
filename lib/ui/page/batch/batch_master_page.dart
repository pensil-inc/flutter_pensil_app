import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
class BatchMasterDetailPage extends StatefulWidget {
  BatchMasterDetailPage({Key key}) : super(key: key);
  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(builder: (_) => BatchMasterDetailPage());
  }

  @override
  _BatchMasterDetailPageState createState() => _BatchMasterDetailPageState();
}

class _BatchMasterDetailPageState extends State<BatchMasterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: _floatingActionButton(),
      appBar: AppBar(
        title: Title(color: PColors.black, child: Text("Student Home page")),
        actions:<Widget>[
          Center(
            child: SizedBox(
              height:40,
              child: OutlineButton(
                onPressed: (){
                },
                child:Text("Sign out")
              ),
            ),
          ).hP16,
        ]
      ),body:
      Container(
       
    ));
  }
}