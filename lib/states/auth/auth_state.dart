import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pensil_app/resources/exceptions/exceptions.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthState extends BaseState {
  String email;
  String password;
  String mobile;
  String name;
  String otp;

  bool isSignInWithGoogle;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  set setEmail(String value) {
    if (value.contains("@") || value.contains(".")) {
      email = value;
      mobile = null;
    } else {
      mobile = value;
      email = null;
    }
  }

  /// To set mobile no for signup and Forgot password
  set setMobile(String value) {
    mobile = value;
  }

  set setName(String value) {
    name = value;
  }

  set setPassword(String value) {
    password = value;
  }

  Future<bool> login() async {
    try {
      var model = ActorModel(email: email, password: password, mobile: mobile);
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      return await repo.login(model);
    } on ApiException catch (error) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("Login", error: error.message);
      throw (Exception(model.email ?? model.password ?? model.mobile));
    } on UnauthorisedException catch (error) {
      log("Login", error: error.message);
      throw (Exception(error.message));
    } on UnprocessableException catch (error) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("Login", error: error.message, name: "UnprocessableException");
      throw (Exception(
          model.email ?? model.password ?? model.mobile ?? model.name));
    } catch (error, strackTrace) {
      log("error", error: error, stackTrace: strackTrace);
      return false;
    }
  }

  Future<bool> register() async {
    try {
      var model = ActorModel(
          email: email, password: password, mobile: mobile, name: name);
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      return await repo.register(model);
    } on ApiException catch (error, strackTrace) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("register",
          error: error.message, stackTrace: strackTrace, name: "ApiException");
      throw (Exception(model.email ?? model.password ?? model.mobile));
    } on UnprocessableException catch (error, strackTrace) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("register",
          error: error.message,
          stackTrace: strackTrace,
          name: "UnprocessableException");
      throw (Exception(
          model.email ?? model.password ?? model.mobile ?? model.name));
    } catch (error, strackTrace) {
      log("error", error: error, stackTrace: strackTrace, name: "register");
      return false;
    }
  }

  Future<bool> updateUser() async {
    try {
      var model = ActorModel(password: password);
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      return await repo.updateUser(model);
    } on ApiException catch (error) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("Login", error: error.message);
      throw (Exception(model.email ?? model.password ?? model.mobile));
    } on UnauthorisedException catch (error) {
      log("Login", error: error.message);
      throw (Exception(error.message));
    } on UnprocessableException catch (error) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("Login", error: error.message, name: "UnprocessableException");
      throw (Exception(
          model.email ?? model.password ?? model.mobile ?? model.name));
    } catch (error, strackTrace) {
      log("error", error: error, stackTrace: strackTrace);
      return false;
    }
  }

  void saveOTP(String otp) {
    this.otp = otp;

    print("Values Saved!!");
    notifyListeners();
  }

  Future<bool> verifyOtp() async {
    try {
      var model = ActorModel(email: email, otp: otp, mobile: mobile);
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      return await repo.verifyOtp(model);
    } on ApiException catch (error, strackTrace) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("verifyOtp",
          error: error.message, stackTrace: strackTrace, name: "ApiException");
      throw (Exception(model.email ?? model.password ?? model.mobile));
    } on UnauthorisedException catch (error, strackTrace) {
      log("verifyOtp",
          error: error.message,
          stackTrace: strackTrace,
          name: "verifyOtp ApiException");
      throw Exception(error.message);
    } on UnprocessableException catch (error, strackTrace) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("UnprocessableException",
          error: error.message, stackTrace: strackTrace, name: "verifyOtp");
      throw (Exception(model.email ?? model.mobile ?? model.otp));
    } catch (error, strackTrace) {
      log("error", error: error, stackTrace: strackTrace, name: "verifyOtp");
      return false;
    }
  }

  /// Create user from `google login`
  /// If user is new then it create a new user
  /// If user is old then it just `authenticate` user and return firebase user data
  Future<bool> handleGoogleSignIn() async {
    try {
      /// Record log in firebase kAnalytics about Google login

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google login cancelled by user');
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      var user = (await _firebaseAuth.signInWithCredential(credential));
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      isSignInWithGoogle = true;
      return repo.loginWithGoogle(user.user.uid);
    } on PlatformException catch (error) {
      log("PlatformException", error: error, name: "GoogleSignIn");
      return false;
    } on ResourceNotFoundException catch (error) {
      log("ResourceNotFoundException", error: error, name: "GoogleSignIn");
      return false;
    } catch (error) {
      log("PlatformException", error: error, name: "GoogleSignIn");
      return false;
    }
  }

  Future<bool> forgetPassword() async {
    try {
      var model = ActorModel(email: email, mobile: mobile);
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      return await repo.forgotPassword(model);
    } on ApiException catch (error) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("forgetPassword", error: error.message);
      throw (Exception(model.email ?? model.password ?? model.mobile));
    } on UnauthorisedException catch (error) {
      log(
        "forgetPassword",
        error: error.message,
      );
      throw (Exception(error.message));
    } on UnprocessableException catch (error, strackTrace) {
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("forgetPassword",
          error: error.message,
          stackTrace: strackTrace,
          name: "UnprocessableException");
      throw (Exception(
          model.email ?? model.password ?? model.mobile ?? model.name));
    } catch (error, strackTrace) {
      log("error", error: error, stackTrace: strackTrace);
      return false;
    }
  }

  void clearData() {
    email = null;
    password = null;
    mobile = null;
    name = null;
    otp = null;
  }

  void logout() {
    _googleSignIn.signOut();
    _firebaseAuth.signOut();
    clearData();
  }
}
