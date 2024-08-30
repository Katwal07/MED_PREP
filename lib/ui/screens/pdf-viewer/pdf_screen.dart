import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../enums/viewstate.dart';
import '../../constants/loading.dart';
import '../../viewmodels/treasures_model.dart';
import '../base_screen.dart';
import 'pdf_from_cached_url.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Wrap(
              children: [
                Container(
                  width: screenSize.width,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Container(
                      width: screenSize.width /
                          (2 / (screenSize.height / screenSize.width)),
                      child: Center(
                        child: AutoSizeText(
                          'My Treasure',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -1,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                  ),
                ),
                BaseScreen<TreasuresViewModel>(
                  onModelReady: (model) => model.fetchListOfTreasures(context),
                  builder: (context, model, child) => model.state ==
                          ViewState.Busy
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: kLoadingWidget(context))
                      : model.treasuresList!.treasures.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Center(
                                child: AutoSizeText('No Treasures Found'),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: model.treasuresList!.treasures
                                  .toSet()
                                  .toList()
                                  .length,
                              shrinkWrap: true,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount:
                              //         (orientation == Orientation.portrait) ? 2 : 3),
                              itemBuilder: (context, index) {
                                print(
                                    'This is length of data fetched from API ${model.treasuresList!.treasures.length}');

                                if (model.treasuresList!.treasures[index]
                                        .section ==
                                    null) {
                                  // This treasure belong to program

                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.4))),
                                    child: ExpansionTile(
                                        initiallyExpanded: true,
                                        backgroundColor: Colors.white,
                                        title: AutoSizeText(
                                          model.treasuresList!.treasures[index]
                                              .program!.name!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Baloo da',
                                          ),
                                        ),
                                        subtitle: AutoSizeText(
                                          'Uploaded At: ${model.treasuresList!.treasures[index].createdAt}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Baloo da',
                                          ),
                                        ),
                                        // leading: Container(
                                        //   alignment: Alignment.center,
                                        //   height: 40,
                                        //   width: 40,
                                        //   child: Image.network(
                                        //     model.treasuresList.treasures[index]
                                        //         .section.photoUrl,
                                        //     fit: BoxFit.fill,
                                        //     color: Colors.grey.withOpacity(0.4),
                                        //   ),
                                        // ),
                                        children: <Widget>[
                                          GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: (MediaQuery
                                                                    .of(context)
                                                                .orientation ==
                                                            Orientation
                                                                .portrait)
                                                        ? 2
                                                        : 3),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  // updateBook(index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey[300]!,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .filePdf,
                                                        color: Colors.grey
                                                            .withOpacity(0.4),
                                                        size: 15,
                                                      ),
                                                      SizedBox(height: 5),
                                                      TextButton(
                                                        onPressed: () => Get.to(
                                                            () =>
                                                                PDFViewerCachedFromUrl(
                                                                  treasure: model
                                                                      .treasuresList!
                                                                      .treasures[index],
                                                                )),
                                                        child: AutoSizeText(
                                                            'PDF From  Url ${model.treasuresList!.treasures[index].name}',
                                                            maxFontSize: 14,
                                                            minFontSize: 12,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'Baloo da',
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ]),
                                  );
                                } else if (model.treasuresList!.treasures[index]
                                        .chapter ==
                                    null) {
                                  // This Belongs to Particular Setion
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.4))),
                                    child: ExpansionTile(
                                        initiallyExpanded: true,
                                        backgroundColor: Colors.white,
                                        title: AutoSizeText(
                                          model.treasuresList!.treasures[index]
                                              .section!.name!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Baloo da',
                                          ),
                                        ),
                                        subtitle: AutoSizeText(
                                          'Uploaded At: ${model.treasuresList!.treasures[index].createdAt}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Baloo da',
                                          ),
                                        ),
                                        // leading: Container(
                                        //   alignment: Alignment.center,
                                        //   height: 40,
                                        //   width: 40,
                                        //   child: Image.network(
                                        //     model.treasuresList.treasures[index]
                                        //         .section.photoUrl,
                                        //     fit: BoxFit.fill,
                                        //     color: Colors.grey.withOpacity(0.4),
                                        //   ),
                                        // ),
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              // updateBook(index);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey[300]!,
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.filePdf,
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    size: 15,
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextButton(
                                                    onPressed: () => Get.to(() =>
                                                        PDFViewerCachedFromUrl(
                                                          treasure: model
                                                              .treasuresList!
                                                              .treasures[index],
                                                        )),
                                                    child: AutoSizeText(
                                                        'PDF From  Url ${model.treasuresList!.treasures[index].name}',
                                                        maxFontSize: 14,
                                                        minFontSize: 12,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Baloo da',
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                  );
                                } else {
                                  // This Belongs to Individual Chapter
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.4))),
                                    child: ExpansionTile(
                                        initiallyExpanded: true,
                                        backgroundColor: Colors.white,
                                        title: AutoSizeText(
                                          model.treasuresList!.treasures[index]
                                              .chapter!.name!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Baloo da',
                                          ),
                                        ),
                                        subtitle: AutoSizeText(
                                          'Uploaded At: ${model.treasuresList!.treasures[index].createdAt}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Baloo da',
                                          ),
                                        ),
                                        // leading: Container(
                                        //   alignment: Alignment.center,
                                        //   height: 40,
                                        //   width: 40,
                                        //   child: Image.network(
                                        //     model.treasuresList.treasures[index]
                                        //         .section.photoUrl,
                                        //     fit: BoxFit.fill,
                                        //     color: Colors.grey.withOpacity(0.4),
                                        //   ),
                                        // ),
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              // updateBook(index);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey[300]!,
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.filePdf,
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    size: 15,
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextButton(
                                                    onPressed: () => Get.to(() =>
                                                        PDFViewerCachedFromUrl(
                                                          treasure: model
                                                              .treasuresList!
                                                              .treasures[index],
                                                        )),
                                                    child: AutoSizeText(
                                                        'PDF From  Url ${model.treasuresList!.treasures[index].name}',
                                                        maxFontSize: 14,
                                                        minFontSize: 12,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Baloo da',
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                  );
                                }
                              },
                            ),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(5.0),
                  //       side: BorderSide(color: Colors.grey.withOpacity(0.4))),
                  //   child: ExpansionTile(
                  //       backgroundColor: Colors.white,
                  //       title: AutoSizeText(
                  //         'Pharmacology',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: 'Baloo da',
                  //         ),
                  //       ),
                  //       subtitle: AutoSizeText(
                  //         'Uploaded At: 2020/2/20',
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //           fontFamily: 'Baloo da',
                  //         ),
                  //       ),
                  //       leading: Container(
                  //         alignment: Alignment.center,
                  //         height: 40,
                  //         width: 40,
                  //         child: SvgPicture.asset('assets/icons/pharmacology.svg',
                  //             fit: BoxFit.contain,
                  //             color: Colors.grey.withOpacity(0.4)),
                  //       ),
                  //       children: <Widget>[
                  //         GridView.builder(
                  //           shrinkWrap: true,
                  //           itemCount: (2 * 2),
                  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             childAspectRatio: MediaQuery.of(context).size.width /
                  //                 (MediaQuery.of(context).size.height / 8),
                  //           ),
                  //           itemBuilder: (context, index) {
                  //             return GestureDetector(
                  //               onTap: () {
                  //                 // updateBook(index);
                  //               },
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.grey[300],
                  //                   ),
                  //                   color: Colors.white,
                  //                 ),
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   children: [
                  //                     Icon(
                  //                       FontAwesomeIcons.filePdf,
                  //                       color: Colors.grey.withOpacity(0.4),
                  //                       size: 15,
                  //                     ),
                  //                     SizedBox(height: 5),
                  //                     TextButton(
                  //                         onPressed: () =>
                  //                             Get.to(() => PDFViewerCachedFromUrl(
                  //                                   url:
                  //                                       'https://www.hq.nasa.gov/alsj/a17/A17_FlightPlan.pdf',
                  //                                 )),
                  //                         child: AutoSizeText('PDF From  Url',
                  //                             minFontSize: 12,
                  //                             maxFontSize: 14,
                  //                             textAlign: TextAlign.center,
                  //                             style: TextStyle(
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w500,
                  //                               fontFamily: 'Baloo da',
                  //                             ))),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ]),
                  // ),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(5.0),
                  //       side: BorderSide(color: Colors.grey.withOpacity(0.4))),
                  //   child: ExpansionTile(
                  //       backgroundColor: Colors.white,
                  //       title: AutoSizeText(
                  //         'Physiology',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: 'Baloo da',
                  //         ),
                  //       ),
                  //       subtitle: AutoSizeText(
                  //         'Uploaded At: 2019/12/20',
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //           fontFamily: 'Baloo da',
                  //         ),
                  //       ),
                  //       leading: Container(
                  //         alignment: Alignment.center,
                  //         height: 40,
                  //         width: 40,
                  //         child: SvgPicture.asset('assets/icons/physiology.svg',
                  //             fit: BoxFit.contain,
                  //             color: Colors.grey.withOpacity(0.4)),
                  //       ),
                  //       children: <Widget>[
                  //         GridView.builder(
                  //           shrinkWrap: true,
                  //           itemCount: (2 * 2),
                  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             childAspectRatio: MediaQuery.of(context).size.width /
                  //                 (MediaQuery.of(context).size.height / 8),
                  //           ),
                  //           itemBuilder: (context, index) {
                  //             return GestureDetector(
                  //               onTap: () {
                  //                 // updateBook(index);
                  //               },
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.grey[300],
                  //                   ),
                  //                   color: Colors.white,
                  //                 ),
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   children: [
                  //                     Icon(
                  //                       FontAwesomeIcons.filePdf,
                  //                       color: Colors.grey.withOpacity(0.4),
                  //                       size: 15,
                  //                     ),
                  //                     SizedBox(height: 5),
                  //                     TextButton(
                  //                       onPressed: () => Get.to(
                  //                         () => PDFViewerFromAsset(
                  //                           pdfAssetPath:
                  //                               'assets/pdf/quotation-protected.pdf',
                  //                         ),
                  //                       ),
                  //                       child: AutoSizeText('PDF FROM ASSETS',
                  //                           maxFontSize: 14,
                  //                           minFontSize: 12,
                  //                           textAlign: TextAlign.center,
                  //                           style: TextStyle(
                  //                             fontSize: 12,
                  //                             fontWeight: FontWeight.w500,
                  //                             fontFamily: 'Baloo da',
                  //                           )),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ]),
                  // ),

                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //   child: Container(
                  //     child: ListTile(
                  //       title: AutoSizeText('Pathalogy',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 20,
                  //               color: Colors.black.withOpacity(0.6))),
                  //       subtitle: Column(
                  //         children: [
                  //           Divider(
                  //             color: Colors.black.withOpacity(0.4),
                  //             thickness: 1,
                  //           ),
                  //           Row(
                  //             children: [
                  //               AutoSizeText('Name:',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold, fontSize: 18)),
                  //               TextButton(
                  //                 onPressed: () => Get.to(
                  //                   () => PDFViewerFromAsset(
                  //                     pdfAssetPath: 'assets/pdf/quotation-protected.pdf',
                  //                   ),
                  //                 ),
                  //                 child: AutoSizeText('PDF From Asset',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w600,
                  //                         fontSize: 18,
                  //                         color: Colors.blue.withOpacity(0.6))),
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               AutoSizeText('Uploaded Date:', style: TextStyle(fontSize: 18)),
                  //               AutoSizeText(
                  //                 ' 2021/12/20',
                  //                 style:
                  //                     TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  //               )
                  //             ],
                  //           ),
                  //           Divider(
                  //             color: Colors.black.withOpacity(0.4),
                  //             thickness: 1,
                  //           ),
                  //           Row(
                  //             children: [
                  //               AutoSizeText('Name:',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold, fontSize: 18)),
                  //               TextButton(
                  //                 onPressed: () => Get.to(() => PDFViewerCachedFromUrl(
                  //                       url:
                  //                           'https://www.hq.nasa.gov/alsj/a17/A17_FlightPlan.pdf',
                  //                     )),
                  //                 child: AutoSizeText('PDF From Cached Url',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w600,
                  //                         fontSize: 18,
                  //                         color: Colors.blue.withOpacity(0.6))),
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             children: [
                  //               AutoSizeText('Uploaded Date:', style: TextStyle(fontSize: 18)),
                  //               AutoSizeText(
                  //                 ' 2021/12/20',
                  //                 style:
                  //                     TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
