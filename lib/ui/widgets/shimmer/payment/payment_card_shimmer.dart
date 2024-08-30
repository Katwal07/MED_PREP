import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PaymentCardShimmer extends StatelessWidget {
  const PaymentCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[200]!,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
          height: 250,
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
                        child: AutoSizeText(
                          'Loading..',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
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
                          child: AutoSizeText('Loading......')),
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
                        child: AutoSizeText(
                          'Loading..',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
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
                        child: AutoSizeText(
                          'Loading..',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                        child: AutoSizeText(
                          'Loading..',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
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
                          child: AutoSizeText('Loading......')),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
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
                    'Loading..',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              // Center(child: AutoSizeText('8/16/2022')),
            ],
          ),
        ),
      ),
    );
  }
}
