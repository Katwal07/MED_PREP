import 'package:auto_size_text/auto_size_text.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class PaymentHistoryShimmer extends StatelessWidget {
  const PaymentHistoryShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[100]!,
        highlightColor: Colors.grey[200]!,
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 6,
          itemBuilder: (context, i) {
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
                        child: AutoSizeText(
                          'Loading......',
                          maxFontSize: 16,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 10.0),
                      alignment: Alignment.center,
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
                        child: AutoSizeText(
                          'Loading......',
                          maxFontSize: 16,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 10.0),
                      alignment: Alignment.center,
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
                        child: AutoSizeText(
                          'Loading......',
                          maxFontSize: 16,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
