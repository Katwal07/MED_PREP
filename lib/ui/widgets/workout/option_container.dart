import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../../enums/text_size_state.dart';
import '../../../tabbar.dart';
import '../../screens/base_screen.dart';
import 'option_container_viewmodel.dart';

class OptionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OptionContainer is Building');
    return BaseScreen<OptionContainerViewModel>(
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Container(
        height: 200,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        AutoSizeText(
                          'Font Size',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AutoSizeText(
                            'Sample',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.8),
                              fontSize: model.fontSize(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              model.setTextSize(
                                  textSizeState: TextSizeState.small);
                            },
                            child: AutoSizeText(
                              'aA',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    model.textSizeState == TextSizeState.small
                                        ? Colors.black
                                        : Colors.black.withOpacity(
                                            0.5,
                                          ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              model.setTextSize(
                                  textSizeState: TextSizeState.medium);
                            },
                            child: AutoSizeText(
                              'aA',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    model.textSizeState == TextSizeState.medium
                                        ? Colors.black
                                        : Colors.black.withOpacity(
                                            0.5,
                                          ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              model.setTextSize(
                                textSizeState: TextSizeState.large,
                              );
                            },
                            child: AutoSizeText(
                              'aA',
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    model.textSizeState == TextSizeState.large
                                        ? Colors.black
                                        : Colors.black.withOpacity(
                                            0.5,
                                          ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Expanded(
            //   child: AutoSizeText(
            //     'View Report',
            //   ),
            // ),
            // Expanded(
            //   child: AutoSizeText('Report Issue'),
            // ),
            SwitchListTile(
              secondary: Icon(
                !model.lightMode ? Icons.brightness_2 : Icons.wb_sunny,
                color: Theme.of(context).colorScheme.secondary,
              ),
              value: !model.lightMode,
              activeColor: Theme.of(context).colorScheme.secondary,
              onChanged: (bool value) {
                // model.toggleNotificationSwitch();

                model.setMode(mode: !value);

                // Change Dark Mode Setting
              },
              title: AutoSizeText(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () {
                  // showSignoutConfimationDialog(size);
                  Get.offAll(() => MainTabs());
                },
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Colors.red,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    AutoSizeText(
                      "Exit",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
