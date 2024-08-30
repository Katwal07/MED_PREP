import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../../common/tools.dart';
import '../../../enums/viewstate.dart';
import '../../constants/loading.dart';
import '../../widgets/topic/topic_create_modal.dart';
import '../../widgets/topic/topic_item_widget.dart';
import '../base_screen.dart';
import 'discussion_model.dart';

class DiscussionScreen extends StatefulWidget {
  final String? questionId;
  final String? questionTitle;

  const DiscussionScreen({
    Key? key,
    this.questionId,
    this.questionTitle,
  }) : super(key: key);
  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool shouldReload = false;

  String? tempQuestion;
  String? tempQuestionTitle;

  @override
  void initState() {
    super.initState();
    tempQuestion = widget.questionId;
    tempQuestionTitle = widget.questionTitle;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(widget.questionId);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var isCreated = await showFloatingModalBottomSheetForTopicCreation(
              context: context,
              builder: (context) {
                return BaseScreen<DiscussionModel>(
                  builder: (context, model, child) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView(
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter a Topic Name',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(
                                  0.4,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 3.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                    width: 2.0),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Topic Name',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _descriptionController,
                            // maxLengthEnforced: true,
                            maxLines: 5,
                            maxLength: 120,
                            decoration: InputDecoration(
                              hintText: 'Write description about this topic',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(
                                  0.4,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 3.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                    width: 2.0),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Description',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 18,
                              ),
                              hintMaxLines: 5,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).colorScheme.secondary,
                                )),
                                onPressed: () {
                                  if (_nameController.text.trim().isEmpty) {
                                    Tools.showErrorToast(
                                        'Topic name can\'t be empty');
                                    return;
                                  }
                                  model
                                      .createTopic(
                                          name: _nameController.text.trim(),
                                          description: _descriptionController
                                              .text
                                              .trim())
                                      .then((value) {
                                    if (value) {
                                      Tools.showSuccessToast(
                                          'Successfully Created Topic ${_nameController.text}');
                                      _nameController.text = '';
                                      _descriptionController.text = '';
                                      Get.back(result: true);
                                    } else {
                                      Tools.showErrorToast(
                                          'Failed to Create Topic with Name ${_nameController.text}');
                                    }
                                  });
                                },
                                child: AutoSizeText(
                                  'Create Topic',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              });
          if (isCreated == true) {
            setState(() {
              shouldReload = true;
            });
          }
        },
        child: Icon(
          FontAwesomeIcons.plus,
          size: 18,
        ),
      ),
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
                      "Discussions",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
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
                child: BaseScreen<DiscussionModel>(
              onModelReady: (model) => model.fetchAllTopics(),
              builder: (context, model, child) {
                if (shouldReload) {
                  model.fetchAllTopics();
                  shouldReload = false;
                }
                if (model.state == ViewState.Busy) {
                  return kLoadingWidget(context);
                } else {
                  if (model.topicList == null) {
                    return Center(
                      child: AutoSizeText('Failed to fetch Topics'),
                    );
                  } else if (model.topicList!.topics.isEmpty) {
                    return Center(
                      child: AutoSizeText('We do not have topics for you!'),
                    );
                  }
                  {
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: ListView.builder(
                        itemCount: model.topicList!.topics.length,
                        itemBuilder: (context, index) {
                          return TopicItemWidget(
                            topic: model.topicList!.topics[index],
                            questionId: tempQuestion!,
                            questionTitle: tempQuestionTitle!,
                          );
                        },
                      ),
                    );
                  }
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
