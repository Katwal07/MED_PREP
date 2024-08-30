// ignore_for_file: unused_field, unused_local_variable, unnecessary_null_comparison

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import '../../../../common/tools.dart';
import '../../../../enums/viewstate.dart';
import '../../../../models/packages.dart';
import '../../../constants/colors.dart';
import '../../../constants/constant.dart';
import '../../../constants/loading.dart';
import '../../../viewmodels/manual_payment.dart';
import '../../../viewmodels/package_base_model.dart';
import '../../../widgets/login/reuseable_components.dart';
import '../../base_screen.dart';

// enum CustomType { esewa, bank, cheque, cash }

class ManualPaymentScreen extends StatefulWidget {
  final package;
  ManualPaymentScreen({required this.package});
  @override
  _ManualPaymentScreenState createState() => _ManualPaymentScreenState();
}

class _ManualPaymentScreenState extends State<ManualPaymentScreen> {
  late Package _selectedPackage;
  // var paymentType;

  List<String> _locations = ['esewa', 'bank', 'cheque', 'cash'];
  late String _selectedvalue;
  final _paidController = TextEditingController();
  final _dateFrom = TextEditingController();
  final _note = TextEditingController();
  late File imageFile;
  void startImagePicker(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (ctx) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors
                    .white, //could change this to Color(0xFF737373),             height: 250,

                borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: AutoSizeText(
                    'Upload Paid Receipt',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    height: 3,
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  onTap: () => photoFromGallery(),
                  leading: Icon(Icons.photo),
                  title: AutoSizeText('Image from gallery'),
                ),
                ListTile(
                  onTap: () => photoFromCamera(),
                  leading: Icon(Icons.camera),
                  title: AutoSizeText('Image From camera'),
                ),
              ],
            ),
          );
        });
  }

  Future<void> photoFromGallery() async {
    Get.back();

    try {
      final pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, maxWidth: 1200);
      setState(() {
        if (pickedFile != null) {
          imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
      // if (pickedFile == null) {
      //   return Tools.showErrorToast('Image Picking Canceled');
      // } else {
      //   Tools.showLoadingModal();
      //   await _api.updateUserProfilePicture(image: pickedImage).then((value) {
      //     Tools.dismissLoadingModal();
      //     setState(() {});
      //     // setState(() {
      //     _storageService.saveImage(pickedImage.path);
      //     // });
      //     // // if (value.) {

      //     // }
      //   });
      // }
    } catch (err) {
      print(err);
    }
  }

  Future<void> photoFromCamera() async {
    Get.back();
    try {
      final pickedImage = await ImagePicker()
          .pickImage(source: ImageSource.camera, maxWidth: 1200);
      setState(() {
        if (pickedImage != null) {
          imageFile = File(pickedImage.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (err) {
      print(err);
    }
  }

  // Future getImage() async {
  //   final pickedFile =
  //       await ImagePicker().getImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       imageFile = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _dateFrom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    final format = DateFormat("yyyy-MM-dd");
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: MedUI.backgroundColor,
      body: BaseScreen<ManualPaymentModel>(
        builder: (context, model, child) => Container(
          // height: height,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            // shrinkWrap: true,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo_transparent_1.png',
                    width: width / 2.0,
                  )),
              SizedBox(
                height: 20,
              ),
              MedUI.AutoSizeText('Payment Type *',
                  textColor: tTextColorPrimary),
              SizedBox(
                height: 5,
              ),

              BaseScreen<PackageViewModel>(
                onModelReady: (model) => model.fetchListOfPackage(context),
                builder: (context, model, child) => model.state ==
                        ViewState.Busy
                    ? kLoadingWidget(context)
                    : model.packageList == null ||
                            model.packageList!.packages.isEmpty
                        ? kLoadingWidget(context)
                        : DropdownButtonFormField<Package>(
                            validator: (value) =>
                                value == null ? 'Package required' : null,
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: AutoSizeText('Choose Package Type '),
                            ), // Not necessary for Option 1
                            value: _selectedPackage,
                            onChanged: (newValue) {
                              setState(() {
                                // print('atatararara' + newValue);
                                _selectedPackage = newValue!;
                              });
                            },
                            items: model.packageList!.packages.map((e) {
                              print(' This is me ' + e.name!);
                              return DropdownMenuItem(
                                child:
                                    AutoSizeText('${e.name} (Rs. ${e.price})'),
                                value: e,
                              );
                            }).toList(),
                          ),
              ),
              SizedBox(
                height: 20,
              ),
              MedUI.AutoSizeText('Paid Through *',
                  textColor: tTextColorPrimary),
              SizedBox(
                height: 6,
              ),

              DropdownButton<String>(
                //  isExpanded: true,
                hint: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: AutoSizeText('Choose Payment Type '),
                ), // Not necessary for Option 1

                isExpanded: true,
                value: _selectedvalue,
                items: <String>['esewa', 'bank', 'cheque', 'cash']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: AutoSizeText(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedvalue = newValue!;
                  });
                },
              ),
              // items: _locations.map((String location) {
              //   return new DropdownMenuItem<String>(
              //      child: new AutoSizeText(location),
              //   );
              // }).toList(),),
              // tEditTextStyle('Eg. Esewa',
              // editingController: _paidController),
              SizedBox(
                height: 16,
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // MedUI.AutoSizeText('Descriotion*', textColor: tTextColorPrimary),
              // SizedBox(
              //   height: 6,
              // ),
              // tEditTextStyle('Eg. Note Here', editingController: _note),

              // SizedBox(
              //   height: 20,
              // ),
              MedUI.AutoSizeText('Description*', textColor: tTextColorPrimary),
              SizedBox(
                height: 6,
              ),
              Container(
                decoration: boxDecoration(
                    radius: 12, showShadow: true, bgColor: tWhiteColor),
                child: TextFormField(
                  controller: _note,
                  style: TextStyle(
                      fontSize: textSizeMedium, fontFamily: fontRegular),
                  // keyboardType: isDescription,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                    filled: true,
                    hintText: 'Eg Description here',
                    fillColor: tWhiteColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: tWhiteColor, width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: tWhiteColor, width: 0.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // MedUI.AutoSizeText('Enable Package From',
              //     textColor: tTextColorPrimary),
              // SizedBox(
              //   height: 16,
              // ),
              // DateTimeField(
              //   decoration: InputDecoration(
              //     contentPadding:
              //         EdgeInsets.fromLTRB(26, 18, 4, 18),
              //     hintStyle: TextStyle(
              //         color: Colors.black.withOpacity(0.4)),
              //     filled: true,
              //     hintText: 'YYYY-MM-DD',
              //     fillColor: tWhiteColor,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16),
              //       borderSide: BorderSide(
              //           color: tWhiteColor, width: 0.0),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16),
              //       borderSide: BorderSide(
              //           color: tWhiteColor, width: 0.0),
              //     ),
              //   ),
              //   initialValue: DateTime.now(),
              //   // autofocus: true,
              //   controller: _dateFrom,
              //   format: format,
              //   onShowPicker:
              //       (context, currentValue) async {
              //     final date = await showDatePicker(
              //         context: context,
              //         firstDate: DateTime(1900),
              //         initialDate:
              //             currentValue ?? DateTime.now(),
              //         lastDate: DateTime(2100));
              //     if (date != null) {
              //       final time = await showTimePicker(
              //         context: context,
              //         initialTime: TimeOfDay.fromDateTime(
              //             currentValue ?? DateTime.now()),
              //       );
              //       return DateTimeField.combine(
              //           date, time);
              //     } else {
              //       return currentValue;
              //       // return _dateFrom;
              //     }
              //   },
              // ),
              // SizedBox(
              //   height: 26,
              // ),
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: WidgetStateProperty.all(1.0),
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.secondary,
                      )),
                  child: Row(
                    children: [
                      AutoSizeText(
                        "Upload Paid Receipt",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.add_a_photo)
                    ],
                  ),
                  onPressed: () {
                    startImagePicker(context);
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SingleChildScrollView(
                child: Center(
                  child: root(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              model.state == ViewState.Busy
                  ? kLoadingWidget(context)
                  : T6Button(
                      textContent: 'Submit',
                      onPressed: () async {
                        if (_selectedvalue.isEmpty) {
                          Tools.showErrorToast('Please enter a name');
                          return;
                        }

                        if (_note.text.isEmpty) {
                          Tools.showErrorToast('Please enter a note');

                          return;
                        }

                        if (imageFile == null) {
                          Tools.showErrorToast(
                              'Please enter picked paid payment screenshots');

                          return;
                        }
                        if (_selectedPackage == null) {
                          Tools.showErrorToast('Please select a package');
                        }
                        await model.manualpayment(
                          imageFile: imageFile,
                          paidText: _selectedvalue,
                          noteText: _note.text,
                          packageText: _selectedPackage.id.toString(),
                          dateFrom: DateTime.now().toString(),

                          // passwordText: _passwordController.text,
                          // confirmPasswordText:
                          //     _confirmPasswordController.text,
                        );
                        print('This is selected package' +
                            _selectedPackage.id.toString());

                        // if (paymentSuccess) {
                        //   Tools.showSuccessToast('Payment is success');
                      }),
              SizedBox(
                height: 50,
              ),
              // MedUI.AutoSizeText('Note: Please add a description in note '),
            ],
          ),
        ),
      ),
    );
  }

  Widget root() {
    return Container(
      child: imageFile != null
          ? Image.file(
              imageFile,
              height: MediaQuery.of(context).size.height / 5,
            )
          : AutoSizeText("Pick up the image"),
    );
  }
}

// class ImageInputAdapter {
//   /// Initialize from either a URL or a file, but not both.
//   ImageInputAdapter({
//     this.file,
//     this.url
//   }) : assert(file != null || url != null), assert(file != null && url == null), assert(file == null && url != null);

//   /// An image file
//   final File file;
//   /// A direct link to the remote image
//   final String url;

//   /// Render the image from a file or from a remote source.
//   Widget widgetize() {
//     if (file != null) {
//       return Image.file(file);
//     } else {
//       return FadeInImage(
//         image: NetworkImage(url),
//         placeholder: AssetImage("assets/images/placeholder.png"),
//         fit: BoxFit.contain,
//       );
//     }
//   }
// }