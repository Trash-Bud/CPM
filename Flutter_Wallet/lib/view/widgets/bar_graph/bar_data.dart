import 'dart:ui';

import 'individual_bar.dart';

class BarData {
  final List<String> currency;
  final List<double> amount;
  final List<Color> colors;

  List<IndividualBar> barData = [];

  BarData(this.currency, this.amount, this.colors);

  void initializeBarData() {
    for (var i = 0; i <amount.length; i++) {
      barData.add(IndividualBar(i, double.parse(amount[i].toStringAsFixed(5)),colors[i]));
    }
  }
}
