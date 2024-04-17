import 'package:assignment2/view/widgets/pie_chart/sector.dart';
import 'package:assignment2/view/widgets/pie_chart/sector_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PieChartWidget extends StatelessWidget {
  final List<String> currency;
  final List<double> amount;
  final List<Color> colors;
  final String convertedCurrency;

  const PieChartWidget({Key? key, required this.currency, required this.amount, required this.convertedCurrency, required this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = SectorData(currency, amount,colors);
    data.initializeSectorData();

    return Column(
      children: [
        AspectRatio(
            aspectRatio: 1.0,
            child: PieChart(PieChartData(
              sections: _chartSections(data.sectorData, context),
              centerSpaceRadius: 0,
            ))),
        getGraphKey(data.sectorData)
      ],
    );
  }

  Widget getGraphKey(List<Sector> sectors) {
    return Container( margin: const EdgeInsets.all(20), child: Column(children: getColumns(sectors)));
  }

  List<Widget> getColumns(List<Sector> sectors) {
    var format = NumberFormat.simpleCurrency(locale: "pt");

    List<Widget> keyList = [];
    for (var sector in sectors) {
      keyList.add(
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "${sector.title} (${format.simpleCurrencySymbol(convertedCurrency)} ${sector.value.toString()} $convertedCurrency)",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: sector.color,
                shape: BoxShape.circle,
              ),
            )
          ]
          )
      );
      keyList.add(const SizedBox(
        height: 15,
      ));
    }
    return keyList;
  }

  List<PieChartSectionData> _chartSections(
      List<Sector> sectors, BuildContext context) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      final data = PieChartSectionData(
          showTitle: false,
          color: sector.color,
          value: sector.value,
          radius: MediaQuery.of(context).size.width / 2 - 50,
      );
      list.add(data);
    }
    return list;
  }
}
