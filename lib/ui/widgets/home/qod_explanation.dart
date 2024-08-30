import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../enums/correct_answer.dart';
import '../../../models/question.dart';
import '../../constants/helper.dart';

class QodExplanation extends StatelessWidget {
  final Question question;

  final AnswerOption selectedAnswer;

  const QodExplanation({
    Key? key,
    required this.question,
    required this.selectedAnswer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 400,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              AutoSizeText(
                'Explanation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                margin: EdgeInsets.only(bottom: 2.0),
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.freeCodeCamp,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 20,
                  ),
                  title: AutoSizeText(
                    'Answer: ${HelperUIFunctions.getAnswerFromSelectedAnswerOption(question: question)}',
                    style: TextStyle(
                        fontSize: 16,
                        color: HelperUIFunctions.isAnswerCorrect(
                                question: question,
                                answerOption: selectedAnswer)
                            ? Colors.black
                            : Colors.red),
                  ),
                  trailing: Icon(
                    HelperUIFunctions.isAnswerCorrect(
                            question: question, answerOption: selectedAnswer)
                        ? FontAwesomeIcons.check
                        : FontAwesomeIcons.xmark,
                    size: 18,
                    color: HelperUIFunctions.isAnswerCorrect(
                            question: question, answerOption: selectedAnswer)
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.red,
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                margin: EdgeInsets.only(bottom: 2.0),
                elevation: 0,
                child: HtmlWidget(
                  question.explanation!,
                  customStylesBuilder: (e) {
                    return {
                      'color': 'black',
                      'font-size': '16px',
                      'font-weight': 'normal'
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
