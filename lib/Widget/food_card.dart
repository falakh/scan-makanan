import 'package:flutter/material.dart';
import 'package:scanmakan/model/makanan_model.dart';
import 'package:automl_mlkit/automl_mlkit.dart';

class FoodCard extends StatefulWidget {
  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
    );
  }
}

class FoodWidget extends StatelessWidget {
  final MakananModel foodModel;

  const FoodWidget({
    this.foodModel,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Image.network(
            this.foodModel.imageLink,
            width: double.infinity,
            height: 100,
            fit: BoxFit.cover,
            loadingBuilder: (context, widget, event) =>
            event?.cumulativeBytesLoaded==event?.expectedTotalBytes ?  widget : CircularProgressIndicator(),
          ),
          ListTile(
            title: new Text(this.foodModel.name),
            subtitle: new Text(foodModel.energi.toString()+" kal / "+foodModel.berat.toString()+"gram" ),
          ),
        ],
      ),
    );
  }
}
