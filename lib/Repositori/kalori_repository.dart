

import 'package:firebase_database/firebase_database.dart';

class CaloriProvider {
   static var  database = new FirebaseDatabase().reference().child("Kalori");
  static    DatabaseReference GetUserTodayCalory(userId)   {
    print(userId);
    return  database.reference().child(userId);
  }
}