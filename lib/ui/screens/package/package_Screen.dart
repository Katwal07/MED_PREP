import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../enums/viewstate.dart';
import '../../../tabbar.dart';
import '../../constants/loading.dart';
import '../../viewmodels/package_base_model.dart';
import '../base_screen.dart';
import 'widget/package_type.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: AutoSizeText(
            'SUBSCRIBE OUR PACKAGES',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff4b565b),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.to(MainTabs());
          },
          child: Container(
            padding: EdgeInsets.only(left: 4, top: 20),
            child: Icon(
              FontAwesomeIcons.xmark,
              size: 30,
              color: Color(0xffc5e4f3),
            ),
          ),
        ),
      ),
      body: ListView(children: [
        BaseScreen<PackageViewModel>(
            onModelReady: (model) => model.fetchListOfPackage(context),
            builder: (context, model, child) => model.state == ViewState.Busy
                ? kLoadingWidget(context)
                : model.packageList == null ||
                        model.packageList!.packages.isEmpty
                    ? kLoadingWidget(context)
                    : Container(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            scrollDirection: Axis.horizontal,
                            height: MediaQuery.of(context).size.height,
                            enlargeCenterPage: false,
                            viewportFraction: 1,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                          ),
                          itemBuilder: (context, index, _) {
                            // print('This should be Print is ' +
                            //     model.packageList.packages[index].id);
                            return SubscriptionWidget(
                                package: model.packageList!.packages[index],
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width);
                          },
                          itemCount: model.packageList!.packages.length,
                        ),
                      )),
      ]),
    ));
  }
}
