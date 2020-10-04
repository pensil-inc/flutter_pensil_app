import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/theme/light_color.dart';

class PFlatButton extends StatelessWidget {
  const PFlatButton(
      {Key key,
      this.onPressed,
      this.label,
      this.isLoading,
      this.isWraped = false,
      this.isColored = true})
      : super(key: key);
  final Function onPressed;
  final String label;
  final ValueNotifier<bool> isLoading;
  final bool isWraped;
  final bool isColored;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isWraped ? null : double.infinity,
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoading ?? ValueNotifier(false),
        builder: (context, loading, child) {
          return FlatButton(
            disabledColor: PColors.disableButtonColor,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: !isColored ? null : Theme.of(context).primaryColor,
            splashColor: Theme.of(context).colorScheme.background,
            textColor: PColors.onPrimary,
            onPressed: loading ? null : onPressed,
            child: loading
                ? SizedBox(
                    height: 15,
                    width: 15,
                    child: FittedBox(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            PColors.primaryExtraDarkColor),
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
