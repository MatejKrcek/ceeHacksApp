import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';

class PatientGraphsPage extends StatefulWidget {
  @override
  _PatientGraphsPageState createState() => _PatientGraphsPageState();
}

class _PatientGraphsPageState extends State<PatientGraphsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your stats'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Theme.of(context).primaryColor,
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your psychical health and mood \nAfter taking pill',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: BezierChart(
                      bezierChartScale: BezierChartScale.CUSTOM,
                      xAxisCustomValues: [1, 5, 10, 15, 20, 25, 30],
                      footerValueBuilder: (double value) {
                        return "${(value.toInt())}\ndays";
                      },
                      series: [
                        BezierLine(
                          label: "Your psychical health",
                          lineColor: Colors.white,
                          data: [
                            DataPoint<double>(value: 70, xAxis: 0),
                            DataPoint<double>(value: 100, xAxis: 5),
                            DataPoint<double>(value: 60, xAxis: 10),
                            DataPoint<double>(value: 53, xAxis: 15),
                            DataPoint<double>(value: 0, xAxis: 20),
                            DataPoint<double>(value: 65, xAxis: 25),
                            DataPoint<double>(value: 85, xAxis: 30),
                          ],
                        ),
                      ],
                      config: BezierChartConfig(
                        footerHeight: 40,
                        verticalIndicatorStrokeWidth: 3.0,
                        verticalIndicatorColor: Theme.of(context).accentColor,
                        showVerticalIndicator: true,
                        verticalIndicatorFixedPosition: false,
                        backgroundColor: Theme.of(context).primaryColor,
                        snap: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
