import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Subject_icon_shimmer extends StatelessWidget {
  Subject_icon_shimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[200]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                height: 80.h,
                margin: EdgeInsets.all(10.0),
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Shimmer(
                            enabled: true,
                            gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.black54,
                                /*AppColours.appgradientfirstColour,
                        AppColours.appgradientsecondColour*/
                              ],
                            ),
                            child: Icon(Icons.image)),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Shimmer(
                      enabled: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.black54,
                          /*AppColours.appgradientfirstColour,
                            AppColours.appgradientsecondColour*/
                        ],
                      ),
                      child: Container(
                        child: AutoSizeText(
                          'loading',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: 6,
        ),
      ),
    );
  }
}
