import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../models/question.dart';

class QuestionDetailScreen extends StatelessWidget {
  final Question question;

  const QuestionDetailScreen({
    Key? key,
    required this.question,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AutoSizeText(question.question!),
          AutoSizeText(question.explanation!),
          AutoSizeText(question.optionA!),
        ],
      ),
    );
  }
}
