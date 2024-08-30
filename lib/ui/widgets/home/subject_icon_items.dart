// ignore_for_file: null_check_always_fails

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:med_prep/ui/widgets/shimmer/home/subject_icon_shimmer.dart';

import '../../../enums/viewstate.dart';
import '../../../models/section.dart';
import '../../screens/base_screen.dart';
import '../../screens/subject-detail/subject_detail_screen.dart';
import '../../viewmodels/section_model.dart';

class SubjectItem extends StatelessWidget {
  final Section? section;
  final VoidCallback? onTap;

  const SubjectItem({
    Key? key,
    this.section,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('this is photo url printed ----${section!.photoUrl}');
    return GestureDetector(
      child: Container(
        height: 80,
        margin: EdgeInsets.all(10.0),
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:
                        CachedNetworkImage(
                      height: 29,
                      width: 29,
                      fit: BoxFit.fill,
                      imageUrl: section!.photoUrl ??
                          'https://medprepnepal.s3.ap-southeast-1.amazonaws.com/questions/1632413501806.png',
                    )),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Expanded(
              child: Container(
                child: AutoSizeText(
                  section!.name!,
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
  }
}

class SubjectImages extends StatelessWidget {
//   List<Widget> listItem() {
//     FutureBuilder(
//       future: _api.getAllSections(),
//       builder: (context, snapshot) {
//       if(snapshot.hasData){

//       }
// return;
//     },)
//     List<Widget> items = [];
//     return items;
//   }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        print(constrains.maxHeight);
        return Container(
          child: BaseScreen<SectionViewModel>(
              onModelReady: (model) => model.fetchListOfSections(context, null!),
              builder: (context, model, child) => model.state == ViewState.Busy
                  ? Subject_icon_shimmer()
                  : model.sectionList == null ||
                          model.sectionList!.sections.isEmpty
                      ? Container()
                      : Container(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //     crossAxisCount:
                            //         (orientation == Orientation.portrait) ? 2 : 3),
                            itemBuilder: (context, index) {
                              print('This should be Print ' +
                                  model.sectionList!.sections[index].photoUrl
                                      .toString());
                              return SubjectItem(
                                section:
                                    model.sectionList!.sections[index],
                                onTap: () {
                                  Get.to(() => SubjectDetailScreen(
                                        subject: SubjectItem(
                                          section: model.sectionList!
                                                  .sections[index],
                                        ),
                                      ));
                                },
                              );
                            },
                            itemCount: model.sectionList!.sections.length,
                          ),
                        )
              // FutureBuilder<String>(
              // builder: ,
              // future: ,),
              ),
        );
      },
    );
  }
}
