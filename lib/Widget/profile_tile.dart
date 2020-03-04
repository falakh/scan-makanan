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
  var penyakitCondition = [false, false, false, false];
  static const daftarPenyakit = [
    "Jantung",
    "Stroke",
    "Diabetes Miletus",
    "Hipertensi"
  ];

  _ProfiileTileState(this.model) {
    //  print(this.model.name);
    nameController.text = this.model?.name ?? "";
    dropdownValue = this.model?.gender ?? dropdownValue;
    usiaCOntroller.text = this.model?.age.toString() ?? "0";
    beratBadan.text = this.model?.beratBadan.toString() ?? "0";
    tinggibadan.text = this.model?.tinggiBadan.toString() ?? "0";
    penyakitCondition[0] =
        this.model?.disase?.contains(daftarPenyakit[0]) ?? false;
    penyakitCondition[2] =
        this.model?.disase?.contains(daftarPenyakit[2]) ?? false;
    penyakitCondition[1] =
        this.model?.disase?.contains(daftarPenyakit[1]) ?? false;
    penyakitCondition[3] =
        this.model?.disase?.contains(daftarPenyakit[3]) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: new ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          new Text(
            "DATA DIRI",
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline4.apply(fontWeightDelta: 3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text("Nama"),
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
                Column(
                  children: [
                    penyakitCheckBox(0),
                    penyakitCheckBox(1),
                    penyakitCheckBox(2),
                    penyakitCheckBox(3),
                  ],
                ),
                new TextFormFieldWithBorder(
                  "Alergi",
                ),new ListTile(
                  title: new Text("Aktivitas"),
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
                    disase: userDisase
                    
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

  List<String> get userDisase{
    var data = List<String>();
    for (var i=0;i<this.penyakitCondition.length;i++) {
      if(penyakitCondition[i]){
        data.add(daftarPenyakit[i]);
      }
    }
    return data;
  }

  Row penyakitCheckBox(int index) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: this.penyakitCondition[index] ?? false,
            onChanged: (value) => this.setState(() {
                  this.penyakitCondition[index] = value;
                })),
        new Text(daftarPenyakit[index])
      ],
    );
  }
}
