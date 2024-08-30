// ignore_for_file: unnecessary_null_comparison

import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'common/constants.dart';
import 'common/tools.dart';
import 'locator.dart';
import 'services/storage_service.dart';
import 'ui/screens/account/account_screen.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/screens/notification/notification_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'ui/screens/programSelection/programSelectionv2.dart';
import 'ui/screens/workout/workout_screen.dart';
import 'ui/widgets/drawer/drawer_widget.dart';

const int tabCount = 3;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;

class MainTabControlDelegate {
  late int index;

  late void Function(String nameTab) changeTab;
  late void Function(int index) tabAnimateTo;

  static MainTabControlDelegate? _instance;
  static MainTabControlDelegate getInstance() {
    return _instance ??= MainTabControlDelegate._();
  }

  MainTabControlDelegate._() {
    index = 0;
    changeTab = (String nameTab) {};
    tabAnimateTo = (int index) {};
  }
}

class MainTabs extends StatefulWidget {
  @override
  MainTabsState createState() => MainTabsState();
}

class MainTabsState extends State<MainTabs>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  // Api _api = locator<Api>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? tabController;

  StorageService _storageService = locator<StorageService>();

  Map saveIndexTab = Map();

  var tabData;

  final List<Widget> _tabView = [];

  // Socket Variables
  late io.Socket socket;
  late io.Socket roomSocket;

  @override
  void afterFirstLayout(BuildContext context) {
    loadTabBar(context);
  }

  void loadTabBar(context) {
    tabData = [
      {
        "layout": "home",
        "icon": "assets/icons/tabs/icon-home.png",
      },
      {
        "layout": "notification",
        "icon": "assets/icons/tabs/icon-category.png",
      },
      {
        "layout": "payment",
        "icon": "assets/icons/tabs/icon-search.png",
      },
      // {
      //   "layout": "message",
      //   "icon": "assets/icons/tabs/icon-cart2.png",
      // },
      {
        "layout": "account",
        "icon": "assets/icons/tabs/icon-user.png",
      }
    ];

    setState(() {
      tabController = TabController(length: tabData.length, vsync: this);
    });

    if (MainTabControlDelegate.getInstance().index != null) {
      tabController!.animateTo(MainTabControlDelegate.getInstance().index);
    } else {
      MainTabControlDelegate.getInstance().index = 0;
    }

    tabController!.addListener(() {
      MainTabControlDelegate.getInstance().index = tabController!.index;
    });

    for (var i = 0; i < tabData.length; i++) {
      Map<String, dynamic> _dataOfTab = Map.from(tabData[i]);
      saveIndexTab[_dataOfTab['layout']] = i;

      setState(() {
        _tabView.add(tabView(_dataOfTab));
      });
    }
  }

  void changeTab(String nameTab) {
    tabController?.animateTo(saveIndexTab[nameTab] ?? 0);
  }

  Future<void> checkDefaultProgramForUser() async {
    // Fetch user from stored data

    final storedUser = await _storageService.getUser();

    // Check if that program id exit there or not

    if (storedUser.selectedProgram == null ||
        (storedUser.selectedProgram is String &&
            storedUser.selectedProgram!.isEmpty)) {
      // SHow that Screen
      Get.to(ProgramSelectV2());
    }

    // Check if program exist in database or not

    // If it does not exist there we need to show screen
  }

  @override
  void initState() {
    super.initState();

    // Check If Program exists For User or Not
    checkDefaultProgramForUser();

    Utils.setStatusBarWhiteForeground(false);

    MainTabControlDelegate.getInstance().changeTab = changeTab;
    MainTabControlDelegate.getInstance().tabAnimateTo = (int index) {
      tabController?.animateTo(index);
    };

    initSocket();
    // _api.getPrograms();
  }

  void initSocket() {
    socket = io.io('$SOCKET_ENDPOINT', <String, dynamic>{
      'transports': ['websocket']
    });

    _storageService.getUser().then((user) {
      socket.on('connect', (_) {
        print('SOCKET: COnnection: $SOCKET_ENDPOINT');
        socket.emit('goOnline', user.id);
      });
    });
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    if (_tabView.isEmpty) {
      return Container(
        color: Colors.white,
        child: kLoadingWidget(context),
      );
    }

    return Container(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        drawer: DrawerWidget(),
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) {
              return;
            }
            if (tabController!.index != 0) {
              tabController!.animateTo(0);
            } else {
              final result = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: AutoSizeText('Are you sure?',
                      style: TextStyle(color: Colors.black)),
                  content: AutoSizeText(
                    'Do you want to exit the application?',
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: AutoSizeText('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: AutoSizeText('Yes'),
                    ),
                  ],
                ),
              );
              if (result ?? false) {
                SystemNavigator.pop();
              }
            }
          },
          child: TabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: _tabView,
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Container(
            color: Theme.of(context).primaryColor,
            width: screenSize.width,
            child: FittedBox(
              child: Container(
                width: screenSize.width /
                    (2 / (screenSize.height / screenSize.width)),
                child: TabBar(
                  onTap: (_) {
                    HapticFeedback.mediumImpact();
                  },
                  controller: tabController,
                  isScrollable: false,
                  labelColor: Theme.of(context).primaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding:
                      EdgeInsets.only(bottom: 2, left: 8, right: 8, top: 4),
                  indicatorColor: Colors.black.withOpacity(0.6),
                  tabs: renderTabbar(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> renderTabbar() {
    var totalCart = 0;
    var unseenNotifications = 0;

    List<Widget> list = [
      Container(
        width: 35,
        padding: const EdgeInsets.all(6.0),
        margin: const EdgeInsets.only(bottom: 6.0),
        child: Image.asset(
          'assets/icons/tabs/icon-home.png',
          color: MedUI.primaryBrandColor,
          width: 24,
        ),
      ),
      Stack(
        children: <Widget>[
          Container(
            width: 35,
            padding: const EdgeInsets.all(6.0),
            margin: const EdgeInsets.only(bottom: 6.0),
            child: Icon(
              FontAwesomeIcons.bell,
              color: MedUI.primaryBrandColor,
              size: 20,
            ),
          ),
          if (unseenNotifications > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: AutoSizeText(
                  totalCart.toString(),
                  style: TextStyle(
                    color: MedUI.primaryBrandColor,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
        ],
      ),
      Container(
        width: 35,
        padding: const EdgeInsets.all(6.0),
        margin: const EdgeInsets.only(bottom: 6.0),
        child: Icon(
          FontAwesomeIcons.ravelry,
          color: MedUI.primaryBrandColor,
          size: 20,
        ),
      ),
      // Stack(
      //   children: <Widget>[
      //     // Container(
      //     //   width: 35,
      //     //   padding: const EdgeInsets.all(6.0),
      //     //   margin: const EdgeInsets.only(bottom: 6.0),
      //     //   child: Icon(
      //     //     FontAwesomeIcons.inbox,
      //     //     color: MedUI.primaryBrandColor,
      //     //     size: 20,
      //     //   ),
      //     // ),
      //     if (totalCart > 0)
      //       Positioned(
      //         right: 0,
      //         top: 0,
      //         child: Container(
      //           padding: const EdgeInsets.all(1),
      //           decoration: BoxDecoration(
      //             color: Colors.red,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           constraints: BoxConstraints(
      //             minWidth: 16,
      //             minHeight: 16,
      //           ),
      //           child: AutoSizeText(
      //             totalCart.toString(),
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 12,
      //             ),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //       )
      //   ],
      // ),
      Container(
        width: 35,
        padding: const EdgeInsets.all(6.0),
        margin: const EdgeInsets.only(bottom: 6.0),
        child: Image.asset(
          'assets/icons/tabs/icon-user.png',
          color: MedUI.primaryBrandColor,
          width: 24,
        ),
      ),
    ];

    return list;
  }

  Widget tabView(Map<String, dynamic> data) {
    switch (data['layout']) {
      case 'notification':
        return NotificationScreen();
      // return CategoriesScreen(
      //   key: Key("category"),
      //   layout: data['categoryLayout'],
      //   categories: data['categories'],
      //   images: data['images'],
      // );
      case 'payment':
        return WorkoutScreen();
      // return SearchScreen(
      //   key: Key("search"),
      // );
      // case 'message':
      //   // return CartScreen();
      //   return DiscussionScreen();
      case 'account':
        return AccountScreen();
      // return UserScreen(
      //     settings: data['settings'], background: data['background']);
      case 'blog':
        return Container(
          child: Center(
            child: AutoSizeText('Blog'),
          ),
        );
      // return HorizontalSliderList(config: data);
      case 'wishlist':
        return Container(
          child: Center(
            child: AutoSizeText('Wishlist'),
          ),
        );
      // return screen.WishList(
      //   canPop: false,
      // );

      case 'dynamic':
      default:
        return Container(
          child: Center(
            child: HomeScreen(),
          ),
        );
    }
  }

  kLoadingWidget(BuildContext context) {}
}
