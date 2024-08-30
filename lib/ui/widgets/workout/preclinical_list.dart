// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../enums/viewstate.dart';
import '../../screens/base_screen.dart';
import '../../screens/subject-detail/subject_detail_screen.dart';
import '../../viewmodels/section_model.dart';
import '../home/subject_icon_items.dart';
import '../shimmer/workout/workout_shimmer.dart';

class SubjectListingPreClinical extends StatefulWidget {
  String SelectedTab;
  SubjectListingPreClinical({required this.SelectedTab});
  @override
  _SubjectListingPreClinicalState createState() =>
      _SubjectListingPreClinicalState();
}

class _SubjectListingPreClinicalState extends State<SubjectListingPreClinical> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen<SectionViewModel>(
      onModelReady: (model) =>
          model.fetchListOfSections(context, widget.SelectedTab),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? WorkoutShimmer()
          : model.sectionList == null || model.sectionList!.sections.isEmpty
              ? WorkoutShimmer()
              : Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.02)),
                  margin: EdgeInsets.all(5),
                  child: GridView.builder(
                      itemCount: model.sectionList!.sections
                              .map((e) => e.tag)
                              .contains('Pre-Clinical')
                          ? model.sectionList!.sections.length
                          : 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 3 / 2,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10)
                            ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              height: 20,
                              child: model.sectionList!.sections[index].tag ==
                                      'Pre-Clinical'
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          model.sectionList!.sections[index]
                                              .photoUrl!,
                                          height: 45,
                                        ),
                                        // Image.asset(
                                        //   mySubjects[index]['image'],
                                        // ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          model
                                              .sectionList!.sections[index].name!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    )
                                  : null),
                          focusColor: Colors.blue,
                          onTap: () {
                            Get.to(() => SubjectDetailScreen(
                                  subject: SubjectItem(
                                    section:
                                        model.sectionList!.sections[index],
                                  ),
                                ));
                          },
                        );
                      }),
                ),
    );
  }
}
