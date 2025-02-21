import 'package:ask_flutter/content.dart';
import 'package:flutter/material.dart';

main() {
  runApp(AskApp());
}

class AskApp extends StatelessWidget {
  const AskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('Perguntas'))),
        body: Content(),
      ),
    );
  }
}
