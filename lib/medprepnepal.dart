// ignore_for_file: unnecessary_null_comparison, unused_field

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:med_prep/services/storage_service.dart';
import 'package:provider/provider.dart';

import 'common/constants.dart';
import 'common/firebase_cloud_messaging_wapper.dart';
import 'common/tools.dart';
import 'config/app_config.dart';
import 'config/config.dart';
import 'locator.dart';
import 'models/app.dart';
import 'models/user.dart';
import 'services/authentication_service.dart';
import 'ui/design/theme.dart';
import 'ui/screens/splash/splash_screen.dart';
import 'ui/viewmodels/notification_model.dart';
import 'ui/widgets/workout/option_container_viewmodel.dart';

class Medprepnepal extends StatefulWidget {
  // This widget is the root of your Medprepnepallication.
  @override
  _MedprepnepalState createState() => _MedprepnepalState();
}

class _MedprepnepalState extends State<Medprepnepal>
    with AfterLayoutMixin<Medprepnepal>
    implements FirebaseCloudMessagingDelegate {
  StorageService _storageService = locator<StorageService>();
  User? initialUser;
  final _app = AppModel();
  final _notification = NotificationModel();
  final _optionContainer = OptionContainerViewModel();

  Future<void> startUpLogic() async {
    final AuthenticationService _authenticationService =
        locator<AuthenticationService>();

    final user = await _storageService.getUser();
    final token =
        await _storageService.readValueFromSecureStorage(ACCESS_TOKEN_KEY);
    if (token != null && token != '' && user != null) {
      initialUser = user;
      _app.changeLoginStatus(true);
      _app.setCurrentUser(user);
    } else {
      initialUser = null;
    }
    _authenticationService.userController.add(user);
  }

  @override
  void initState() {
    Utils.setStatusBarWhiteForeground(false);
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      FirebaseCloudMessagagingWapper()
        ..init()
        ..delegate = this;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _app,
        child: Consumer<AppModel>(builder: (context, value, child) {
          if (value.isLoading) {
            return Container(
              color: Colors.white,
            );
          }
          return StreamProvider<User>(
            initialData: User(
              email: 'noemail@gmail.com',
              name: 'Unknown User',
              id: 'fjkshkjhsdjkfhdshfd',
              isUserVerified: true,
            ),
            create: (context) =>
                locator<AuthenticationService>().userController.stream,
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<NotificationModel>.value(
                    value: _notification),
                    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                // ChangeNotifierProvider<OptionContainerViewModel>.value(
                //     value: _optionContainer)
              ],
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: locator<IConfig>().flavor == Flavor.DEV
                    ? Banner(
                        color: Colors.red,
                        message: 'TEST',
                        location: BannerLocation.topStart,
                        child: ScreenUtilInit(
                          designSize: Size(428, 926),
                          builder: (ctx, _) => GetMaterialApp(
                            theme: BitpointXTheme.buildLightTheme(),
                            debugShowCheckedModeBanner: false,
                            builder: EasyLoading.init(),
                            home: SplashScreen(),
                          ),
                        ),
                      )
                    : ScreenUtilInit(
                        designSize: Size(428, 926),
                        builder: (ctx, _) => GetMaterialApp(
                          theme: BitpointXTheme.buildLightTheme(),
                          debugShowCheckedModeBanner: false,
                          builder: EasyLoading.init(),
                          home: SplashScreen(),
                        ),
                      ),
              ),
            ),
          );
        }));
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    await _app.loadAppConfig();
    await startUpLogic();
  }

  @override
  onLaunch(Map<String, dynamic> message) {
    // _saveMessage(message);
    // startNavigate(message);
  }
  @override
  onMessage(Map<String, dynamic> message) {
    // dev.();
    printLog('Received Message: $message');

    Get.snackbar(message['title'], message['body'],
        backgroundColor: Theme.of(context).colorScheme.secondary);
    // _saveMessage(message);
  }

  @override
  onResume(Map<String, dynamic> message) {
    // _saveMessage(message);
    // startNavigate(message);
  }
}
