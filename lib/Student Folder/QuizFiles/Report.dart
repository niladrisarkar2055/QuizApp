import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/Chart_Components.dart/Barchart.dart';
import 'package:quizapp/Student%20Folder/QuizFiles/Chart_Components.dart/Linechart.dart';

import 'Chart_Components.dart/Piechart.dart';
import 'QNApage.dart';

class Report extends StatefulWidget {
  String quizname;
  int count;
  String quizsubject;
  Report(
      {required this.count, required this.quizname, required this.quizsubject});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       iconTheme: IconTheme.of(context),
  //       backgroundColor: Colors.deepPurple[600],
  //       toolbarHeight: 100,

  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Container(
  //             alignment: Alignment.center,
  //             margin: EdgeInsets.all(10),
  //             padding:  EdgeInsets.all(10),
  //             height: MediaQuery.of(context).size.height*(0.4),
  //             width: MediaQuery.of(context).size.width*0.95,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(40),
  //               color: Colors. deepPurple[200]
  //             ),
  //           ),

  //           Container(
  //             child: Row(
  //               children: [
  //                 Container(
  //             alignment: Alignment.center,
  //             margin: EdgeInsets.all(10),
  //             padding:  EdgeInsets.all(10),
  //             height: MediaQuery.of(context).size.height*(0.4),
  //             width: MediaQuery.of(context).size.width*0.45,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(40),
  //               color: Colors. deepPurple[200]
  //             ),
  //           ),

  //           Container(
  //             alignment: Alignment.center,
  //             margin: EdgeInsets.all(10),
  //             padding:  EdgeInsets.all(10),
  //             height: MediaQuery.of(context).size.height*(0.4),
  //             width: MediaQuery.of(context).size.width*0.45,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(40),
  //               color: Colors. deepPurple[200]
  //             ),
  //           ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text('${widget.quizname} Report'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image(
                    image: AssetImage('assets/${widget.quizsubject}.jpg'),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment.center,
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


          SliverList(
            delegate: SliverChildListDelegate(
              [
                ExpansionTile(
                    initiallyExpanded: false,
                    title: Text('See yourperformance'),
                    subtitle: Text('Expand this tile to see its contents'),
                    // Contents
                    children: [
                      Piechart(),
                      Barchart(),
                      Linechart(),
                    ]),
                // Piechart(),
                // Barchart(),
                // Linechart(),
                // for (int i = 0; i < 3;i++) Piechart(),
                  Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: QuestionAndAnswerPage(
                        count: widget.count,
                        Quizname: widget.quizname,
                      )),
              ],
            ),
          ),
        ],
      ),
    );
    // ]));
  }
}
