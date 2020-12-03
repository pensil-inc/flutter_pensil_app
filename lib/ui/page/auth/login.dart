import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/states/auth/auth_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/kit/overlay_loader.dart';
import 'package:flutter_pensil_app/ui/page/auth/forgot_password.dart';
import 'package:flutter_pensil_app/ui/page/auth/signup.dart';
import 'package:flutter_pensil_app/ui/page/auth/verify_Otp.dart';
import 'package:flutter_pensil_app/ui/page/home/home_page_student.dart';
import 'package:flutter_pensil_app/ui/page/home/home_page_teacher.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (_) => LoginPage(),
    );
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<bool> useMobile = ValueNotifier<bool>(false);

  TextEditingController email;
  TextEditingController password;
  TextEditingController mobile;
  CustomLoader loader;
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    mobile = TextEditingController();
    loader = CustomLoader();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    mobile.dispose();
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
            color: PColors.secondary,
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

  void _submit(BuildContext context) async {
    try {
      final isValidate = _formKey.currentState.validate();
      if (!isValidate) {
        return;
      }
      FocusManager.instance.primaryFocus.unfocus();
      final state = Provider.of<AuthState>(context, listen: false);
      state.setEmail = email.text;
      state.setMobile = mobile.text;
      state.setPassword = password.text;
      isLoading.value = true;
      final isSucess = await state.login();
      checkLoginStatus(isSucess);
    } catch (error) {
      print("SCreen ${error.message}");
      Utility.displaySnackbar(context, msg: error.message, key: scaffoldKey);
    }
    isLoading.value = false;
  }

  void checkLoginStatus(bool isSucess) async {
    if (isSucess) {
      // Alert.sucess(context,
      //     message: "Announcement created sucessfully!!", title: "Message");
      final getIt = GetIt.instance;
      final prefs = getIt<SharedPrefrenceHelper>();
      final isStudent = await prefs.isStudent();
      Navigator.of(context).pushAndRemoveUntil(
        isStudent ? StudentHomePage.getRoute() : TeacherHomePage.getRoute(),
        (_) => false,
      );
    } else {
      Alert.sucess(context,
          message: "Some error occured. Please try again in some time!!",
          title: "Message",
          height: 170);
      Navigator.pop(context);
    }
    loader.hideLoader();
  }

  Widget _form(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: AppTheme.fullWidth(context) - 32,
      margin: EdgeInsets.symmetric(vertical: 16) + EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xffeaeaea),
            offset: Offset(4, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Image.asset(AppConfig.of(context).config.appIcon, width: 150),
            // Image.asset(Images.logoText, height: 30),
            // SizedBox(height: 10),
            SizedBox(height: 30),
            ValueListenableBuilder<bool>(
                valueListenable: useMobile,
                builder: (context, value, child) {
                  return customSwitcherWidget(
                      duraton: Duration(milliseconds: 300),
                      child: value
                          ? PTextField(
                              key: ValueKey(1),
                              type: Type.email,
                              controller: email,
                              label: "Email ID",
                              hintText: "Enter your email id",
                              height: null,
                            ).hP16
                          : PTextField(
                              key: ValueKey(2),
                              type: Type.phone,
                              controller: mobile,
                              label: "Mobile No.",
                              height: null,
                              hintText: "Enter your mobile no",
                            ).hP16);
                }),
            ValueListenableBuilder<bool>(
                valueListenable: useMobile,
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      value ? "Use Phone Number" : "Use Email Id",
                      style: theme.textTheme.button
                          .copyWith(color: PColors.secondary, fontSize: 12),
                    ).p(8).ripple(() {
                      useMobile.value = !useMobile.value;
                      if (value) {
                        email.clear();
                      } else {
                        mobile.clear();
                      }
                    }).pR(8),
                  );
                }),
            // SizedBox(height: 10),
            PTextField(
                    type: Type.password,
                    controller: password,
                    label: "Password",
                    hintText: "Enter password here",
                    height: null)
                .hP16,
            Align(
              alignment: Alignment.centerRight,
              child: Text("Forgot password?",
                      style: theme.textTheme.button
                          .copyWith(color: PColors.secondary, fontSize: 12))
                  .p16
                  .ripple(() {
                Provider.of<AuthState>(context, listen: false).clearData();
                Navigator.push(context, ForgotPasswordPage.getRoute());
              }),
            ),
            SizedBox(height: 14),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: PFlatButton(
                  label: "Login",
                  color: PColors.secondary,
                  isLoading: isLoading,
                  onPressed: () {
                    _submit(context);
                  },
                ))
          ],
        ),
      ),
    );
  }

  Widget customSwitcherWidget(
      {@required child, Duration duraton = const Duration(milliseconds: 500)}) {
    return AnimatedSwitcher(
      duration: duraton,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      child: child,
    );
  }

  Widget _googleLogin(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: AppTheme.fullWidth(context) - 32,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xffeaeaea),
              offset: Offset(4, 4),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset("assets/images/google_icon.png", height: 30),
            Spacer(),
            Text("Continue with Google"),
            Spacer(),
          ],
        ),
      ).ripple(() async {
        loader.showLoader(context);
        var isSucess = await Provider.of<AuthState>(context, listen: false)
            .handleGoogleSignIn();
        checkLoginStatus(isSucess);
      }).p16,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
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
                      _googleLogin(context),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 150,
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                      // SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account ?",
                              style: theme.textTheme.bodyText2
                                  .copyWith(color: Colors.grey)),
                          // SizedBox(width: 10),
                          Text("SIGN UP",
                                  style: theme.textTheme.bodyText2
                                      .copyWith(fontWeight: FontWeight.bold))
                              .p16
                              .ripple(() {
                            Provider.of<AuthState>(context, listen: false)
                                .clearData();
                            Navigator.push(context, SignUp.getRoute());
                          }),
                        ],
                      ),
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
