import 'package:firebase_database/firebase_database.dart';

class CaloriProvider{
  static var database = new FirebaseDatabase().reference().child("makanan");

  static Future<DataSnapshot> get dataMakanan async => await database.once();

    static Future<DataSnapshot>  getFoodByName(String name) async => await database.child(name).once();

}