import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LeadershipScreen extends StatefulWidget {
  const LeadershipScreen({Key? key}) : super(key: key);

  @override
  _LeadershipScreenState createState() => _LeadershipScreenState();
}

class _LeadershipScreenState extends State<LeadershipScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: AutoSizeText(
          'Leaderboard',
          textAlign: TextAlign.center,
          maxFontSize: 16,
          minFontSize: 16,
          textScaleFactor: 1.5,
          style: TextStyle(color: Colors.black45),
        ),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  '2nd',
                  textAlign: TextAlign.center,
                  maxFontSize: 16,
                  minFontSize: 16,
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  child: Image.asset(
                    'assets/images/cup.png',
                    height: 30,
                  ),
                  backgroundColor: Colors.white,

                  //     CachedNetworkImageProvider(
                  //   user.photoUrl,
                  // ),
                  // child: Image.network(
                  //   user.photoUrl,
                  //   fit: BoxFit.contain,
                  // ),
                ),
                AutoSizeText(
                  '80/100',
                  textAlign: TextAlign.center,
                  maxFontSize: 16,
                  minFontSize: 16,
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size(0.0, 80.0),
        ),
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 10,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
              child: InkWell(
                onTap: () {
                  // Get.to(DetailBoardMemberScreen());
                },
                child: Wrap(
                  // runSpacing: 20,
                  spacing: 10,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: AutoSizeText(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: const CircleAvatar(
                                radius: 20, //we give the image a radius of 30
                                backgroundImage: ExactAssetImage(
                                    'assets/images/hci_adventures.jpg')),
                          ),
                          Container(
                            child: AutoSizeText(
                              'Utsab Aryal',
                              maxFontSize: 20,
                              minFontSize: 15,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: AutoSizeText(
                              '100/100',
                              maxFontSize: 20,
                              minFontSize: 15,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
