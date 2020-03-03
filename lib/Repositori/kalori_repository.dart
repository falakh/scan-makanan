import 'dart:collection';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:scanmakan/model/makanan_model.dart';
import 'package:scanmakan/model/penyakit_model.dart';
import 'package:scanmakan/provider/kalori_provider.dart';
import 'package:scanmakan/provider/penyakit_provider.dart';

class CaloriRepositoy {
  static var database = new FirebaseDatabase().reference().child("Kalori");
  static DatabaseReference GetUserTodayCalory(userId) {
    print(userId);
    return database.reference().child(userId);
  }

  static Future<List<MakananModel>> getAllMakanan() async {
    var makanan = await CaloriProvider.dataMakanan;
    // print("makanan"+makanan.value.toString());
    Map<dynamic, dynamic> datamakanan;
    datamakanan = makanan.value;
    // print(datamakanan);
    List<MakananModel> hasilMakanan = new List();
    for (var i in datamakanan.keys) {
      Map<String, dynamic> temp = Map.from(datamakanan[i]);
      hasilMakanan.add(MakananModel.fromJson(temp));
    }
    return hasilMakanan;
  }

  static Future<List<String>> getForbidenFoodByPenyakit(String penyakit) async {
    var forbidenFood = await PenyakitProvider.getDataLarangan(penyakit);
    
    List<String> penyakitList = new List();
    if (forbidenFood.value is List<dynamic>) {
      List<dynamic> data = List.from(forbidenFood.value);
      for (var i in data) {
        if (i == null) {
          continue;
        }
        Map<String, dynamic> temp = Map.from(i);
        var dataPenyakit = (PenyakitModel.fromJson(temp));
        penyakitList.add(dataPenyakit.pantangan);
      }
    } else {
      Map<dynamic, dynamic> forbidenFoodMap = Map.from(forbidenFood.value);
      for (var i in forbidenFoodMap.keys) {
        if (i == null) {
          continue;
        }
        Map<String, dynamic> temp = Map.from(forbidenFoodMap[i]);
        var dataPenyakit = (PenyakitModel.fromJson(temp));
        penyakitList.add(dataPenyakit.pantangan);
      }
    }

    return penyakitList;
  }

  static Future<List<MakananModel>> getSafeFoodByPenyakit(
      List<String> penyakit) async {
    var allFood = await getAllMakanan();
    if (penyakit == null) {
      return allFood;
    }
    await getAllForbidenFoodName(penyakit);
    HashSet allForbidenFoodHashSet = await getAllForbidenFoodName(penyakit);
    allFood.removeWhere(
        (element) => allForbidenFoodHashSet.contains(element.name));
    return allFood;
  }

  static Future<HashSet> getAllForbidenFoodName(List<String> penyakit) async {
    List<String> allForbidenFood = new List();
    for (var i in penyakit) {
      var forbidenFoodByPenyakit = await getForbidenFoodByPenyakit(i);
      allForbidenFood.addAll(forbidenFoodByPenyakit);
    }
    var allForbidenFoodHashSet = HashSet.from(allForbidenFood);
    return allForbidenFoodHashSet;
  }
}
