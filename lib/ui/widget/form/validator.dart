import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';

class PValidator {
  static Function(String) buildValidators(BuildContext context, Type choice) {
    // final "Invalid =" AppLocalizations.of(context);

    Function(String) emailValidators = (String value) {
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return "Invalid invalidEmail";
      }
      if (value.isEmpty) {
        return "Invalid fieldEmptyText";
      }
      if (!value.startsWith(RegExp(r'[A-Za-z]'))) {
        return "Invalid invalidEmail";
      }
      if (value.length > 32) {
        return "Invalid emailMustBeLessThan";
      }
      if (value.length < 6) {
        return "Invalid emailIsShort";
      }
      if (!value.contains("@")) {
        return "Invalid invalidEmail";
      }
      if (!value.contains(".com")) {
        return "Invalid invalidEmail";
      }
      return null;
    };

    Function(String) nameValidators = (String value) {
      if (value.isEmpty) {
        return "Invalid fieldEmptyText";
      }
      if (value.length > 32) {
        return "Invalid nameMustBeLessThan";
      }
      if (!value.startsWith(RegExp(r'[A-za-z]'))) {
        return "Invalid invalidName";
      }
      if (value.length < 3) {
        return "Invalid invalidName";
      }
      if (value.contains(RegExp(r'[0-9]'))) {
        return "Invalid invalidName";
      }

      return null;
    };

    Function(String) phoneValidtors = (String value) {
      if (value.isEmpty) {
        return "Invalid fieldEmptyText";
      }
      if (value.length < 10) {
        return "Invalid phoneNumberMustBeLess";
      }
      if (value.contains(RegExp(r'[A-Z]')) ||
          value.contains(RegExp(r'[a-z]')) ||
          value.contains(".com")) {
        return "Invalid onlyTenDigits";
      }
      if (value.length > 10) {
        return "Invalid invalidPhoneNumber";
      }
      if (!RegExp(r"[0-9]{10}").hasMatch(value)) {
        return "Invalid invalidPhoneNumber";
      }
      if (!value.startsWith(RegExp(r"[0-9]"))) {
        return "Invalid invalidPhoneNumber";
      }
      return null;
    };

    Function(String) passwordValidators = (String value) {
      if (value.isEmpty) {
        return "Password field is required";
      }
      // else if (value.length < 8) {
      //   return "Invalid passwordLessThan";
      // }

      return null;
    };

    Function(String) confirmPasswordValidators = (String value) {
      if (value.isEmpty) {
        return "Invalid fieldEmptyText";
      } else if (value.length < 8) {
        return "Invalid passwordLessThan";
      }

      return null;
    };
    Function(String) canNotEmptyTextValidator = (String value) {
      if (value.isEmpty) {
        return "Field can not be empty";
      }
      // else if (value.length < 8) {
      //   return "Invalid passwordLessThan";
      // }

      return null;
    };
    Function(String) forgotPasswordValidators = (String value) {
      if (value.isEmpty) {
        return "Invalid fieldEmptyText";
      }
      //For Number

      if (value.startsWith(RegExp(r"[0-9]"))) {
        if (!RegExp(r"^[0-9]{10}").hasMatch(value)) {
          return "Invalid invalidPhoneNumber";
        }
        if (value.length < 10) {
          return "Invalid phoneNumberMustBeLess";
        }
        if (value.length > 10) {
          return "Invalid invalidPhoneNumber";
        }

        if (value.contains(RegExp(r'[A-Z]')) ||
            value.contains(RegExp(r'[a-z]')) ||
            value.contains(".com")) {
          return "Invalid onlyTenDigits";
        }

        return null;
      }

      //for email
      if (!value.startsWith(RegExp(r'[A-Z][a-z]'))) {
        if (!RegExp(
                r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
            .hasMatch(value)) {
          return "Invalid invalidEmail";
        }
        if (value.length > 32) {
          return "Invalid emailMustBeLessThan";
        }
        if (value.length < 6) {
          return "Invalid emailIsShort";
        }
        // if (!value.contains("@")) {
        //   return "Invalid invalidEmail";
        // }
        // if (!value.contains(".com")) {
        //   return "Invalid invalidEmail";
        // }

        return null;
      }

      return null;
    };

    if (choice == Type.name) return nameValidators;
    if (choice == Type.email) return emailValidators;
    if (choice == Type.password) return passwordValidators;
    if (choice == Type.phone) return phoneValidtors;
    if (choice == Type.confirmPassword) return confirmPasswordValidators;
    if (choice == Type.reset) return forgotPasswordValidators;
    if (choice == Type.text) return canNotEmptyTextValidator;

    return nameValidators;
  }
}
