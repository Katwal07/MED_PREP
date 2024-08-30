
import 'app_config.dart';

abstract class IConfig {
  String? esewaClientId;
  String? esewaSecretKey;
  String? khaltiSecretKey;
  String? khaltiPublicKey;
  String? environment;
  String? apiBaseUrl;
  Flavor? flavor;
}

class ProdConfig implements IConfig {
  @override
  String? esewaClientId = 'KBYBJxMWG0U3AAMEG0EjHRFXRT8RE1s9O0g8Nl4oMiUjOSAp';

  @override
  String? esewaSecretKey = 'BhwIWQwWDxULAANLEhIWHARXFhcO';
  @override
  String? khaltiSecretKey = 'live_secret_key_e4069569bc2344528b474a770055ddec';
  @override
  String? khaltiPublicKey = 'live_public_key_3dbd76ae2f3b424eb04cfb483e8146db';
  @override
  String? environment = 'ENVIRONMENT_LIVE';

  @override
  String? apiBaseUrl =
      'https://api.medprepnepal.com/medprep-node-backend/api/v1';
  // 'http://192.168.2.114:4500/api/v1';

  @override
  Flavor? flavor = Flavor.PROD;
}

class DevConfig implements IConfig {
  @override
  String? esewaClientId = 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';

  @override
  String? esewaSecretKey = 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';
  @override
  String? khaltiSecretKey = 'test_secret_key_062675ce8ac2446cb09efbaddaeae34a';
  @override
  String? khaltiPublicKey = 'test_public_key_e08c223df7fd4bcc90d5b404cc159b61';
  @override
  String? environment = 'ENVIRONMENT_TEST';

  @override
  String? apiBaseUrl = 'https://api.medprepnepal.com/api/v1';

  @override
  Flavor? flavor = Flavor.DEV;
}

class LocalConfig implements IConfig {
  @override
  String? esewaClientId = 'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';

  @override
  String? esewaSecretKey = 'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';
  @override
  String? khaltiSecretKey = 'test_secret_key_062675ce8ac2446cb09efbaddaeae34a';
  @override
  String? khaltiPublicKey = 'test_public_key_e08c223df7fd4bcc90d5b404cc159b61';
  @override
  String? environment = 'ENVIRONMENT_TEST';

  @override
  String? apiBaseUrl = 'http://192.168.2.150:9261/api/v1';

  @override
  Flavor? flavor = Flavor.LOCAL;
}
