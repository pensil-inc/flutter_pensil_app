import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/ui/widget/secondary_app_bar.dart';

class StudentListPage extends StatelessWidget {
  static MaterialPageRoute getRoute(List<ActorModel> list) {
    return MaterialPageRoute(
      builder: (_) => StudentListPage(
        list: list,
      ),
    );
  }

  const StudentListPage({Key key, this.list}) : super(key: key);
  final List<ActorModel> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Batch Students"),
      body: Container(
          child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).cardColor,
          ),
          child: ListTile(
            title: Text(
              list[index].name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
            subtitle: Text(list[index].mobile ?? "N/A"),
            onTap: () {},
          ),
        ),
      )),
    );
  }
}
