import 'package:ask_flutter/ask.dart';
import 'package:ask_flutter/data.dart';
import 'package:ask_flutter/final_score.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  var _selectedAsk = 0;
  var _score = 0;
  List<Map<String, Object>> asks = [];
  Map<String, Object> askSelected = {};

  _ContentState() {
    asks.addAll(asksData);
  }

  @override
  Widget build(BuildContext context) {
    return _hasNextAsk()
        ? Ask(asks[_selectedAsk], _nextAsk)
        : FinalScore(_score, _resetAsks);
  }

  void _nextAsk(int score) {
    setState(() {
      _score = _score + score;
      _selectedAsk++;
    });
  }

  bool _hasNextAsk() {
    return _selectedAsk < asks.length;
  }

  void _resetAsks() {
    setState(() {
      _selectedAsk = 0;
      _score = 0;
    });
  }
}
