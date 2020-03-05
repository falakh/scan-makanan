import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:scanmakan/Page/home_page.dart';
import 'package:scanmakan/Repositori/kalori_repository.dart';
import 'package:scanmakan/Repositori/makanan_repository.dart';
import 'package:scanmakan/Repositori/user_repository.dart';
import 'package:scanmakan/Widget/food_card.dart';
import 'package:scanmakan/Widget/kalori_chart.dart';
import 'package:scanmakan/model/makanan_model.dart';

class FoodRecomendation extends StatelessWidget {

  bool isAll;

  FoodRecomendation({bool isAll = false}) {
    this.isAll = isAll;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Rekomendasi Makanan"),
      ),
      body: StreamBuilder<List<MakananModel>>(
          stream: !isAll
              ? UserRepository.userFoodRecomendation.asStream()
              : CaloriRepositoy.getAllMakanan().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var foodWdgetList = snapshot.data
                  .map((e) =>
                  FoodWidget(
                    foodModel: e,
                  ))
                  .toList();
              return GridView.builder(
                  itemCount: foodWdgetList.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) =>
                  !isAll ? foodWdgetList[index] : GestureDetector(
                    onTap: () => pushKalori(snapshot, index,context),
                    child: foodWdgetList[index],
                  ));
            } else if (snapshot.hasError) {
              return Center(child: Text("wops" + snapshot.error.toString()));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  pushKalori(AsyncSnapshot<List<MakananModel>> snapshot, int index,BuildContext context) async {
    var loginProgressBar = ProgressDialog(context);

    loginProgressBar.show();
    await CaloriRepositoy.addKalori(snapshot.data[index].energi.toDouble());
    loginProgressBar.hide();
    Navigator.pop(context);


  }


}
