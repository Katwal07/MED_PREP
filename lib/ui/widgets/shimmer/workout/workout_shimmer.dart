import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutShimmer extends StatelessWidget {
  WorkoutShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[100]!,
        highlightColor: Colors.grey[200]!,
        child: GridView.builder(
            itemCount: 15,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 3 / 2,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    height: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            child: Icon(
                              Icons.image,
                              color: Colors.blue,
                            )),
                        // Image.asset(
                        //   mySubjects[index]['image'],
                        // ),
                        SizedBox(
                          height: 10,
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
                            'loading....',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    )),
                focusColor: Colors.blue,
              );
            }),
      ),
    );
  }
}
