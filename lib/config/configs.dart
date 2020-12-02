import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/constants.dart';
import 'package:flutter_pensil_app/helper/images.dart';

devConfig() => Config(
      appName: 'Pensil [DEV]',
      appIcon: Images.logo,
      apiBaseUrl: Constants.productionBaseUrl,
      appToken: '',
      apiLogging: true,
      diagnostic: true,
    );

bramhAppConfig() => Config(
      appName: 'Brahm IAS',
      appIcon: Images.logoBramh,
      apiBaseUrl: Constants.bramhAppBaseUrl,
      appToken: '',
      apiLogging: false,
      diagnostic: false,
    );
shaanAppConfig() => Config(
      appName: 'Shaan IAS Academy',
      appIcon: Images.logoShaan,
      apiBaseUrl: Constants.shaanAppBaseUrl,
      appToken: '',
      apiLogging: false,
      diagnostic: false,
    );
