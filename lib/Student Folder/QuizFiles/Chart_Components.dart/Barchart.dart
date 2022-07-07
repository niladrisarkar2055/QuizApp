import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Barchart extends StatefulWidget {
  const Barchart({Key? key}) : super(key: key);

  @override
  State<Barchart> createState() => _BarchartState();
}

class _BarchartState extends State<Barchart> {
  late List<charts.Series<Pollution, String>> _seriesData = [];
  _generateData() {
     var data1 = [
      new Pollution(1980, 'USA', 30),
      new Pollution(1980, 'Asia', 40),
      new Pollution(1980, 'Europe', 10),
    ];
    var data2 = [
      new Pollution(1985, 'USA', 100),
      new Pollution(1980, 'Asia', 150),
      new Pollution(1985, 'Europe', 80),
    ];
    var data3 = [
      new Pollution(1985, 'USA', 200),
      new Pollution(1980, 'Asia', 300),
      new Pollution(1985, 'Europe', 180),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesData = <charts.Series<Pollution, String>>[];
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.all(10),
       height: MediaQuery.of(context).size.height*0.6,
    width: MediaQuery.of(context).size. width *0.9,
      decoration: BoxDecoration(
           color: Colors.transparent,
           borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'SO₂ emissions, by world region (in million tonnes)',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: charts.BarChart(
                    _seriesData,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    //behaviors: [new charts.SeriesLegend()],
                    animationDuration: Duration(seconds: 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Bar data
class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}
