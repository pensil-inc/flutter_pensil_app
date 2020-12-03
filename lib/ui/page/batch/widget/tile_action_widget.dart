import 'package:flutter/material.dart';

class TileActionWidget extends StatelessWidget {
  const TileActionWidget({Key key, this.onDelete, this.onEdit})
      : super(key: key);
  final Function onDelete;
  final Function onEdit;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (action) {
        switch (action) {
          case "Delete":
            onDelete();
            break;
          case "Edit":
            print("Edit");
            onEdit();
            break;
          default:
        }
      },
      padding: EdgeInsets.zero,
      offset: Offset(0, 0),
      color: Colors.white,
      itemBuilder: (BuildContext context) {
        return ["Edit", "Delete"].map((String choice) {
          return PopupMenuItem<String>(value: choice, child: Text(choice));
        }).toList();
      },
    );
  }
}
