// ignore_for_file: unnecessary_null_comparison, unnecessary_type_check

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../locator.dart';
import '../../../models/porgram.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../tabbar.dart';
import '../../widgets/login/reuseable_components.dart';

class ProgramSelect extends StatefulWidget {
  const ProgramSelect({key}) : super(key: key);

  @override
  _ProgramSelectState createState() => _ProgramSelectState();
}

class _ProgramSelectState extends State<ProgramSelect> {
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            AutoSizeText(
              'Please Select the program',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(30.0),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  highlightColor: Colors.purple,
                  onTap: () {},
                  child: Card(
                    elevation: 2,
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
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: selectedProgram ==
                                              snapshot.data!.programs[index].id
                                          ? Colors.blue
                                          : Colors.white,
                                      elevation: 10.0,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.blue.withOpacity(0.2),
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: AutoSizeText(
                                      snapshot.data!.programs[index].name!,
                                      style: TextStyle(
                                          color: selectedProgram ==
                                                  snapshot
                                                      .data!.programs[index].id
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        selectedProgram =
                                            snapshot.data!.programs[index].id!;
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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: T6Button(
                isStroked: (selectedProgram == null ||
                        (selectedProgram is String && selectedProgram.isEmpty))
                    ? true
                    : false,
                textContent: "DONE",
                onPressed: (selectedProgram == null ||
                        (selectedProgram is String && selectedProgram.isEmpty))
                    ? null
                    : () {
                        _api
                            .updateUserSelectedProgram(selectedProgram)
                            .then((value) {
                          Get.to(MainTabs());
                        });
                      }, child: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
