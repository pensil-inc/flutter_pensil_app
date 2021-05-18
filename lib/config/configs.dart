import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/constants.dart';
import 'package:flutter_pensil_app/helper/images.dart';

class Configs {
  static devConfig() => Config(
        appName: 'Pensil [DEV]',
        appIcon: Images.logo,
        apiBaseUrl: Constants.developmentBaseUrl,
        appToken: '',
        apiLogging: true,
        diagnostic: true,
      );

  static proConfig() => Config(
        appName: 'Pensil',
        appIcon: Images.logo,
        apiBaseUrl: Constants.productionBaseUrl,
        appToken: '',
        apiLogging: false,
        diagnostic: false,
      );
}
