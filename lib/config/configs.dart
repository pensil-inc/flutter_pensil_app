import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/constants.dart';

devConfig() => Config(
      appName: 'Pensil [DEV]',
      apiBaseUrl: Constants.developmentBaseUrl,
      appToken: '',
      apiLogging: true,
      diagnostic: true,
    );
stableConfig() => Config(
      appName: 'Pensil [Stable]',
      apiBaseUrl: Constants.productionBaseUrl,
      appToken: '',
      apiLogging: true,
      diagnostic: true,
    );

releaseConfig() => Config(
      appName: 'Pensil [Release]',
      apiBaseUrl: Constants.productionBaseUrl,
      appToken: '',
      apiLogging: false,
      diagnostic: false,
    );
