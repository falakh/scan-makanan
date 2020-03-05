import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:scanmakan/Repositori/kalori_repository.dart';
import 'package:scanmakan/Repositori/user_repository.dart';
import 'package:scanmakan/model/user_model.dart';

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
            stream: CaloriRepositoy
                .GetUserTodayCalory(snap.data)
                .onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return new Text(snapshot.hasError.toString());
              }
              if (snapshot.hasData){

                if(snapshot.data.snapshot.value!=null){
                  return Center(child: circleCaloriChart(snapshot.data.snapshot.value, context));
                }
                else{
                  return Center(child: circleCaloriChart(0, context));
                }
              }

              return CircularProgressIndicator();
            },
          );
        });


  }

  StreamBuilder<UserModel> circleCaloriChart(int userCalori,
      BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: UserRepository.userProfile.asStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError){
            return new Text(snapshot.error.toString());
          }
          Map<String, double> dataMap = new Map();
          dataMap.putIfAbsent("Kalori Hari ini : "+userCalori.toString(), () => userCalori.toDouble()/snapshot.data.kaloriHarian.toInt().toDouble());
          dataMap.putIfAbsent("Target Hairan : "+snapshot.data.kaloriHarian.toInt().toString(), () => (1));
          return new PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32.0,
            chartRadius: MediaQuery.of(context).size.width * 4 / 2.7,
            showChartValuesInPercentage: true,
            showChartValues: false,
            showChartValuesOutside: false,
            chartValueBackgroundColor: Colors.grey[200],
            colorList: [Colors.green,Colors.grey],
            showLegends: true,
            legendPosition: LegendPosition.bottom,
            decimalPlaces: 1,
            showChartValueLabel: true,
            initialAngle: 0,
            chartValueStyle: defaultChartValueStyle.copyWith(
              color: Colors.blueGrey[900].withOpacity(0.9),
            ),
            chartType: ChartType.disc,
          );

        }
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
