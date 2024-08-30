import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../../models/chapter.dart';
import '../home/subject_icon_items.dart';
import 'chip_text.dart';
import 'question_configuration.dart';
import 'question_loading_widget.dart';

class QuestionFilterContainer extends StatefulWidget {
  final bool fromSubject;
  final SubjectItem? subject;
  final List<Chapter> selectedChapters;

  const QuestionFilterContainer(
      {Key? key,
      this.fromSubject = false,
      this.subject,
      required this.selectedChapters})
      : super(key: key);
  @override
  _QuestionFilterContainerState createState() =>
      _QuestionFilterContainerState();
}

class _QuestionFilterContainerState extends State<QuestionFilterContainer> {
  bool isSimulateTest = false;
  TextEditingController timeController = TextEditingController();

  TextEditingController totalQuestionController = TextEditingController();

  String dropdownValue = 'any';

  List<int> yearArray = [];

  @override
  void initState() {
    timeController.text = '100';
    totalQuestionController.text = '50';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('these are selected chapters ${widget.selectedChapters}}');
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          AutoSizeText(
            'Question Filter',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          widget.fromSubject
              ? Card(
                  margin: EdgeInsets.only(bottom: 2.0),
                  elevation: 0,
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.question,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 20,
                    ),
                    title: AutoSizeText(
                      'Selected Subject:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Container(
                      width: 80,
                      child: AutoSizeText(
                        widget.subject!.section!.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Card(
            margin: EdgeInsets.only(bottom: 2.0),
            elevation: 0,
            child: SwitchListTile(
              secondary: Icon(
                FontAwesomeIcons.accessibleIcon,
                color: Theme.of(context).colorScheme.secondary,
              ),
              value: isSimulateTest,
              activeColor: Theme.of(context).colorScheme.secondary,
              onChanged: (bool value) {
                setState(() {
                  isSimulateTest = value;
                });
              },
              title: AutoSizeText(
                'Simulate Test',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          isSimulateTest
              ? Card(
                  margin: EdgeInsets.only(bottom: 2.0),
                  elevation: 0,
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.clock,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 20,
                    ),
                    title: AutoSizeText(
                      'Simulated Time (min)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    trailing: Container(
                      width: 80,
                      child: TextField(
                        controller: timeController,
                      ),
                    ),
                  ))
              : Container(),
          Card(
              margin: EdgeInsets.only(bottom: 2.0),
              elevation: 0,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.question,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20,
                ),
                title: AutoSizeText(
                  'Total Questions',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Container(
                  width: 80,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: totalQuestionController,
                  ),
                ),
              )),
          Card(
              margin: EdgeInsets.only(bottom: 2.0),
              elevation: 0,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.hammer,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20,
                ),
                title: AutoSizeText(
                  'Select Difficulty',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                trailing: Container(
                  width: 80,
                  child: DropdownButton(
                      isExpanded: true,
                      value: dropdownValue,
                      items: [
                        DropdownMenuItem<String>(
                          child: AutoSizeText('Any'),
                          value: 'any',
                        ),
                        DropdownMenuItem<String>(
                          child: AutoSizeText(
                            'Easy',
                            style: TextStyle(fontSize: 15),
                          ),
                          value: 'easy',
                        ),
                        DropdownMenuItem<String>(
                          child: AutoSizeText(
                            'Normal',
                            style: TextStyle(fontSize: 15),
                          ),
                          value: 'normal',
                        ),
                        DropdownMenuItem<String>(
                          child: AutoSizeText(
                            'Difficult',
                            style: TextStyle(fontSize: 15),
                          ),
                          value: 'difficult',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      }),
                ),
              )),
          Card(
              margin: EdgeInsets.only(bottom: 2.0),
              elevation: 0,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.calendarCheck,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20,
                ),
                title: AutoSizeText(
                  'Select Years',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )),
          OptionChip(
            optionChips: ['Any', '2017', '2018', '2019', '2020'],
            onChanged: (years) {
              yearArray = years;
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              // debugger();
              Get.offAll(() => QuestionLoadingWidget(
                    questionConfiguration: QuestionConfiguration(
                      isSimulateTest: isSimulateTest,
                      difficuly: dropdownValue,
                      timeInMinute: int.parse(timeController.text),
                      totalQuestion: int.parse(totalQuestionController.text),
                      selectedYears: yearArray,
                      subjects: [widget.subject!],
                      chapters: widget.selectedChapters,
                    ),
                  ));
            },
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.secondary)),
            child: AutoSizeText(
              'START PRACTICE',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
