import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BookmarkedQuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Container(
                  width: screenSize.width /
                      (2 / (screenSize.height / screenSize.width)),
                  child: Padding(
                    child: AutoSizeText(
                      'Bookmarked Questions',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      bottom: 20,
                      right: 10,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: AutoSizeText(
                    'Bookmarked Question Screen is Under Development.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
