import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scanmakan/Repositori/kalori_repository.dart';
import 'package:scanmakan/Repositori/user_repository.dart';
import 'package:scanmakan/Widget/food_card.dart';
import 'package:scanmakan/model/makanan_model.dart';

class FoodRecomendation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: new Text("Rekomendasi Makanan"),
      ),
      body: StreamBuilder<List<MakananModel>>(
          stream: UserRepository.userFoodRecomendation.asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var foodWdgetList = snapshot.data
                  .map((e) => FoodWidget(
                        foodModel: e,
                      ))
                  .toList();
              return GridView.builder(
                itemCount: foodWdgetList.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) => foodWdgetList[index]);
            } else if(snapshot.hasError) {
              return Center(child: Text("wops"+snapshot.error.toString()));
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
