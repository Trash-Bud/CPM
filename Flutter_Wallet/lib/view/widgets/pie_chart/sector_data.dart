
import 'dart:math';
import 'dart:ui';
import 'package:assignment2/view/widgets/pie_chart/sector.dart';

class SectorData{

  final List<String> currency;
  final List<double> amount;
  final List<Color> colors;

  List<Sector> sectorData = [];

  SectorData(this.currency, this.amount, this.colors);

  void initializeSectorData() {
    for (var i = 0; i <amount.length; i++) {
      sectorData.add(Sector(currency[i], amount[i], colors[i]));
    }
  }
}