import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Piechart extends StatefulWidget {
  const Piechart({Key? key}) : super(key: key);

  @override
  State<Piechart> createState() => _PiechartState();
}

class _PiechartState extends State<Piechart> {
  late List<charts.Series<Task, String>> _seriesPieData = [];

  _generateData() {
    // pie data
    var piedata = [
      Task('Work', 35.8, Colors.deepPurple),
      Task('Eat', 8.3, Color(0xff990099)),
      Task('Commute', 10.8, Color(0xff109618)),
      Task('TV', 15.6, Color.fromARGB(255, 71, 62, 37)),
      Task('Sleep', 19.2, Color(0xffff9900)),
      Task('Other', 10.3, Color(0xffdc3912)),
    ];
    _seriesPieData.add(
      charts.Series(
        data: piedata,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = <charts.Series<Task, String>>[];

    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: EdgeInsets.all(10),
    height: MediaQuery.of(context).size.height*0.4,
    width: MediaQuery.of(context).size. width *0.9,
      decoration: BoxDecoration(
           color: Colors.transparent,
           borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        //Pie chart
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                const Text(
                  'Time spent on daily tasks',
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: charts.PieChart<String>(
                    _seriesPieData,
                    animate: true,
                    animationDuration: const Duration(seconds: 2),
                    behaviors: [
                      charts.DatumLegend(
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding:
                            const EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 11),
                      )
                    ],
                    defaultRenderer: charts.ArcRendererConfig(
                        // arcWidth: 50,
                        arcRendererDecorators: [
                          charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ]),
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

class Task {
  late String task;
  late double taskvalue;
  late Color colorval;
  Task(this.task, this.taskvalue, this.colorval);
}
