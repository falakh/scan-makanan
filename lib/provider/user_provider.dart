import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {

  static  Future<DocumentSnapshot> getUserProfile(String userId) async {
    var userColection = Firestore.instance.collection("user");
    var document =  await userColection.document(userId).get();
    return document;
  }
}
