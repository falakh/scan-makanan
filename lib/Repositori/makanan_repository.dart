import 'package:firebase_database/firebase_database.dart';

class MakananRepository{
    static var  database = new FirebaseDatabase().reference().child("makanan");

    getKompoisi(){
      
    }

}