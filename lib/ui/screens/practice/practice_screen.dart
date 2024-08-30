import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../../enums/correct_answer.dart';
import '../../../locator.dart';
import '../../../models/question.dart';
import '../../../services/api_service.dart';
import '../../../tabbar.dart';
import '../../constants/loading.dart';

class PracticeScreen extends StatefulWidget {
  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
   Question? myQuestion;

   AnswerOption? selectedAnswer;

  bool isLoading = true;

  bool isSubmitted = false;

  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchRandomQuestion();
  }

  fetchRandomQuestion() async {
    setState(() {
      isLoading = true;
    });
    try {
      myQuestion = await locator<Api>().getRandomQuestion();
      print(myQuestion!.correctAnswer);
      setState(() {
        hasError = false;
      });
    } catch (err) {
      setState(() {
        hasError = true;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafbfc),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => MainTabs());
                      },
                      child: AutoSizeText('Exit'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: hasError
                    ? Center(
                        child: Column(
                          children: [
                            AutoSizeText(
                                'Error While Fetching Question. Check you internet connection. Try again later.'),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.secondary,
                              )),
                              onPressed: () {
                                fetchRandomQuestion();
                              },
                              child: AutoSizeText(
                                'Refresh',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: isLoading
                            ? kLoadingWidget(context)
                            : getRandomQuestionFromOtherHtmlParser(),
                      ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.secondary,
                    )),
                    onPressed: selectedAnswer != null
                        ? () {
                            if (isSubmitted) {
                              setState(() {
                                isSubmitted = false;
                                fetchRandomQuestion();
                                selectedAnswer = null;
                              });
                            } else {
                              setState(() {
                                isSubmitted = true;
                              });
                            }
                          }
                        : null,
                    child: AutoSizeText(
                      isSubmitted ? 'Next Question' : 'Submit Answer',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRandomQuestionFromOtherHtmlParser() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // AutoSizeText(
                //   myQuestion?.sectionName ?? 'No Section',
                //   style: TextStyle(color: Colors.black),
                // ),
                SizedBox(
                  height: 20,
                ),

                // ElevatedButton(
                //   color: Colors.blueAccent,
                //   onPressed: () {
                //     fetchRandomQuestion();
                //   },
                //   child: AutoSizeText(
                //     'Random',
                //     style: TextStyle(
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          isSubmitted
              ? AutoSizeText(
                  selectedAnswer == myQuestion!.correctAnswer
                      ? 'Correct Answer'
                      : 'Incorrect Answer.',
                  style: TextStyle(
                    color: selectedAnswer == myQuestion!.correctAnswer
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : AutoSizeText(''),

          SizedBox(
            height: 5,
          ),
          HtmlWidget(
            myQuestion!.question!,
            customStylesBuilder: (e) {
              return {
                'color': 'black',
                'font-size': '18px',
                'font-weight': 'normal'
              };
            },
          ),
          SizedBox(
            height: 10,
          ),
          // Option A
          InkWell(
            onTap: () {
              setState(() {
                selectedAnswer = AnswerOption.A;
              });
            },
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: selectedAnswer == AnswerOption.A
                      ? Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.2,
                          style: BorderStyle.solid,
                        )
                      : null,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                ),
                child: Container(
                  height: 20,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 20,
                          width: 20,
                          color: selectedAnswer == AnswerOption.A
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white,
                          child: Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              'A',
                              style: TextStyle(
                                color: selectedAnswer == AnswerOption.A
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: selectedAnswer == AnswerOption.A
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AutoSizeText(
                          myQuestion!.optionA!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),

          SizedBox(
            height: 10,
          ),
          // Option B
          InkWell(
            onTap: () {
              setState(() {
                selectedAnswer = AnswerOption.B;
              });
            },
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: selectedAnswer == AnswerOption.B
                      ? Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.2,
                          style: BorderStyle.solid,
                        )
                      : null,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                ),
                child: Container(
                  height: 20,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 20,
                          width: 20,
                          color: selectedAnswer == AnswerOption.B
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white,
                          child: Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              'B',
                              style: TextStyle(
                                color: selectedAnswer == AnswerOption.B
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: selectedAnswer == AnswerOption.B
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AutoSizeText(
                          myQuestion!.optionB!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),

          SizedBox(
            height: 10,
          ),
          // Option C
          InkWell(
            onTap: () {
              setState(() {
                selectedAnswer = AnswerOption.C;
              });
            },
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: selectedAnswer == AnswerOption.C
                      ? Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.2,
                          style: BorderStyle.solid,
                        )
                      : null,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                ),
                child: Container(
                  height: 20,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 20,
                          width: 20,
                          color: selectedAnswer == AnswerOption.C
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white,
                          child: Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              'C',
                              style: TextStyle(
                                color: selectedAnswer == AnswerOption.C
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: selectedAnswer == AnswerOption.C
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AutoSizeText(
                          myQuestion!.optionC!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),

          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                selectedAnswer = AnswerOption.D;
              });
            },
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: selectedAnswer == AnswerOption.D
                      ? Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.2,
                          style: BorderStyle.solid,
                        )
                      : null,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                ),
                child: Container(
                  height: 20,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 20,
                          width: 20,
                          color: selectedAnswer == AnswerOption.D
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white,
                          child: Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              'D',
                              style: TextStyle(
                                color: selectedAnswer == AnswerOption.D
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: selectedAnswer == AnswerOption.D
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AutoSizeText(
                          myQuestion!.optionD!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),

          isSubmitted
              ? HtmlWidget(
                  myQuestion!.explanation!,
                  customStylesBuilder: (elm) {
                    if (elm.classes.contains('greenText')) {
                      return {
                        'color': 'blue',
                        'font-weight': 'bold',
                      };
                    }
                    return null;
                  },
                )
              : AutoSizeText('')
        ],
      ),
    );
  }
}
