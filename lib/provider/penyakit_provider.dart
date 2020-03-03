import 'package:firebase_database/firebase_database.dart';

class PenyakitProvider{
  static var database = new FirebaseDatabase().reference().child("penyakit");

  static Future<DataSnapshot> getDataLarangan(String penyakit) async  {
    return await  database
    .orderByChild("Penyakit")
    .equalTo(penyakit)
    .once();}
}