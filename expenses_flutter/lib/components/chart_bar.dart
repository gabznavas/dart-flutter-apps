import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar(this.label, this.value, this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('R\$${value.toStringAsFixed(1)}'),
        SizedBox(height: 5),
        Container(height: 60, width: 8, child: null),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
