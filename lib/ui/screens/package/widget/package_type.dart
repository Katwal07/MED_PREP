// import 'package:esewa_pnp/esewa.dart';
// import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../common/tools.dart';
import '../../../../config/config.dart';
import '../../../../locator.dart';
import '../../../../models/app_config.dart';
import '../../../../models/packages.dart';
import '../../../../services/api_service.dart';
import '../../../constants/loading.dart';
import 'payment_error_page.dart';
import 'payment_sucess_page.dart';

class SubscriptionWidget extends StatefulWidget {
  final Package package;
  SubscriptionWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.package,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
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

  void selectPaymentType(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (ctx) {
          return FutureBuilder<AppConfig?>(
              future: locator<Api>().getAppConfiguration(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return kLoadingWidget(context);
                }

                if (snapshot.data == null) {
                  return AutoSizeText("Failed to Fetch Payment Type");
                }

                return Container(
                    height: [
                              snapshot.data!.paymentViaEsewa,
                              snapshot.data!.paymentViaKhalti,
                              snapshot.data!..paymentViaManually
                            ]
                                .where((element) => element == true)
                                .toList()
                                .length *
                            115.0 +
                        80,
                    decoration: BoxDecoration(
                        color: Colors.grey
                            .shade400, //could change this to Color(0xFF737373),             height: 250,

                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: AutoSizeText(
                            'Choose Payment Method',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            height: 3,
                            color: Colors.grey,
                          ),
                        ),

                        if (snapshot.data!.paymentViaEsewa!)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 46.0, vertical: 10.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  //! Rohan
                                 // backgroundColor: Color(0xff41A125),
                                  shape: RoundedRectangleBorder(
                                      // side: BorderSide(
                                      //   color: Color(0xff)
                                      //       .withOpacity(
                                      //           0.7),
                                      // ),
                                      borderRadius: BorderRadius.circular(
                                    10.0,
                                  )),
                                  minimumSize: Size(322, 51),
                                ),
                                onPressed: () async {
                                  print(
                                      "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                                  print(
                                      'this is printed package price ${widget.package.price.toString()}');
                                  print(
                                      'this is printed package name ${widget.package.name}');
                                  print(
                                      'this is printed package id ${widget.package.id}');

                                  const platformChannel =
                                      MethodChannel('bitpoint-eSewa');

                                  try {
                                    final result = await platformChannel
                                        .invokeMethod(
                                            'initiate_eSewa_gateway', [
                                      {
                                        'clientId':
                                            locator<IConfig>().esewaClientId,
                                        'secretKey':
                                            locator<IConfig>().esewaSecretKey,
                                        'environment':
                                            locator<IConfig>().environment
                                      },
                                      // {
                                      //   'clientId':
                                      //       'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R',
                                      //   'secretKey':
                                      //       'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==',
                                      //   'environment':
                                      //       'ENVIRONMENT_TEST'
                                      // },
                                      {
                                        'productPrice':
                                            widget.package.price.toString(),
                                        'productName': widget.package.name,
                                        'productId': widget.package.id,
                                        'callBackUrl': ''
                                      }
                                    ]);

                                    print(result);

                                    if (result['isSuccess'] == true) {
                                      try {
                                        var success = await locator<Api>()
                                            .payViaEsewa(
                                                package: widget.package,
                                                esewaResponse: result);

                                        if (success) {
                                          Tools.dismissLoadingModal();

                                          Get.offAll(() =>
                                              ThankYouPage(title: 'Back Home'));

                                          return;
                                          // Get.back();
                                          // Get.back();
                                        }
                                        Tools.dismissLoadingModal();
                                        // Get.offAll(() => SorryPage(
                                        //                                             title: 'Back Home'));
                                      } catch (err) {
                                        Tools.dismissLoadingModal();
                                        Get.offAll(() =>
                                            SorryPage(title: 'Back Home'));
                                      }
                                    }
                                  } on PlatformException catch (e) {
                                    // Tools
                                    //     .dismissLoadingModal();
                                    print(e);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/esewa/esewa.png'),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    AutoSizeText('PAY WITH E-SEWA',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Colors.white,
                                                letterSpacing: 1.2,
                                                fontWeight: FontWeight.w700)),
                                  ],
                                )),
                          ),
                        // if (snapshot.data.paymentViaKhalti)
                        //   Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 46.0, vertical: 10.0),
                        //     child: ElevatedButton(
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: Color(0xff5D2E8E),
                        //           shape: RoundedRectangleBorder(
                        //               // side: BorderSide(
                        //               //   color: Color(0xff)
                        //               //       .withOpacity(
                        //               //           0.7),
                        //               // ),
                        //               borderRadius: BorderRadius.circular(
                        //             10.0,
                        //           )),
                        //           minimumSize: Size(322, 51),
                        //         ),
                        //         onPressed: () async {
                        //           const platformChannel =
                        //               MethodChannel('bitpoint-khalti');
                        //           final result = await platformChannel
                        //               .invokeMethod('initiate_khalti_gateway', {
                        //             'publicKey':
                        //                 // 'test_public_key_ad9a9c971a6842aca4b1f27447de0699',
                        //                 locator<IConfig>().khaltiPublicKey,
                        //             'productName': widget.package.name,
                        //             'amount':
                        //                 (widget.package.price * 100).toString(),
                        //             'productId': widget.package.id,
                        //             'productUrl': '',
                        //             'eBankingPayment': 'false',
                        //           });

                        //           // Check The Result Status

                        //           Tools.showLoadingModal();

                        //           try {
                        //             if (result['isSuccess'] == true) {
                        //               // Send Payment to Backend via API

                        //               try {
                        //                 var success = await locator<Api>()
                        //                     .payViaKhalti(
                        //                         package: widget.package,
                        //                         khaltiResponse: result);

                        //                 if (success) {
                        //                   Tools.dismissLoadingModal();
                        //                   Get.offAll(() =>
                        //                       ThankYouPage(title: 'Back Home'));

                        //                   return;
                        //                   // Get.back();
                        //                   // Get.back();
                        //                 }
                        //                 Tools.dismissLoadingModal();
                        //                 // Get.offAll(() => SorryPage(
                        //                 //       title: 'Back Home'));

                        //               } catch (err) {
                        //                 Tools.dismissLoadingModal();
                        //                 Get.offAll(() =>
                        //                     SorryPage(title: 'Back Home'));
                        //               }
                        //             }
                        //             Tools.dismissLoadingModal();
                        //             Get.offAll(
                        //                 () => SorryPage(title: 'Back Home'));
                        //           } catch (err) {
                        //             print(err);
                        //             Tools.dismissLoadingModal();
                        //             Get.offAll(
                        //                 () => SorryPage(title: 'Back Home'));
                        //           }
                        //         },
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Image.asset('assets/esewa/khalti.png'),
                        //             const SizedBox(
                        //               width: 10.0,
                        //             ),
                        //             AutoSizeText('PAY WITH KHALTI',
                        //                 textAlign: TextAlign.center,
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .bodyText1
                        //                     .copyWith(
                        //                         color: Colors.white,
                        //                         letterSpacing: 1.2,
                        //                         fontWeight: FontWeight.w700)),
                        //           ],
                        //         )),
                        //   ),
                        if (snapshot.data!.paymentViaManually!)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 46.0, vertical: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xff)
                                            .withOpacity(
                                                0.7),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                    10.0,
                                  )),
                                  minimumSize: Size(322, 51),
                                ),
                                onPressed: () async {
                                  Tools.showErrorToast(
                                      'Please contact admin for this payment process!');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    AutoSizeText('PAY MANUALLY',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Colors.black54,
                                                letterSpacing: 1.2,
                                                fontWeight: FontWeight.w800)),
                                  ],
                                )),
                          ),
                        // if (snapshot
                        //     .data.paymentViaManually)
                        //   Container(
                        //     height: 50,
                        //     width: MediaQuery.of(context)
                        //         .size
                        //         .width,
                        //     child: ElevatedButton(
                        //       color: Color(0xff249DD8),
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius:
                        //               BorderRadius.circular(
                        //                   5)),
                        //       onPressed: () => Get.to(
                        //           ManualPaymentScreen(
                        //         package: widget.package,
                        //       )), // getEsewaPayment();

                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment
                        //                 .center,
                        //         children: <Widget>[
                        //           AutoSizeText(
                        //             "Pay manually",
                        //             textAlign:
                        //                 TextAlign.center,
                        //             style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight:
                        //                     FontWeight.w500,
                        //                 fontSize: 16),
                        //           ),
                        //           SizedBox(width: 10.0),
                        //           Icon(
                        //             Icons.payment,
                        //             color: Colors.white,
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ));
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    print('this is package name ----- ${widget.package.name}');
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Wrap(
        spacing: 10, // to apply margin in the main axis of the wrap
        runSpacing: 10, // to apply margin in the cross axis of the wrap
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              widget.package.name!,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff4b565b),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: [
              Image.asset(
                widget.package.name == "1 month Package"
                    ? 'assets/images/cup2.png'
                    : (widget.package.name == "1 year Package"
                        ? 'assets/images/cup1.png'
                        : 'assets/images/cup3.png'),
                // 'assets/images/cup1.png',
                fit: BoxFit.fitHeight,
                width: 150,
              ),
              // SizedBox(
              //   width: (width * 0.10),
              // ),
              Column(
                // spacing:
                //     5, // to apply margin in the main axis of the wrap
                // runSpacing:
                //     10, // to apply margin in the cross axis of the wrap
                children: [
                  AutoSizeText(
                    'Rs 1200',
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  AutoSizeText(
                    widget.package.price.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    '(Save 15%)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AutoSizeText(
                    'Total Questions',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  AutoSizeText(
                    '30,000 +',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    // width: double.infinity,
                    height: 40,
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
                        selectPaymentType(context);
                      },
                      child: AutoSizeText(
                        'SUBSCRIBE NOW',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            thickness: 2,
            color: Colors.blue[100],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0)),
            ),
            child: Container(
              padding: EdgeInsets.all(2),
              child: Align(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    "This package is valid for " +
                        widget.package.duration.toString() +
                        " days",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  )),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: AutoSizeText(
              widget.package.name! + ' includes:',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                // spacing:
                //     5, // to apply margin in the main axis of the wrap
                // runSpacing:
                //     10, // to apply margin in the cross axis of the wrap
                children: [
                  AutoSizeText(
                    '30000',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AutoSizeText('Questions')
                ],
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                  //width: 50.0,
                  //height: 50.0,
                  padding: const EdgeInsets.all(
                      10.0), //I used some padding without fixed width and height
                  decoration: new BoxDecoration(
                    shape: BoxShape
                        .circle, // You can use like this way or like the below line
                    //borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: Image.asset(
                    'assets/images/test.png',
                    height: 30,
                  ) // You can add a Icon instead of text also, like below.
                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                  ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: AutoSizeText(
                      'Practice as many question as you wish from our big variety of questions'))
            ],
          ),
          Divider(
            thickness: 2,
            color: Colors.blue[100],
          ),
          Row(
            children: [
              Column(
                // spacing:
                //     5, // to apply margin in the main axis of the wrap
                // runSpacing:
                //     10, // to apply margin in the cross axis of the wrap

                children: [
                  AutoSizeText(
                    '15',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AutoSizeText('Super Exams')
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                //width: 50.0,
                //height: 50.0,
                padding: const EdgeInsets.all(
                    10.0), //I used some padding without fixed width and height
                decoration: new BoxDecoration(
                  shape: BoxShape
                      .circle, // You can use like this way or like the below line
                  //borderRadius: new BorderRadius.circular(30.0),
                ),

                child: Image.asset(
                  'assets/images/rivision.png',
                  height: 30,
                ), // You can add a Icon instead of text also, like below.
                //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child:
                      AutoSizeText('Weekly Question and Bonous exam practice'))
            ],
          ),
        ],
      ),
    );
  }
}
// class SubscriptionWidget extends StatefulWidget {
//   const SubscriptionWidget({
//     Key key,
//     @required this.height,
//     @required this.width,
//     @required this.package,
//   }) : super(key: key);

//   final double height;
//   final double width;

//   @override
//   State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
// }

// class _SubscriptionWidgetState extends State<SubscriptionWidget> {
//  }
