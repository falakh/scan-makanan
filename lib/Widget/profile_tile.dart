import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanmakan/Bloc/user_profile/bloc/bloc.dart';
import 'package:scanmakan/Widget/FormTextField.dart';
import 'package:scanmakan/model/user_model.dart';

class ProfiileTile extends StatefulWidget {
  final UserModel model;
  ProfiileTile({Key key, this.model}) : super(key: key);

  @override
  _ProfiileTileState createState() => _ProfiileTileState(this.model);
}

class _ProfiileTileState extends State<ProfiileTile> {
  var isEdit = false;
  String dropdownValue = 'Laki-Laki';
  UserModel model;
  var nameController = TextEditingController();
  var usiaCOntroller = TextEditingController();
  var beratBadan = TextEditingController();
  var tinggibadan = TextEditingController();
  _ProfiileTileState(this.model) {
    //  print(this.model.name);
      nameController.text = this.model.name ?? "";
      dropdownValue = this.model.gender ?? dropdownValue;
      usiaCOntroller.text = this.model.age.toString() ?? "0";
      beratBadan.text = this.model.beratBadan.toString() ?? "0";
      tinggibadan.text = this.model.tinggiBadan.toString() ?? "0";

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: new ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          ActionChip(
            
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Icon(Icons.close),
                new Text("ini chip"),
              ],
            ),
            onPressed: () {
              print("object");
            },
          ),
          new Text(
            "DATA DIRI",
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.display1.apply(fontWeightDelta: 3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new TextFormFieldWithBorder(
                  "Nama",
                  controller: nameController,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                    border: OutlineInputBorder(),
                    labelText: "Jenis Kelamin",
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    isExpanded: true,
                    iconSize: 24,
                    underline: new Container(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Laki-Laki', 'Perempuan']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                new NumberFormFieldWithBorder(
                  "Usia",
                  controller: usiaCOntroller,
                ),
                new NumberFormFieldWithBorder(
                  "Berat Badan",
                  controller: beratBadan,
                ),
                new NumberFormFieldWithBorder(
                  "Tinggi Badan",
                  controller: tinggibadan,
                ),
                new TextFormFieldWithBorder(
                  "Riwayat Penyakit",
                ),
                new TextFormFieldWithBorder(
                  "Alergi",
                ),
                new MaterialButton(
                  color: Theme.of(context).primaryColor,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () => BlocProvider.of<UserProffileBloc>(context)
                      .add(SaveUserProffileEvent(
                          model: new UserModel(
                    name: nameController.text,
                    age: int.parse(usiaCOntroller.text),
                    beratBadan: int.parse(beratBadan.text),
                    gender: dropdownValue,
                    tinggiBadan: int.parse(tinggibadan.text),
                  ))),
                  child: new Text(
                    "ADD",
                    style: new TextStyle(
                        color: Theme.of(context).cardColor, letterSpacing: 2),
                  ),
                )
              ]
                  .map((widget) => new Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: widget,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
