// ignore_for_file: unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:med_prep/common/tools.dart';

import '../../constants/colors.dart';

class ReportScreen extends StatefulWidget {
  final String? questionId;
  final String? questionTitle;

  const ReportScreen({
    Key? key,
    this.questionId,
    this.questionTitle,
  }) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print(widget.questionId);
    final screenSize = MediaQuery.of(context).size;

    return Wrap(spacing: 10, runSpacing: 10, children: [
      Form(
        key: _formKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AutoSizeText("Report Question",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ),
              SizedBox(height: 10.0),
              MedUI.AutoSizeText(
                'Question:',
                textColor: tTextColorPrimary,
              ),
              Html(
                data: widget.questionTitle,
                // Styling with CSS (not real CSS)
                style: {
                  'h1': Style(color: Colors.black, fontWeight: FontWeight.w600),
                  'p': Style(
                    color: Colors.black87,
                    fontSize: FontSize.larger,
                    fontWeight: FontWeight.w600,
                    before: 'Q. ',
                  ),
                },
              ),
              MedUI.AutoSizeText(
                'Description: ',
                textColor: tTextColorPrimary,
              ),
              SizedBox(height: 10.0),
              Container(
                height: 150,
                child: TextField(
                  controller: _descriptionController,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLines: 5,
                  maxLength: 120,
                  decoration: InputDecoration(
                    hintText: 'Write problems about this question ',
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.4), width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2), width: 1.0),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    // labelText: 'Description',
                    // labelStyle: TextStyle(
                    //   color: Colors.black.withOpacity(0.8),
                    //   fontSize: 18,
                    // ),
                    hintMaxLines: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Center(
        child: MaterialButton(
          color: Colors.grey[800],
          onPressed: () async {
            if (_descriptionController.text.trim().isEmpty) {
              Tools.showErrorToast('Description can\'t be empty');
              return;
            }
          },
          child: AutoSizeText(
            'Report Issue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ]);
  }
}
