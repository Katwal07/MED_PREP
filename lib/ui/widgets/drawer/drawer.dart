import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_version/get_version.dart';
import '../../../common/tools.dart';
import '../../../tabbar.dart';
import '../../screens/login/login_screen.dart';

class MYyDrawer extends StatefulWidget {
  @override
  _MYyDrawerState createState() => _MYyDrawerState();
}

class _MYyDrawerState extends State<MYyDrawer> {
  Future<String> getAppVersion() async {
    var responses =
        await Future.wait([GetVersion.projectVersion, GetVersion.projectCode]);

    final projVer = responses[0];
    final projCode = responses[1];

    return Future.value('$projVer+$projCode');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            MediaQuery.of(context).size.width / 1.8,
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width / 1.8,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
            ),
            accountName: AutoSizeText(
              'BitpointX Test User',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.black),
            ),
            accountEmail: AutoSizeText(
              'client@bitpointx.com.au',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
            ),
            currentAccountPicture: GestureDetector(
                onTap: () {},
                child: Tools.getCachedAvatar(
                    'https://www.w3schools.com/w3images/avatar2.png')),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed('/Pages', arguments: 2);
              MainTabControlDelegate.getInstance().index = 0;
              Get.offAll(() => MainTabs());
            },
            leading: Icon(
              FontAwesomeIcons.house,
              color: Colors.black,
            ),
            title: AutoSizeText(
              'Dashboard',
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
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: AutoSizeText(
              'Notifications',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            dense: true,
            title: AutoSizeText(
              "Application Preferences",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.4),
            ),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed(RoutePaths.Help);
              MainTabControlDelegate.getInstance().index = 3;
              Get.offAll(() => MainTabs());
            },
            leading: Icon(
              FontAwesomeIcons.question,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: AutoSizeText(
              "Discussions",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed('/Settings');
              MainTabControlDelegate.getInstance().index = 4;
              Get.offAll(() => MainTabs());
            },
            leading: Icon(
              FontAwesomeIcons.wrench,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: AutoSizeText(
              "Settings",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () {
              Get.offAll(() => LoginScreen());
            },
            leading: Icon(
              FontAwesomeIcons.circleRight,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: AutoSizeText(
              "Log out",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          FutureBuilder<String>(
              future: getAppVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  return ListTile(
                    dense: true,
                    title: AutoSizeText(
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
    ));
  }
}
