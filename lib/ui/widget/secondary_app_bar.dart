import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  CustomAppBar(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          Navigator.pop(context);
        },
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      title: Title(
        color: Theme.of(context).colorScheme.onPrimary,
        child: Text(
          "Create Batch",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
