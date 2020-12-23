import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/states/auth/auth_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/page/auth/update_password.dart';
import 'package:flutter_pensil_app/ui/page/auth/widgets/Otp_widget.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  VerifyOtpScreen({Key key, this.onSucess}) : super(key: key);
  final Function onSucess;
  static MaterialPageRoute getRoute({Function onSucess}) {
    return MaterialPageRoute(
      builder: (_) => VerifyOtpScreen(onSucess: onSucess),
    );
  }

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController email;
  TextEditingController name;
  TextEditingController password;
  TextEditingController mobile;

  @override
  void initState() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    mobile = TextEditingController();
    super.initState();
  }

  Widget _title(String text) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        left: 16,
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontSize: 26, color: Colors.white),
      ),
    );
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
      isLoading.value = true;
      final isSucess = await state.verifyOtp();
      if (isSucess != null && isSucess) {
        widget.onSucess();
      } else {
        Alert.sucess(
          context,
          message: "Some error occured. Please try again in some time!!",
          title: "Message",
          height: 170,
        );
      }
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      print("SCreen ${error.message}");
      Utility.displaySnackbar(context, msg: error.message, key: scaffoldKey);
    }
    print("End");
  }

  Widget _form(BuildContext context) {
    final theme = Theme.of(context);
    final state = Provider.of<AuthState>(context, listen: false);
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
            offset: Offset(4, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Image.asset(AppConfig.of(context).config.appIcon, height: 150),
            // Image.asset(Images.logoText, height: 30),
            SizedBox(height: 10),
            Text(
              "Please enter OTP we’ve sent you on ${state.email ?? state.mobile}",
              style: theme.textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ).hP16,
            SizedBox(height: 10),
            SizedBox(height: 10),
            Consumer<AuthState>(
              builder: (context, state, child) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: OTPTextField(
                    clearOTP: true,
                    onSubmitted: (val) {
                      print(val);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PFlatButton(
                  label: "Verify",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: PColors.white,
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
                      SizedBox(height: 120),
                      _title("Verify OTP"),
                      _form(context),
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
