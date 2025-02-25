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
        return Column(
          children: [
            _renderValue(),
            _renderSeparator(constraints),
            _renderBar(constraints, context),
            _renderSeparator(constraints),
            _renderLabel(),
          ],
        );
      },
    );
  }

  SizedBox _renderSeparator(BoxConstraints constraints) {
    return SizedBox(height: constraints.maxHeight * 0.05);
  }

  Text _renderLabel() => Text(label);

  SizedBox _renderValue() {
    return SizedBox(
      height: 15,
      child: FittedBox(child: Text(value.toStringAsFixed(2))),
    );
  }

  SizedBox _renderBar(BoxConstraints constraints, BuildContext context) {
    return SizedBox(
      height: constraints.maxHeight * 0.55,
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
