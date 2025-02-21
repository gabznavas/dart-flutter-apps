import 'package:ask_flutter/answer_button.dart';
import 'package:ask_flutter/ask_text.dart';
import 'package:flutter/material.dart';

class Ask extends StatelessWidget {
  final Map<String, Object> _askSelected;
  final void Function(int index) _nextAsk;

  const Ask(this._askSelected, this._nextAsk, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: _generateAsks());
  }

  List<Widget> _generateAsks() {
    return [_generateAsk(), ..._generateAnswers()];
  }

  Widget _generateAsk() {
    String answers = _askSelected.cast()['ask'];
    return AskText(answers);
  }

  List<Widget> _generateAnswers() {
    List<Widget> items = [];

    // [{'text': 'Elefante', 'score': 8}, ....]
    List<Map<String, Object>> answers = _askSelected.cast()['answers'];
    for (int i = 0; i < answers.length; i++) {
      String text = answers[i].cast()['text'];
      int score = int.parse(answers[i].cast()['score'].toString());
      items.add(AnswerButton(text, () => _nextAsk(score)));
    }
    return items;
  }
}
