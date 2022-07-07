import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Linechart extends StatefulWidget {
  const Linechart({Key? key}) : super(key: key);

  @override
  State<Linechart> createState() => _LinechartState();
}

class _LinechartState extends State<Linechart> {
  late List<charts.Series<Sales, int>> _seriesLineData = [];
  //For generating datasets
  _generateData() {
    // Line dataset
    var linesalesdata1 = [
      Sales(0, 45),
      Sales(1, 56),
      Sales(2, 55),
      Sales(3, 60),
      Sales(4, 61),
      Sales(5, 70),
    ];
    var linesalesdata2 = [
      Sales(0, 35),
      Sales(1, 46),
      Sales(2, 45),
      Sales(3, 50),
      Sales(4, 51),
      Sales(5, 60),
    ];

    var linesalesdata3 = [
      Sales(0, 20),
      Sales(1, 24),
      Sales(2, 25),
      Sales(3, 40),
      Sales(4, 45),
      Sales(5, 60),
    ];
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 23, 153, 0)),
        id: 'Air Pollution',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Color.fromARGB(255, 10, 30, 181)),
        id: 'Air Pollution',
        data: linesalesdata3,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    _seriesLineData = <charts.Series<Sales, int>>[];
   
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
            children: [
              const Text(
                'Sales for the first 5 years',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: charts.LineChart(_seriesLineData,
                    defaultRenderer: charts.LineRendererConfig(
                        includeArea: true, stacked: true),
                    animate: true,
                    animationDuration: Duration(seconds: 1),
                    behaviors: [
                      charts.ChartTitle('Years',
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      charts.ChartTitle('Sales',
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea),
                      charts.ChartTitle(
                        'Departments',
                        behaviorPosition: charts.BehaviorPosition.end,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea,
                      )
                    ]),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
