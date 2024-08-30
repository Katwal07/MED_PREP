// ignore_for_file: unnecessary_null_comparison

import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

import '../../../enums/viewstate.dart';
import '../../viewmodels/notification_model.dart';
import '../../widgets/notification/notification_shimmer.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AfterLayoutMixin<NotificationScreen>, AutomaticKeepAliveClientMixin {
  _onRefresh() async {
    HapticFeedback.mediumImpact();
    await Provider.of<NotificationModel>(context, listen: false)
        .fetchNotifications(context);

    _refreshController.refreshCompleted();
  }

  late ScrollController _controller;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() async {
    // start loadMore when maxScrollExtent

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('Reached Max Extend');
      int x = await Provider.of<NotificationModel>(context, listen: false)
          .fetchMoreNotification();

      print(x);

      if (x == 0) {
        _refreshController.loadNoData();
      } else {
        _refreshController.resetNoData();
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    super.build(context);
    final screenSize = MediaQuery.of(context).size;
    final notificationModel = Provider.of<NotificationModel>(context);

    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            width: screenSize.width,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Container(
                width: screenSize.width /
                    (2 / (screenSize.height / screenSize.width)),
                child: Padding(
                  child: AutoSizeText(
                    'Notifications',
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    bottom: 20,
                    right: 10,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: LayoutBuilder(
            builder: (context, constraints) {
              if (notificationModel.state == ViewState.Busy ||
                  notificationModel.notifications == null) {
                return ListView.builder(
                  itemBuilder: (context, index) => NotificationShimmer(),
                  itemCount: 6,
                );
              }

              if (notificationModel.notifications.notifications.length == 0) {
                return ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    SvgPicture.asset(
                      'assets/images/empty_prod.svg',
                      width: size.width * 0.6,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: AutoSizeText(
                        'No notification found!',
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                onRefresh: _onRefresh,
                child: ListView.builder(
                  controller: _controller,
                  itemCount: notificationModel.notifications == null
                      ? 0
                      : notificationModel.notifications.notifications.length,
                  itemBuilder: (context, index) {
                    DateTime createdAt = DateTime.parse(notificationModel
                        .notifications.notifications[index].createdAt!);
                    return Padding(
                      child: Card(
                        color: Theme.of(context).cardTheme.color,
                        child: ListTile(
                          onTap: () {
                            // if (notificationModel.notifications
                            //         .notifications[index].screen ==
                            //     'order') {
                            //   print(notificationModel.notifications
                            //       .notifications[index].screen);
                            //   Get.to(OrderDetailScreen(
                            //       orderId: notificationModel
                            //           .notifications
                            //           .notifications[index]
                            //           .order));
                            // }
                          },
                          title: AutoSizeText(
                            notificationModel
                                .notifications.notifications[index].title!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            children: <Widget>[
                              Padding(
                                child: AutoSizeText(
                                  notificationModel
                                      .notifications.notifications[index].body!,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                              ),
                              AutoSizeText(
                                DateFormat.yMMMd().format(createdAt),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.5)),
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          leading: Icon(FontAwesomeIcons.solidBell,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary),
                          isThreeLine: true,
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                    );
                  },
                ),
              );
            },
          )),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext ctx) {
    Future.delayed(Duration(milliseconds: 1000), () {
      Provider.of<NotificationModel>(ctx, listen: false)
          .fetchNotifications(ctx);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
