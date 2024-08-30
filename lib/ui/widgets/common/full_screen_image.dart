import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

import '../../constants/loading.dart';

// ignore: must_be_immutable
class FullScreenImageScreen extends StatelessWidget {
  String imgUrl;

  FullScreenImageScreen(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText('Full image '),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.more_vert),
          //   onPressed: () {
          //     showDialog(
          //         context: (context),
          //         builder: (context) {
          //           return AlertDialog(
          //             content: InkWell(
          //                 onTap: () async {
          //                   // await checkPermissions(context);
          //                 },
          //                 child: AutoSizeText('Save Image')),
          //           );
          //         });
          //   },
          // )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onVerticalDragStart: (details) {
              if (details.globalPosition.dx > 150) {
                Navigator.pop(context);
              }
            },
            child: PhotoView(
              imageProvider: NetworkImage(imgUrl),
              loadingBuilder: (context, event) {
                return kLoadingWidget(context);
              },
              backgroundDecoration: BoxDecoration(
                color: Colors.white,
              ),
              maxScale: PhotoViewComputedScale.covered * 1.5,
              minScale: PhotoViewComputedScale.contained,
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> checkPermissions(BuildContext context) async {
  //   // This will open Setting page for our app
  //   // openAppSettings();
  //   var status = await Permission.photos.status;

  //   if (status.isDenied && status.isPermanentlyDenied) {
  //     print('Permission is Denied');
  //     return;
  //   }

  //   if (await Permission.storage.request().isGranted) {
  //     print('Permission is granted');
  //     GallerySaver.saveImage(imgUrl).then((bool success) {
  //       Navigator.pop(context);
  //       Fluttertoast.showToast(msg: 'image saved to your gallery !');
  //     });
  //   } else {
  //     PermissionStatus status = await Permission.storage.request();
  //     if (status.isGranted) {
  //       GallerySaver.(imgUrl).then((bool success) {
  //         Navigator.pop(context);
  //         Fluttertoast.showToast(msg: 'Image is saved to your gallery !');
  //       });
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: 'you must accept Permission to save img ! ');
  //     }
  //   }
  // }

}
