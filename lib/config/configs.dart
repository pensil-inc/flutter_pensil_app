import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/constants.dart';
import 'package:flutter_pensil_app/helper/images.dart';

class Configs {
  static devConfig() => Config(
        appName: 'Pensil [DEV]',
        appIcon: Images.logo,
        apiBaseUrl: Constants.productionBaseUrl,
        appToken: '',
        apiLogging: true,
        diagnostic: true,
      );

  static bramhAppConfig() => Config(
        appName: 'Brahm IAS',
        appIcon: Images.logoBramh,
        apiBaseUrl: Constants.bramhAppBaseUrl,
        appToken: '',
        apiLogging: false,
        diagnostic: false,
      );
  static shaanAppConfig() => Config(
        appName: 'Shaan IAS Academy',
        appIcon: Images.logoShaan,
        apiBaseUrl: Constants.shaanAppBaseUrl,
        appToken: '',
        apiLogging: false,
        diagnostic: false,
      );
  static sucessHaryanaAppConfig() => Config(
        appName: 'Success Haryana',
        appIcon: Images.logoSucessHaryana,
        apiBaseUrl: Constants.sucessHaryanaAppBaseUrl,
        appToken: '',
        apiLogging: false,
        diagnostic: false,
      );
  static prefqaceAppConfig() => Config(
        appName: 'Preface IAS Coaching',
        appIcon: Images.logoPreface,
        apiBaseUrl: Constants.prefaceAppBaseUrl,
        appToken: '',
        apiLogging: false,
        diagnostic: false,
      );
}
