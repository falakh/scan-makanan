import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:scanmakan/Repositori/kalori_repository.dart';
import 'package:scanmakan/Repositori/user_repository.dart';

class KaloriChart extends StatefulWidget {
  @override
  _KaloriChartState createState() => _KaloriChartState();
}

class _KaloriChartState extends State<KaloriChart> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  List<CircularStackEntry> data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(22.0, Colors.green, rankKey: 'fill'),
        new CircularSegmentEntry(7.0, Colors.grey[200], rankKey: 'sisa'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: UserRepository.currentUserId,
      builder: (context, snap) {
        if (!snap.hasData) {
          return Container();
        }

        return StreamBuilder<Event>(
            stream: CaloriProvider.GetUserTodayCalory(snap.data).onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return new Text(snapshot.hasError.toString());
              }
              print(snapshot.data.snapshot.value.toString());
              return new Text(snapshot.data.snapshot.value.toString());
              // return circleCaloriChart( snapshot.data.snapshot.value.toString(), context);
            });
      },
    );
  }

  AnimatedCircularChart circleCaloriChart(
      String snapshot, BuildContext context) {
    return new AnimatedCircularChart(
      key: _chartKey,
      size: const Size(300.0, 250.0),
      chartType: CircularChartType.Radial,
      duration: Duration(seconds: 1),
      holeLabel: snapshot,
      labelStyle: Theme.of(context).textTheme.display3, 
      initialChartData: <CircularStackEntry>[],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
