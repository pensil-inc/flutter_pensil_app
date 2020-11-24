import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';

class StudentListPreview extends StatelessWidget {
  const StudentListPreview({Key key, this.list}) : super(key: key);
  final List<ActorModel> list;

  Positioned _wrapper(context, {Widget child, int index}) {
    return Positioned(
      right: 20 * index * 1.0,
      child: Container(
          height: 25,
          width: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimary, width: 2),
              borderRadius: BorderRadius.circular(40)),
          child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return SizedBox.shrink();
    }
    final theme = Theme.of(context);
    return Container(
      width: 150,
      height: 30,
      alignment: Alignment.centerRight,
      child: Stack(
        children: Iterable.generate(list.length > 3 ? 4 : list.length, (index) {
          if (list.length > 3 && index == 0) {
            return _wrapper(context,
                index: index,
                child: Text("+${list.length - 3}",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onPrimary)));
          }
          return _wrapper(
            context,
            index: index,
            child: Text(
              list[index].name.substring(0, 2).toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 10, color: Theme.of(context).colorScheme.onPrimary),
            ),
          );
        }).toList(),
      ),
    );
  }
}
