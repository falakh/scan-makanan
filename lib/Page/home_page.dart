import 'package:flutter/material.dart';
import 'package:scanmakan/Page/food_recomendation_Page.dart';
import 'package:scanmakan/Page/konsultasi_page.dart';
import 'package:scanmakan/Page/profile_page.dart';
import 'package:scanmakan/Page/qr_scan_page.dart';
import 'package:scanmakan/Widget/TodaysKaloriComponent.dart';
import 'package:scanmakan/Widget/food_card.dart';
import 'package:scanmakan/tools/resources/resources.dart';

import 'food_detect.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int homeTabIndex = 0;
  final widgetList =<Widget>[
    
    new FoodRecomendation(isAll: false,),
    new KonsulPage(),
    new FoodDetector(),
    new QRScannerPage(),
    new ProfillePage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const menuName = [
      "Rekomendasi",
      "Konsultasi",
      "ScanMakanan",
      "URL",
      "Profile"
    ];
    return Scaffold(
      appBar: new AppBar(
        title: new Text(menuName[homeTabIndex]),
      ),
      body: TodaysKaloriComponent(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexBottomNavigationBar) => this.setState(() {
          if(indexBottomNavigationBar == 5){
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Container(child: widgetList[homeTabIndex]) ));
          homeTabIndex = (indexBottomNavigationBar);
        }),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        items: [
          BottomNavigationBarItem(
              title: new Text("Rekomendasi"), icon: ImageIcon(AssetImage(Resources.rekomendariIcon))),
          BottomNavigationBarItem(
              title: new Text("Konsultasi"), icon: Icon(Icons.chat)),
          BottomNavigationBarItem(
              title: new Text("ScanMakanan"), icon: Icon(Icons.fastfood)),
          BottomNavigationBarItem(
              title: new Text("Scan QR "), icon: Icon(Icons.camera)),
          BottomNavigationBarItem(
              title: new Text("Profile"), icon: Icon(Icons.account_circle)),
          BottomNavigationBarItem(
            title: new Text("Delivery"), icon: ImageIcon(AssetImage(Resources.deliveri))
          )
        ],
      ),
    );
  }
}
