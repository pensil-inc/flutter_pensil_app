import 'package:flutter/material.dart';

class PFlatButton extends StatelessWidget {
  const PFlatButton(
      {Key key,
      this.onPressed,
      this.label,
      this.isLoading,
      this.color,
      this.isWraped = false,
      this.isColored = true})
      : super(key: key);
  final Function onPressed;
  final String label;
  final ValueNotifier<bool> isLoading;
  final bool isWraped;
  final bool isColored;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isWraped ? null : double.infinity,
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoading ?? ValueNotifier(false),
        builder: (context, loading, child) {
          return FlatButton(
            disabledColor: Theme.of(context).disabledColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: !isColored ? null : color ?? Theme.of(context).primaryColor,
            splashColor: Theme.of(context).colorScheme.background,
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: loading ? null : onPressed,
            child: loading
                ? SizedBox(
                    height: 15,
                    width: 15,
                    child: FittedBox(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            color ?? Theme.of(context).primaryColor),
                      ),
                    ),
                  )
                : child,
          );
        },
        child: Text(
          label,
          style: Theme.of(context).textTheme.button.copyWith(color: Colors.white)
        ),
      ),
    );
  }
}
