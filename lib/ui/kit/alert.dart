import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';

class Alert {
  static void sucess(BuildContext context, {String message, String title, double height = 150}) async {
    final theme = Theme.of(context);
    await showDialog(
      context: context,
      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
          height: height, //MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 16),
              Text(
                message,
                style: Theme.of(context).typography.dense.bodyText2.copyWith(
                      color: Colors.black,
                    ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Theme.of(context).primaryColor,
                child: Text("OK", style: theme.textTheme.button.copyWith(color: theme.colorScheme.onPrimary)),
              )
            ],
          ),
        ),
      ),
    );
  }

  static void yesOrNo(BuildContext context, {String message, String title, Function onYes, Function onCancel}) async {
    await showDialog(
      context: context,
      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
          height: 150, //MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(title, style: Theme.of(context).typography.dense.headline5.copyWith(color: Colors.black)),
              SizedBox(height: 16),
              Text(message, style: Theme.of(context).typography.dense.bodyText2.copyWith(color: Colors.black), textAlign: TextAlign.center),
              Spacer(),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                buttonAlignedDropdown: true,
                buttonPadding: EdgeInsets.all(0),
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Sign In", textAlign: TextAlign.center),
                    elevation: 5,
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static void dialog(
    BuildContext context, {
    String title,
    Widget child,
    Function onPressed,
    Color titleBackGround = PColors.orange,
    String buttonText = "Ok",
  }) async {
    final theme = Theme.of(context);
    await showDialog(
      barrierDismissible: false,
      context: context,
      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Wrap(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                          color: titleBackGround,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                      child: Row(
                        children: [
                          Text(title, style: Theme.of(context).textTheme.headline5.copyWith(color: theme.colorScheme.onPrimary)),
                          Spacer(),
                          Image.asset(Images.cross, height: 30).p(8).ripple(() {
                            Navigator.pop(context);
                          })
                        ],
                      )),
                  child,
                  SizedBox(
                    height: 12,
                  ),
                  PFlatButton(
                    label: buttonText,
                    onPressed: onPressed,
                  ).hP16
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
