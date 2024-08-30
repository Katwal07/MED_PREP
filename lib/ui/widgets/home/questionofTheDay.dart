import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../enums/correct_answer.dart';
import '../../../enums/viewstate.dart';
import '../../screens/base_screen.dart';
import '../../viewmodels/qod_model.dart';
import '../shimmer/question_of_day_shimmer.dart';
import '../workout/floating_question_modal.dart';
import 'qod_explanation.dart';

class QuestionofTheDay extends StatefulWidget {
  @override
  _QuestionofTheDayState createState() => _QuestionofTheDayState();
}

class _QuestionofTheDayState extends State<QuestionofTheDay> {
  int? selectedRadioTile;
  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.lightBlueAccent,
      child: BaseScreen<QuestionOfDayModel>(
        onModelReady: (model) => model.getQuestionOfDay(),
        builder: (context, model, child) => model.state == ViewState.Busy
            ? QODShimmer()
            : model.hasQuestion
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: HtmlWidget(
                          model.qodQuestion!.question!,
                          customStylesBuilder: (e) {
                            return {
                              'color': 'black',
                              'font-size': '18px',
                              'font-weight': 'normal'
                            };
                          },
                        ),
                      ),
                      Divider(),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: selectedRadioTile == 1
                                ? BoxDecoration(
                                    border:
                                        Border.all(color: Colors.red, width: 2))
                                : BoxDecoration(
                                    border: Border.all(color: Colors.black26)),
                            child: RadioListTile(
                              value: 1,
                              groupValue: selectedRadioTile,
                              title: AutoSizeText(
                                model.qodQuestion!.optionA!,
                              ),
                              activeColor: Colors.red,
                              onChanged: (val) {
                                setSelectedRadioTile(val!);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: selectedRadioTile == 2
                                ? BoxDecoration(
                                    border:
                                        Border.all(color: Colors.red, width: 2))
                                : BoxDecoration(
                                    border: Border.all(color: Colors.black26)),
                            child: RadioListTile(
                              value: 2,
                              groupValue: selectedRadioTile,
                              title: AutoSizeText(
                                model.qodQuestion!.optionB!,
                              ),
                              activeColor: Colors.red,
                              onChanged: (val) {
                                setSelectedRadioTile(val!);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: selectedRadioTile == 3
                                ? BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 2))
                                : BoxDecoration(
                                    border: Border.all(color: Colors.black26)),
                            child: RadioListTile(
                              value: 3,
                              groupValue: selectedRadioTile,
                              title: AutoSizeText(model.qodQuestion!.optionC!),
                              activeColor: Colors.green,
                              onChanged: (val) {
                                setSelectedRadioTile(val!);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: selectedRadioTile == 4
                                ? BoxDecoration(
                                    border:
                                        Border.all(color: Colors.red, width: 2))
                                : BoxDecoration(
                                    border: Border.all(color: Colors.black26)),
                            child: RadioListTile(
                              value: 4,
                              groupValue: selectedRadioTile,
                              title: AutoSizeText(model.qodQuestion!.optionD!),
                              activeColor: Colors.red,
                              onChanged: (val) {
                                setSelectedRadioTile(val!);
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.6),
                              )),
                              onPressed: selectedRadioTile == 0
                                  ? null
                                  : () {
                                      showFloatingModalBottomSheet(
                                        builder: (context) {
                                          return QodExplanation(
                                            question: model.qodQuestion!,
                                            selectedAnswer:
                                                numberToSelectedOption()!,
                                          );
                                        },
                                        context: context,
                                      );
                                    },
                              child: AutoSizeText(
                                'View Explanation',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : Center(
                    child: AutoSizeText('Failed to fetch questions'),
                  ),
      ),
    );
  }

  AnswerOption? numberToSelectedOption() {
    if (selectedRadioTile == 1) {
      return AnswerOption.A;
    } else if (selectedRadioTile == 2) {
      return AnswerOption.B;
    } else if (selectedRadioTile == 3) {
      return AnswerOption.C;
    } else if (selectedRadioTile == 4) {
      return AnswerOption.D;
    } else {
      return null;
    }
  }
}
