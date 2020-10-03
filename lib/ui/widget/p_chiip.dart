import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class PChip extends StatelessWidget {
  const PChip(
      {Key key,
      this.label,
      this.backgroundColor,
      this.isCrossIcon,
      this.onDeleted})
      : super(key: key);
  final String label;
  final Color backgroundColor;
  final bool isCrossIcon;
  final Function onDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: AppTheme.outline(context).copyWith(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black54, width: 1.3)),
      child: Wrap(
        children: <Widget>[
          Text(label),
          if(onDeleted != null)
          ...[
            SizedBox(width: 4,),
            Icon(Icons.cancel, size: 17).ripple(onDeleted)
          ]
        ],
      ),
    );
  }
}
