import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'dart:async';

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key? key, required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: AutoSizeText('Treasure Name',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      // decoration: BoxDecoration(
                      //   shape: BoxShape.circle,
                      //   color: Colors.white.withOpacity(0.2),
                      // ),
                      child: AutoSizeText(
                        snapshot.data!,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  );
                }
                return SizedBox();
              }),
        ],
      ),
      body: PDF(
        password: 'Hello123',
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        pageSnap: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) =>
            Center(child: AutoSizeText(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      heroTag: '<',
                      child: const AutoSizeText(
                        '<',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      onPressed: () async {
                        final PDFViewController pdfController = snapshot.data!;
                        final int currentPage =
                            (await pdfController.getCurrentPage())! - 1;
                        if (currentPage >= 0) {
                          await pdfController.setPage(currentPage);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      heroTag: '>',
                      child: const AutoSizeText(
                        '>',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      onPressed: () async {
                        final PDFViewController pdfController = snapshot.data!;
                        final int currentPage =
                            (await pdfController.getCurrentPage())! + 1;
                        final int numberOfPages =
                            await pdfController.getPageCount() ?? 0;
                        if (numberOfPages > currentPage) {
                          await pdfController.setPage(currentPage);
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
