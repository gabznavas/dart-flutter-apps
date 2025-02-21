import 'package:flutter/material.dart';

class FinalScore extends StatelessWidget {
  final int _score;
  final void Function() _resetAsks;

  const FinalScore(this._score, this._resetAsks, {super.key});

  @override
  Widget build(BuildContext context) {
    String text = "Parabéns!";

    if (_score > 10) {
      text = "Impressionante";
    }
    if (_score > 18) {
      text = "Semi-Deus!";
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Seu score: $text',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          ElevatedButton(onPressed: () => _resetAsks(), child: Text('Resetar')),
        ],
      ),
    );
  }
}
