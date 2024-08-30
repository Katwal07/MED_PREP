import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../enums/pre_release_state.dart';
import 'constants.dart';
import 'version.dart';

class PreReleaseCheck {
  // Check Internet Connectivity

  Dio _client = Dio();

  // Send API GET request for version check

  // Compare Current App Version with server version

  // If There is No Internet Connection Show Dialog

  // If Server Version is Greater than that of App Version

  // Tell use to update to new version.
  Version currentVersion = Version.parse(APP_VERSION_CODE);
  Version? latestVersion;
  String driveLink = '';
  Future<PreReleaseState> preReleaseVersionCheck() async {
    if (await InternetConnectionChecker().hasConnection) {
      // Pass the connection check
      // Let's make request to server;
      AppServerConfig? serverConfig =
          await getAppServerConfiguration();

      if (serverConfig == null) {
        return PreReleaseState.NoConnection;
      }
      latestVersion = Version.parse(serverConfig.version);
      driveLink = serverConfig.driveLink;
      if (latestVersion! > currentVersion) {
        return PreReleaseState.False;
      } else {
        return PreReleaseState.True;
      }
    }
    return PreReleaseState.NoConnection;
  }

  Future<AppServerConfig?>
      getAppServerConfiguration() async {
    String endpoint =
        'https://api.medprepnepal.bitpointx.com.au/api/v1/appVersion';

    try {
      final res = await _client.get(endpoint);

      return AppServerConfig.fromJson(res.data);
    } catch (err) {
      printLog('Error While Making request to server $err');
      return null;
    }
  }
}

class AppServerConfig {
  final String version;
  final String driveLink;

  AppServerConfig({
    required this.version,
    required this.driveLink,
  });

  factory AppServerConfig.fromJson(
      Map<String, dynamic> json) {
    return AppServerConfig(
      version: json['data']['version'],
      driveLink: json['data']['driveLink'],
    );
  }
}
