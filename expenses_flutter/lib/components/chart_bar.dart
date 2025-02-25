import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        final value = constraints.maxHeight * 0.11;
        final separator = constraints.maxHeight * 0.05;
        final bar = constraints.maxHeight * 0.62;
        final label = constraints.maxHeight * 0.15;
        return Column(
          children: [
            _renderValue(value),
            _renderSeparator(separator),
            _renderBar(context, bar),
            _renderSeparator(separator),
            _renderLabel(label),
          ],
        );
      },
    );
  }

  SizedBox _renderValue(double height) {
    return SizedBox(
      height: height,
      child: FittedBox(child: Text(value.toStringAsFixed(2))),
    );
  }

  SizedBox _renderSeparator(double height) {
    return SizedBox(height: height);
  }

  SizedBox _renderLabel(double height) =>
      SizedBox(height: height, child: Text(label));

  SizedBox _renderBar(BuildContext context, double height) {
    return SizedBox(
      height: height,
      width: 10,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [_renderBarcandle(), _renderBackgroundBar(context)],
      ),
    );
  }

  Container _renderBarcandle() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        color: Color.fromRGBO(220, 220, 220, 1),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  FractionallySizedBox _renderBackgroundBar(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: percentage,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
