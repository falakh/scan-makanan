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
  final GlobalKey<AnimatedCircularChartState> _chartKey
  =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: UserRepository.currentUserId,
      builder: (context, snap) {
        if (!snap.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder<Event>(
            stream: CaloriRepositoy.GetUserTodayCalory(snap.data).onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return new Text(snapshot.hasError.toString());
              }
              return FutureBuilder<AnimatedCircularChart>(
                future: circleCaloriChart(
                    snapshot.data.snapshot.value, context),
                builder: (context, widgetSnapshoot) {
                  if (snapshot.hasData){
                    return widgetSnapshoot.data;

                  }

                    return CircularProgressIndicator();
                },
              );
            });
      },
    );
  }

  Future<AnimatedCircularChart> circleCaloriChart(
      int snapshot, BuildContext context) async {
    var curUser = await UserRepository.userProfile;
    print(curUser);
    print(snapshot);
    return new AnimatedCircularChart(
        size: const Size(300.0, 250.0),
        chartType: CircularChartType.Radial,
        duration: Duration(seconds: 1),
        holeLabel: snapshot.toString(),
        labelStyle: Theme.of(context).textTheme.headline4,
        initialChartData: <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry(
                  (snapshot)/1.0, Colors.green,
                  rankKey: 'fill'),
              new CircularSegmentEntry(curUser.kaloriHarian, Colors.grey[200],
                  rankKey: 'sisa'),
            ],
            rankKey: 'Quarterly Profits',
          ),
        ]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
