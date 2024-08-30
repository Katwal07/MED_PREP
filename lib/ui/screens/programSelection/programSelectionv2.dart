// ignore_for_file: unused_local_variable, unnecessary_type_check, unnecessary_null_comparison

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../../../locator.dart';
import '../../../models/porgram.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../tabbar.dart';
import '../login/login_screen.dart';

class ProgramSelectV2 extends StatefulWidget {
  @override
  State<ProgramSelectV2> createState() => _ProgramSelectV2State();
}

class _ProgramSelectV2State extends State<ProgramSelectV2> {
  Api _api = locator<Api>();

  String selectedProgram = '';

  StorageService _storageService = locator<StorageService>();

  @override
  void initState() {
    super.initState();

    _storageService.getUser().then((user) {
      setState(() {
        selectedProgram = user.selectedProgram!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            'assets/images/main_top.png',
            width: width * 0.3,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            'assets/images/login_bottom.png',
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            width: width * 0.4,
          ),
        ),
        Positioned(
          top: 45.0,
          right: 20.0,
          child: IconFadeTransition(),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/email_not_verified.png',
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AutoSizeText(
                      'Select Program',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: AutoSizeText(
                        'We want you to select program which you are trying to learn and practice. You can always change this from setting.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(30.0),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 0,
                          child: FutureBuilder<ProgramList?>(
                              future: _api.getPrograms(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.programs.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: selectedProgram ==
                                                    snapshot
                                                        .data!.programs[index].id
                                                ? Colors.blue
                                                : Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.blue
                                                      .withOpacity(0.2),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: AutoSizeText(
                                            snapshot.data!.programs[index].name!,
                                            style: TextStyle(
                                                color: selectedProgram ==
                                                        snapshot.data!
                                                            .programs[index].id
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedProgram = snapshot
                                                  .data!.programs[index].id!;
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: ButtonTheme(
                              height: 45,
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.done_all),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    AutoSizeText(
                                      'CONTINUE',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).colorScheme.secondary,
                                )),
                                onPressed: (selectedProgram == null ||
                                        (selectedProgram is String &&
                                            selectedProgram.isEmpty))
                                    ? null
                                    : () {
                                        _api
                                            .updateUserSelectedProgram(
                                                selectedProgram)
                                            .then((value) {
                                          Get.offAll(MainTabs());
                                        });
                                      },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: ButtonTheme(
                              height: 45,
                              child: ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.logout),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      AutoSizeText(
                                        'LOGOUT',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                    Theme.of(context).colorScheme.secondary,
                                  )),
                                  onPressed: () {
                                    StorageService storageService =
                                        locator<StorageService>();

                                    storageService.clearUser();

                                    Get.offAll(LoginScreen());
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
