import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_version/get_version.dart';
import '../../../common/tools.dart';
import '../../../locator.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../tabbar.dart';
import '../../constants/loading.dart';
import '../../screens/email-verification/not_verified_screen.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/testScreen/test_screen.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Api _api = locator<Api>();
  @override
  void initState() {
    super.initState();

    _api.getMe().then((user) {
      if (user.isUserVerified == false) {
        Get.offAll(() => NotVerifiedScreen(user: user));
      }
    });
  }

  Future<String> getAppVersion() async {
    //
    var responses =
        await Future.wait([GetVersion.projectVersion, GetVersion.projectCode]);

    final projVer = responses[0];
    final projCode = responses[1];

    return '$projVer+$projCode';
  }

  StorageService storageService = locator<StorageService>();

  Future<User> getUserFromSharedPrefs() async {
    return storageService.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          FutureBuilder(
            future: getUserFromSharedPrefs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                User user = snapshot.data!;
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    user.name ?? 'No Name',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                  accountEmail: Text(
                    user.email ?? 'Loading',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 15),
                  ),
                  currentAccountPicture: GestureDetector(
                    onTap: () {},
                    child: Tools.getCachedAvatar(
                      user.photoUrl!,
                    ),
                  ),
                );
              }
              return kLoadingWidget(context);
            },
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed('/Pages', arguments: 2);
              MainTabControlDelegate.getInstance().index = 0;
              Get.offAll(() => MainTabs());
            },
            leading: Icon(
              FontAwesomeIcons.house,
              color: MedUI.primaryBrandColor,
            ),
            title: Text(
              'Dashboard',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     // Navigator.of(context).pushNamed('/Pages', arguments: 2);
          //     MainTabControlDelegate.getInstance().index = 0;
          //     // Get.to(ResultScreen());
          //   },
          //   leading: Icon(
          //     FontAwesomeIcons.home,
          //     color: Colors.black,
          //   ),
          //   title: Text(
          //     'Result',
          //     style: Theme.of(context).textTheme.subtitle1,
          //   ),
          // ),
          ListTile(
            onTap: () {
              Get.back();
              Get.to(MyTestScreen());
              // return MyTestScreen();
              // Navigator.of(context).pushNamed(RoutePaths.Help);
            },
            leading: Icon(
              FontAwesomeIcons.exclamation,
              color: MedUI.primaryBrandColor,
            ),
            title: Text(
              "Take Test",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () {
              print('Notification tapped');
              // Navigator.of(context).pushNamed(RoutePaths.Pages, arguments: 0);
              MainTabControlDelegate.getInstance().index = 1;
              Get.offAll(() => MainTabs());
            },
            leading: Icon(
              FontAwesomeIcons.bell,
              color: MedUI.primaryBrandColor,
            ),
            title: Text(
              'Notifications',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     // Navigator.of(context).pushNamed(RoutePaths.Pages, arguments: 3);
          //     // Get.to(OrderScreen());
          //   },
          //   leading: Icon(
          //     FontAwesomeIcons.coffee,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'My Orders',
          //     style: Theme.of(context).textTheme.subtitle1,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     // Navigator.of(context).pushNamed(RoutePaths.Pages, arguments: 4);

          //     // Get.to(FavoriteScreen());
          //   },
          //   leading: Icon(
          //     FontAwesomeIcons.heart,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Favorites',
          //     style: Theme.of(context).textTheme.subtitle1,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     // Navigator.of(context).pushNamed(RoutePaths.Pages, arguments: 4);

          //     // Get.to(PhotoGalleryScreen());
          //   },
          //   leading: Icon(
          //     FontAwesomeIcons.photoVideo,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Photo Gallery',
          //     style: Theme.of(context).textTheme.subtitle1,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     // Navigator.of(context).pushNamed(RoutePaths.Pages, arguments: 4);

          //     // Get.to(
          //     //   VideoTutorialScreen(),
          //     // );
          //   },
          //   leading: Icon(
          //     FontAwesomeIcons.video,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Video Tutorials',
          //     style: Theme.of(context).textTheme.subtitle1,
          //   ),
          // ),
          ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.4),
            ),
          ),

          // ListTile(
          //   onTap: () {
          //     // Navigator.of(context).pushNamed(RoutePaths.Help);
          //     MainTabControlDelegate.getInstance().index = 3;
          //     Get.offAll(() => MainTabs());
          //   },
          //   leading: Icon(
          //     FontAwesomeIcons.question,
          //     color: MedUI.primaryBrandColor,
          //   ),
          //   title: Text(
          //     "Discussions",
          //     style: Theme.of(context).textTheme.subtitle1,
          //   ),
          // ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed('/Settings');
              MainTabControlDelegate.getInstance().index = 3;
              Get.offAll(() => MainTabs());
            },
            leading: Icon(
              FontAwesomeIcons.wrench,
              color: MedUI.primaryBrandColor,
            ),
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     HapticFeedback.mediumImpact();
          //   },
          //   leading: Icon(
          //     Icons.brightness_6,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     Theme.of(context).brightness == Brightness.dark
          //         ? "Light Mode"
          //         : "Dark Mode",
          //     style: Theme.of(context).textTheme.subtitle1,
          //   ),
          // ),

          ListTile(
            onTap: () async {
              showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Do you really want to logout ?',
                          style: TextStyle(color: Colors.black)),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            StorageService storageService =
                                locator<StorageService>();
                            storageService.clearUser();

                            Get.offAll(() => LoginScreen());
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    ),
                  );
            },
            leading: Icon(
              FontAwesomeIcons.circleRight,
              color: MedUI.primaryBrandColor,
            ),
            title: Text(
              "Log out",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          FutureBuilder<String>(
              future: getAppVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    dense: true,
                    title: Text(
                      "Version ${snapshot.data}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    trailing: Icon(
                      Icons.remove,
                      color: Theme.of(context).focusColor.withOpacity(0.4),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ],
      ),
    );
  }
}
