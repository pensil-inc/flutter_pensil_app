import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/widget/form/validator.dart';

enum Type { name, email, phone, password, confirmPassword, reset, text }

class PTextField extends StatelessWidget {
  const PTextField(
      {Key key,
      this.controller,
      this.label,
      @required this.type,
      this.maxLines = 1,
      this.hintText = ''})
      : super(key: key);
  final TextEditingController controller;
  final String label, hintText;
  final Type type;
  final int maxLines;
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label ?? "", style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 5),
        Container(
          height: 70,
          child: TextFormField(
            autocorrect: false,
            obscureText: (type == Type.password || type == Type.confirmPassword)
                ? true
                : false,
            maxLines: maxLines,
            keyboardType: getKeyboardType(type),
            controller: controller ?? TextEditingController(),
            decoration: getInputDecotration(context, hintText: hintText),
            textInputAction: (type == Type.password ||
                    type == Type.reset ||
                    type == Type.confirmPassword)
                ? TextInputAction.done
                : TextInputAction.next,
            validator: validators(type, context),
          ),
        ),
      ],
    );
  }

  InputDecoration getInputDecotration(context, {String hintText}) {
    return InputDecoration(
      // helperText: '',
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      ),
    );
  }

  TextInputType getKeyboardType(Type choice) {
    switch (choice) {
      case Type.name:
        return TextInputType.text;
      case Type.email:
        return TextInputType.emailAddress;
      case Type.password:
        return null;
      case Type.confirmPassword:
        return null;
      case Type.phone:
        return TextInputType.phone;
      case Type.reset:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  Function(String) validators(Type choice, BuildContext context) {
    switch (choice) {
      case Type.name:
        return PValidator.buildValidators(context, choice);
      case Type.email:
        return PValidator.buildValidators(context, choice);
      case Type.password:
        return PValidator.buildValidators(context, choice);
      case Type.phone:
        return PValidator.buildValidators(context, choice);
      case Type.confirmPassword:
        return PValidator.buildValidators(context, choice);
      case Type.reset:
        return PValidator.buildValidators(context, choice);
      default:
        return PValidator.buildValidators(context, choice);
    }
  }
}