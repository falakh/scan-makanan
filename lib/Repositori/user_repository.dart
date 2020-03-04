import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scanmakan/model/makanan_model.dart';
import 'package:scanmakan/model/user_model.dart';
import 'package:scanmakan/provider/user_provider.dart';

import 'kalori_repository.dart';

class UserRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final userColectionKey = "user";
  static registerUser(String email, String password) async {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<AuthResult> loginUser(String email, String password) async {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static saveUserProfile(UserModel user) async {
    var userColection = Firestore.instance.collection(userColectionKey);
    var userId = await currentUserId;
    var userDocument = userColection.document(userId);
    var hasil = await userDocument.setData({
      'nama': user.name,
      'umur': user.age,
      "gender": user.gender,
      "berat-badan": user.beratBadan,
      "tinggi": user.tinggiBadan,
      "disase":user.disase
    }, merge: true);
    return hasil;
  }

  static Future<String> get currentUserId async {
    var currentUser = await _auth.currentUser();
    return currentUser.uid;
  }

  static Future<UserModel> get userProfile async {
    var userId = await currentUserId;
    var proffile = await UserProvider.getUserProfile(userId);
    print(proffile.data);
    if(proffile.data==null){
      return new UserModel(
        aktifitas: "",
        tinggiBadan: 0,
        name: "",
        gender: "Laki-Laki",
        disase: new List(),
        beratBadan: 0,
        age: 0
      );
    }
    /*'nama': user.name,
      'umur': user.age,
      "gender": user.gender,
      "berat-badan":user.beratBadan,
      "tinggi":user.tinggiBadan
      */
    return new UserModel(
        name: proffile.data["nama"],
        age: proffile.data['umur'],
        beratBadan: proffile.data["berat-badan"],
        gender: proffile.data["gender"],
        disase: List.from(proffile.data["disase"]),
        tinggiBadan: proffile.data['tinggi']);
  }

  static Future<List<MakananModel>> get userFoodRecomendation async {
    var user = await userProfile;
    return await CaloriRepositoy.getSafeFoodByPenyakit(user.disase);

  }

}
