import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/tools.dart';
import '../../../locator.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/file_service.dart';
import '../../../services/storage_service.dart';
import '../../viewmodels/account_model.dart';
import '../base_screen.dart';
import '../email-verification/not_verified_screen.dart';
import '../payment/payment_screen.dart';
import '../programSelection/programSelectionv2.dart';
import '../user-stat/user_stat_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with AutomaticKeepAliveClientMixin {
  Api _api = locator<Api>();
  FileService _fileService = FileService();
  late bool enableNotification;

  late String image;
  @override
  void initState() {
    super.initState();
    getImage();
    _api.getMe().then((user) {
      enableNotification = user.enableNotification!;
      if (user.isUserVerified == false) {
        Get.offAll(NotVerifiedScreen(user: user));
      }
      setState(() {});
    });
  }

  StorageService _storageService = locator<StorageService>();
  launchURL(String url) async {
    await Tools.launchURL(context, url);
  }

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
                    'Select Image',
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
      final pickedImage =
          await _fileService.pickImage(ImageSource.gallery, true);
      if (pickedImage == null) {
        return Tools.showErrorToast('Image Picking Canceled');
      } else {
        Tools.showLoadingModal();
        await _api.updateUserProfilePicture(image: pickedImage).then((value) {
          Tools.dismissLoadingModal();
          setState(() {});
          // setState(() {
          _storageService.saveImage(pickedImage.path);
          // });
          // // if (value.) {

          // }
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> photoFromCamera() async {
    Get.back();
    try {
      final pickedImage =
          await _fileService.pickImage(ImageSource.camera, true);
      if (pickedImage == null) {
        return Tools.showErrorToast('Image Picking Canceled');
      } else {
        Tools.showLoadingModal();
        await _api.updateUserProfilePicture(image: pickedImage).then((value) {
          Tools.dismissLoadingModal();
          setState(() {});
          // setState(() {
          _storageService.saveImage(pickedImage.path);
          // });
        });
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // User user = Provider.of<User>(context);
    return BaseScreen<AccountModel>(
      builder: (context, model, child) => Container(
        color: Colors.lightBlueAccent,
        child: SafeArea(
          child: Scaffold(
            body: Container(
              color: Colors.lightBlueAccent,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: FutureBuilder<User>(
                        future: _storageService.getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            User? user = snapshot.data;
                            return Container(
                              height: 150,
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 90,
                                          child: user!.photoUrl != null ||
                                                  user.photoUrl!.isNotEmpty
                                              ? CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                    user.photoUrl!,
                                                  ),
                                                  // child: Image.network(
                                                  //   user.photoUrl,
                                                  //   fit: BoxFit.contain,
                                                  // ),
                                                )
                                              : CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                    user.photoUrl!,
                                                  ),
                                                ),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(60))),
                                        ),
                                        Positioned(
                                          right: 0.0,
                                          bottom: 0,
                                          child: Container(
                                            height: 27.0,
                                            width: 27.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0.5,
                                                  blurRadius: 2.0,
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              padding:
                                                  EdgeInsets.only(bottom: 1.5),
                                              onPressed: () {
                                                startImagePicker(context);
                                              },
                                              icon: Center(
                                                  child: Icon(
                                                Icons.photo_camera,
                                                size: 18.0,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    AutoSizeText(
                                      user.name ?? "Med Prep User",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    AutoSizeText(
                                      user.email ?? "Med Prep User",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return Container();
                        }),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                              child: AutoSizeText(
                                "General Settings",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Card(
                                    margin: EdgeInsets.only(bottom: 2.0),
                                    elevation: 0,
                                    child: SwitchListTile(
                                      secondary: Icon(
                                        FontAwesomeIcons.bell,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      value: enableNotification,
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onChanged: (bool value) {
                                        enableNotification = value;
                                        model.toggleNotificationSwitch(value);
                                        setState(() {});
                                        print(value);
                                      },
                                      title: AutoSizeText(
                                        'Receive Notifications',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                    height: 1.0,
                                    indent: 75,
                                    //endIndent: 20,
                                  ),
                                  Card(
                                    margin: EdgeInsets.only(bottom: 2.0),
                                    elevation: 0,
                                    child: ListTile(
                                      leading: Icon(
                                        FontAwesomeIcons.freeCodeCamp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 20,
                                      ),
                                      title: AutoSizeText(
                                        'My Stats',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios,
                                          size: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      onTap: () {
                                        Get.to(() => UserStatScreen());
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                    height: 1.0,
                                    indent: 75,
                                    //endIndent: 20,
                                  ),
                                  Card(
                                    margin: EdgeInsets.only(bottom: 2.0),
                                    elevation: 0,
                                    child: ListTile(
                                      leading: Icon(
                                        FontAwesomeIcons.coins,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 20,
                                      ),
                                      title: AutoSizeText(
                                        'My Payment',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios,
                                          size: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      onTap: () {
                                        Get.to(() => PaymentScreen());
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                    height: 1.0,
                                    indent: 75,
                                    //endIndent: 20,
                                  ),
                                  // Card(
                                  //   margin: EdgeInsets.only(bottom: 2.0),
                                  //   elevation: 0,
                                  //   child: ListTile(
                                  //     leading: Icon(
                                  //       FontAwesomeIcons.star,
                                  //       color: Theme.of(context)
                                  //           .colorScheme
                                  //           .secondary,
                                  //       size: 20,
                                  //     ),
                                  //     title: AutoSizeText(
                                  //       'Rate The App',
                                  //       style: TextStyle(fontSize: 16),
                                  //     ),
                                  //     trailing: Icon(Icons.arrow_forward_ios,
                                  //         size: 18,
                                  //         color: Theme.of(context)
                                  //             .colorScheme
                                  //             .secondary),
                                  //     onTap: () {},
                                  //   ),
                                  // ),
                                  // Divider(
                                  //   color: Colors.black12,
                                  //   height: 1.0,
                                  //   indent: 75,
                                  //   //endIndent: 20,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      const url = 'https://medprepnepal.com/';
                                      launchURL(url);
                                    },
                                    child: Card(
                                      margin: EdgeInsets.only(bottom: 2.0),
                                      elevation: 0,
                                      child: ListTile(
                                        leading: Icon(
                                          FontAwesomeIcons.lock,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          size: 20,
                                        ),
                                        title: AutoSizeText(
                                          'Read Our Privacy',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        trailing: Icon(Icons.arrow_forward_ios,
                                            size: 18,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        onTap: () async {
                                          String url =
                                              "https://medprepnepal.com/";
                                          Tools.launchURL(context, url);
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                    height: 1.0,
                                    indent: 75,
                                    //endIndent: 20,
                                  ),
                                  Card(
                                    margin: EdgeInsets.only(bottom: 2.0),
                                    elevation: 0,
                                    child: ListTile(
                                      leading: Icon(
                                        FontAwesomeIcons.handPointUp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 20,
                                      ),
                                      title: AutoSizeText(
                                        'Select Program',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios,
                                          size: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      onTap: () {
                                        Get.to(() => ProgramSelectV2());
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                    height: 1.0,
                                    indent: 75,
                                    //endIndent: 20,
                                  ),
                                  Card(
                                    margin: EdgeInsets.only(bottom: 2.0),
                                    elevation: 0,
                                    child: ListTile(
                                      leading: Icon(
                                        FontAwesomeIcons.info,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 20,
                                      ),
                                      title: AutoSizeText(
                                        'About Us',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios,
                                          size: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      onTap: () {
                                        String url =
                                            "https://medprepnepal.com/";
                                        Tools.launchURL(context, url);
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black12,
                                    height: 1.0,
                                    indent: 75,
                                    //endIndent: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> getImage() async {
    image = (await _storageService.getImage())!;
  }
}
