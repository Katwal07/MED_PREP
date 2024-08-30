// ignore_for_file: unused_element, unused_local_variable, unnecessary_null_comparison

import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:esewa_pnp/esewa.dart';
// import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

import '../../../enums/viewstate.dart';
import '../../../locator.dart';
import '../../../models/payment.dart';
import '../../../services/api_service.dart';
import '../../../tabbar.dart';
import '../../viewmodels/payment_base_model.dart';
import '../../widgets/shimmer/payment/payment_card_shimmer.dart';
import '../../widgets/shimmer/payment/payment_history_shimmer.dart';
import '../base_screen.dart';
import '../package/package_Screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with AfterLayoutMixin<PaymentScreen> {
  // ESewaPnp _esewaPnp;
  // ESewaPayment payment;
  // ESewaConfiguration _configuration;

  @override
  void initState() {
    super.initState();
    // _configuration = ESewaConfiguration(
    //   clientID:
    //       "KBYBJxMWG0U3AAMEG0EjHRFXRT8RE1s9O0g8Nl4oMiUjOSAp",
    //   secretKey: "BhwIWQwWDxULAANLEhIWHARXFhcO",
    //   environment: ESewaConfiguration.ENVIRONMENT_LIVE,
    // );
    // _esewaPnp = ESewaPnp(
    //   configuration: _configuration,
    // );
  }

  Api _api = locator<Api>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
        child: Container(
            child: ListView(children: [
      Container(
        width: screenSize.width,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Container(
            width:
                screenSize.width / (2 / (screenSize.height / screenSize.width)),
            child: Container(
              alignment: Alignment.center,
              child: AutoSizeText(
                'My Payments',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                bottom: 20,
                right: 10,
              ),
            ),
          ),
        ),
      ),
      FutureBuilder<PaymentList>(
        future: _api.getMyPayment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return PaymentCardShimmer();
          } else if (snapshot.hasData) {
            if (snapshot.data!.payments.isEmpty) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 0.6,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: AutoSizeText(
                          'Your have not subscribed yet . Please subscribe us.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                Color(0xff249DD8),
                              )),
                          onPressed: () {
                            Get.to(() => PackageScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                "Subscribe Now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.subscriptions_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 4),
                      // Center(child: AutoSizeText('8/16/2022')),
                    ],
                  ),
                ),
              );
            } else if (snapshot.data!.payments.first.paymentStatus ==
                'success') {
              DateTime dateTo =
                  DateTime.parse(snapshot.data!.payments.first.dateTo!);
              String DateTo = DateFormat.yMMMd().format(dateTo);
              Future<DateTime> current = NTP.now();
              DateTime dateFrom =
                  DateTime.parse(snapshot.data!.payments.first.dateFrom!);
              Duration remain = dateTo.difference(dateFrom);
              int remainingDays = remain.inDays;
              if (remainingDays != 0) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  elevation: 0.6,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                    height: 290,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  'Paid Date:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                AutoSizeText(
                                    DateFormat.yMMMd().format(dateFrom)),
                                AutoSizeText(
                                  'Paid From',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                AutoSizeText(
                                    snapshot.data!.payments.first.paidVia!),
                                AutoSizeText(
                                  'Valid till:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                AutoSizeText(DateFormat.yMMMd().format(dateTo)),
                              ],
                            ),
                            Column(
                              children: [
                                CircularPercentIndicator(
                                  radius: 75,
                                  progressColor: Colors.white,
                                  percent: 1,
                                  // ((model.myStat.totalCorrectAttempt /
                                  //     model.myStat.totalQuestionAttempt)),
                                  animation: true,
                                  lineWidth: 0.0,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText('Remaining:'),
                                      AutoSizeText(
                                        remainingDays.toString(),
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      AutoSizeText('Days')
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    'Payment Status',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                AutoSizeText(
                                    snapshot.data!.payments.first.paymentStatus!),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: AutoSizeText(
                            snapshot.data!.payments.first.description ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        // Center(child: AutoSizeText('8/16/2022')),
                      ],
                    ),
                  ),
                );
              } else if (remainingDays <= 0) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  elevation: 0.6,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: AutoSizeText(
                            'Your subscription has been Expired . To subscribe Please go through home Screen',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  Color(0xff249DD8),
                                )),
                            onPressed: () {
                              Get.to(() => PackageScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                AutoSizeText(
                                  "Subscribe Now",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.subscriptions_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        // Center(child: AutoSizeText('8/16/2022')),
                      ],
                    ),
                  ),
                );
              }
            } else if (snapshot.data!.payments.first.paymentStatus ==
                'pending') {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 0.6,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: AutoSizeText(
                          'Your subscription is in process. Please wait till Verification',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                Color(0xff249DD8),
                              )),
                          onPressed: () {
                            Get.to(() => MainTabs());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                "Return Back",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.person,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 4),
                      // Center(child: AutoSizeText('8/16/2022')),
                    ],
                  ),
                ),
              );
            } else {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 0.6,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: AutoSizeText(
                          'Your has been failed. Please try again',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                Color(0xff249DD8),
                              )),
                          onPressed: () {
                            Get.to(() => PackageScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                "Subscribe Now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.subscriptions_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Center(child: AutoSizeText('8/16/2022')),
                    ],
                  ),
                ),
              );
            }
          }
          return Container(
              child: AutoSizeText('failed',
                  style: TextStyle(color: Colors.black)));
        },
      ),
      SizedBox(
        height: 10,
      ),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: AutoSizeText(
            'Transaction History',
            style: TextStyle(
                fontFamily: "Sofia", fontSize: 20, fontWeight: FontWeight.w600),
          )),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              alignment: Alignment.center,
              child: AutoSizeText(
                'Paid From',
                maxFontSize: 14,
                minFontSize: 14,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              alignment: Alignment.center,
              child: AutoSizeText(
                'Date',
                textAlign: TextAlign.center,
                maxFontSize: 14,
                minFontSize: 14,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              alignment: Alignment.center,
              child: AutoSizeText(
                'Package',
                maxFontSize: 14,
                minFontSize: 14,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      BaseScreen<PaymentViewModel>(
        onModelReady: (model) => model.fetchListOfPayments(context),
        builder: (context, model, child) => model.state == ViewState.Busy
            ? PaymentHistoryShimmer()
            : model.paymentList!.payments == null ||
                    model.paymentList!.payments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white10,
                          ),
                          margin: EdgeInsets.only(top: 60),
                          child: Center(
                            child: Image.asset(
                              "assets/images/empty_search.png",
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child: AutoSizeText(
                                "Payments Not Available",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                              Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: AutoSizeText(
                                    "Your Payments history will appear here.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: model.paymentList!.payments.length,
                    itemBuilder: (context, i) {
                      DateTime dateTo =
                          DateTime.parse(model.paymentList!.payments[i].dateTo!);
                      DateTime dateFrom = DateTime.parse(
                          model.paymentList!.payments[i].dateFrom!);
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.white,
                          elevation: 0.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 30.0, horizontal: 10.0),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  model.paymentList!.payments[i].paidVia ?? '',
                                  maxFontSize: 16,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              model.paymentList!.payments[i].paymentStatus ==
                                      'success'
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 30.0, horizontal: 10.0),
                                      alignment: Alignment.center,
                                      child: AutoSizeText(
                                        DateFormat.Md().format(dateFrom) +
                                            '-' +
                                            DateFormat.Md().format(dateTo),
                                        textAlign: TextAlign.center,
                                        maxFontSize: 16,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : model.paymentList!.payments[i]
                                              .paymentStatus ==
                                          'pending'
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.0, horizontal: 10.0),
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            model.paymentList!.payments[i]
                                                .paymentStatus!,
                                            textAlign: TextAlign.center,
                                            maxFontSize: 14,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.0, horizontal: 10.0),
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            model.paymentList!.payments[i]
                                                .paymentStatus!,
                                            maxFontSize: 16,
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 30.0, horizontal: 10.0),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  model.paymentList!.payments[i].packageType!,
                                  textAlign: TextAlign.center,
                                  maxFontSize: 16,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      )
    ])));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200), () {});
  }

  Widget _buildSnackBar(Color color, String msg) {
    return SnackBar(
      backgroundColor: color,
      content: AutoSizeText(msg),
    );
  }
}
