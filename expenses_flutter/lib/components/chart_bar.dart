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
    /**
     * builder ajuda a criar layout customizadas
     * da altura e largura usando um contexto local
     */
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        final value = constraints.maxHeight * 0.10;
        final separator = constraints.maxHeight * 0.05;
        final bar = constraints.maxHeight * 0.68;
        final label = constraints.maxHeight * 0.12;
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

  SizedBox _renderLabel(double height) {
    return SizedBox(height: height, child: FittedBox(child: Text(label)));
  }

  SizedBox _renderBar(BuildContext context, double height) {
    return SizedBox(
      height: height,
      width: 10,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [_renderBackgroundBar(), _renderBarCandle(context)],
      ),
    );
  }

  Container _renderBackgroundBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        color: Color.fromRGBO(220, 220, 220, 1),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  FractionallySizedBox _renderBarCandle(BuildContext context) {
    final showBorder = percentage > 0;
    final double borderWidth = showBorder ? 1.0 : 0;
    return FractionallySizedBox(
      heightFactor: percentage,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: borderWidth),
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
