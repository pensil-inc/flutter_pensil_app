import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/states/auth/auth_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/page/auth/verify_Otp.dart';
import 'package:flutter_pensil_app/ui/page/home/home_page_student.dart';
import 'package:flutter_pensil_app/ui/page/home/home_page_teacher.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (_) => SignUp(),
    );
  }

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController email;
  TextEditingController name;
  TextEditingController password;
  TextEditingController mobile;
  ValueNotifier<bool> passwordVisibility = ValueNotifier<bool>(true);

  @override
  void initState() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    mobile = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    isLoading.dispose();
    password.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    mobile.dispose();
    passwordVisibility.dispose();
    super.dispose();
  }

  Positioned _background(BuildContext context) {
    return Positioned(
      top: -AppTheme.fullHeight(context) * .5,
      left: -AppTheme.fullWidth(context) * .55,
      child: Container(
        height: AppTheme.fullHeight(context),
        width: AppTheme.fullHeight(context),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(500),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Theme.of(context).dividerColor,
                  offset: Offset(0, 4),
                  blurRadius: 5)
            ]),
      ),
    );
  }

  Widget _form(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // height: AppTheme.fullHeight(context) * .7,
      width: AppTheme.fullWidth(context) - 32,
      margin: EdgeInsets.symmetric(vertical: 32) + EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xffeaeaea),
            offset: Offset(0, -4),
            blurRadius: 10,
          )
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Image.asset(AppConfig.of(context).config.appIcon, height: 150),
            // Image.asset(Images.logoText, height: 30),
            // SizedBox(height: 10),
            SizedBox(height: 30),
            PTextField(
              type: Type.text,
              controller: name,
              label: "Name",
              hintText: "Enter name.",
            ).hP16,
            // SizedBox(height: 10),
            PTextField(
              type: Type.email,
              controller: email,
              label: "Email",
              hintText: "Enter email here",
            ).hP16,
            SizedBox(height: 10),
            PTextField(
              type: Type.phone,
              controller: mobile,
              label: "mobile",
              hintText: "Enter mobile here",
            ).hP16,
            SizedBox(height: 10),
            ValueListenableBuilder<bool>(
              valueListenable: passwordVisibility,
              builder: (context, value, child) {
                return PTextField(
                    type: Type.password,
                    controller: password,
                    label: "Password",
                    hintText: "Enter password here",
                    height: null,
                    obscureText: value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        passwordVisibility.value = !passwordVisibility.value;
                      },
                      icon:
                          Icon(value ? Icons.visibility_off : Icons.visibility),
                    )).hP16;
              },
            ),
            // SizedBox(height: 10),

            SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PFlatButton(
                  label: "Create",
                  color: PColors.secondary,
                  isLoading: isLoading,
                  onPressed: () {
                    _submit(context);
                  },
                )),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    try {
      final isValidate = _formKey.currentState.validate();
      if (!isValidate) {
        return;
      }
      final state = Provider.of<AuthState>(context, listen: false);
      state.setEmail = email.text;
      state.setName = name.text;
      state.setMobile = mobile.text;
      state.setPassword = password.text;
      isLoading.value = true;
      final isSucess = await state.register();
      if (isSucess) {
        // Alert.sucess(context,
        //     message: "An OTP is sent to your email address", title: "Message");

        Navigator.push(context, VerifyOtpScreen.getRoute(onSucess: () async {
          final getIt = GetIt.instance;
          final prefs = getIt<SharedPrefrenceHelper>();
          final isStudent = await prefs.isStudent();
          Navigator.of(context).pushAndRemoveUntil(
            isStudent ? StudentHomePage.getRoute() : TeacherHomePage.getRoute(),
            (_) => false,
          );
        }));
      } else {
        Alert.sucess(context,
            message: "Some error occured. Please try again in some time!!",
            title: "Message",
            height: 170);
      }
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      print("Signup screen ${error.message}");
      Utility.displaySnackbar(context, msg: error.message, key: scaffoldKey);
    }
    print("End");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: PColors.secondary,
      body: Container(
        height: AppTheme.fullHeight(context),
        child: SafeArea(
          top: false,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _background(context),
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _form(context),
                      SizedBox(
                        width: 150,
                        child: Divider(
                          color: theme.colorScheme.onPrimary,
                          thickness: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already have an account ?",
                              style: theme.textTheme.bodyText2
                                  .copyWith(color: Colors.white60)),
                          Text("SIGN IN",
                                  style: theme.textTheme.bodyText2.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onPrimary))
                              .p16
                              .ripple(() {
                            Provider.of<AuthState>(context, listen: false)
                                .clearData();
                            Navigator.pop(context);
                          }),
                        ],
                      ),
                      SizedBox(width: 40)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
