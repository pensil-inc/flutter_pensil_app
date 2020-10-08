import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/resources/exceptions/exceptions.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/resources/service/session/session.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';

class SessionServiceImpl implements SessionService {
  final ApiGateway _apiGateway;
  final SharedPrefrenceHelper pref;
  SessionServiceImpl(
    this._apiGateway, 
    this.pref,
  );

  Future<void> saveSession(ActorModel session) async {
    await pref.saveUserProfile(session);
    await pref.setAccessToken(session.token);
    print("Session Save in local!!");
  }

  Future<ActorModel> loadSession() async {
    try {
      var session = await pref.getUserProfile();
      return session;
    } catch (_) {
      return null;
    }
  }

  Future<void> clearSession() async {
    await pref.cleaPrefrenceValues();
    print("Session clear");
  }

  
  @override
  Future<T> refreshSessionOnUnauthorized<T>(
      Future<T> Function() handler) async {
    try {
      return await handler();
    } on ApiUnauthorizedException catch (_) {
      final session = await loadSession();
      if (session != null) {
        await refreshSession();
        return await handler();
      } else {
        return null;
      }
    }
  }

  @override
  Future<void> refreshSession() async {
    final session = await loadSession();

//     if (session.isPresent) {
//       final request = TokenRequest(
//         clientId: _config.apiClientId,
//         scope: 'write',
//         secret: _config.apiSecretKey,
//         username: session.value.email,
//         password: session.value.password,
//         grantType: 'password',
//       );

//       final token = await _apiGateway.token(request);
//       final profile = await _profileGateway.getProfileByToken(token);
//       final updatedSession = ActorModel(
//         email: session.value.email,
//         password: session.value.password,
//         accessToken: token.access_token,
//         refreshToken: token.refresh_token,
//         tokenType: token.token_type,
//         userId: profile.result.id,
//         leClickUserId: getLeLickUserId(profile),
//       );

//       await saveSession(updatedSession);
//     } else {
//       await clearSession();
// //      throw InvalidSessionException();
//     }
  }
}
