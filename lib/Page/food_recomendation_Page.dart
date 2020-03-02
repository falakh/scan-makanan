import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scanmakan/Widget/food_card.dart';
import 'package:scanmakan/model/makanan_model.dart';

class FoodRecomendation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text("Rekomendasi Makanan"),),
      body: GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        FoodWidget(
          foodModel: MakananModel(
              id: 0,
              name: "soto",
              imageLink:
                  "https://i2.wp.com/masakanmama.com/wp-content/uploads/2019/10/16.-Resep-Soto-Ayam-Bening-Kuning.jpg"),
        ),FoodWidget(
          foodModel: MakananModel(
            id: 0,
            name: "Sate",
            imageLink: "https://upload.wikimedia.org/wikipedia/commons/1/15/Sate_ayam_Jalan_Sabang.JPG"
          ),
        )
      ],
    ),
    );
  }
}