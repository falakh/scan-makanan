import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scanmakan/model/makanan_model.dart';
import 'package:scanmakan/model/user_model.dart';
import 'package:scanmakan/provider/kalori_provider.dart';
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
    var user =  await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    var currentUSer = await userProfile;
    int day = DateTime.now().difference(currentUSer.lastLogin).inDays;
    if( day>=1 || day<=-1){
      var id = await currentUserId;
        await CaloriRepositoy.resetKaloriKOnsumtion(id);
    }

    var userCol = await _userColection();
    await userCol.setData({
      "lastlogin": DateTime.now()
    },merge: true);
    return user;
  }

  static saveUserProfile(UserModel user) async {
    DocumentReference userDocument = await _userColection();
    var hasil = await userDocument.setData({
      'nama': user.name,
      'umur': user.age,
      "gender": user.gender,
      "berat-badan": user.beratBadan,
      "tinggi": user.tinggiBadan,
      "disase":user.disase,
      "aktivitas":user.aktifitas,
      "lastlogin":user.lastLogin
    }, merge: true);
    return hasil;
  }

  static Future<DocumentReference> _userColection() async {
    var userColection = Firestore.instance.collection(userColectionKey);
    var userId = await currentUserId;
    var userDocument = userColection.document(userId);
    return userDocument;
  }

  static Future<String> get currentUserId async {
    var currentUser = await _auth.currentUser();
    return currentUser.uid;
  }

  static Future<UserModel> get userProfile async {
    var userId = await currentUserId;
    var proffile = await UserProvider.getUserProfile(userId);
    print(proffile.data);
    try{
      return new UserModel(
          name: proffile.data.containsKey("nama") ? proffile.data["nama"] : "",
          aktifitas: proffile.data.containsKey("aktifitas") ? proffile.data["aktifitas"] : UserModel.TIDAK_AKTIF,
          age: proffile.data.containsKey("umur") ? proffile.data["umur"] : 0,
          beratBadan: proffile.data.containsKey("berat-badan") ? proffile.data["berat-badan"] : 0,
          lastLogin:  (proffile.data["lastlogin"] as Timestamp)?.toDate() ?? DateTime.now(),
          gender: proffile.data.containsKey("gender") ? proffile.data["gender"] : "Laki-Laki",
          disase: proffile.data.containsKey("disase") ? List.from(proffile.data["disase"]) : new List(),
          tinggiBadan: proffile.data.containsKey("tinggi") ? proffile.data['tinggi'] : 0 );
    }catch(e){
      return new UserModel(
          aktifitas: UserModel.TIDAK_AKTIF,
          tinggiBadan: 0,
          name: "",
          gender: "Laki-Laki",
          disase: new List(),
          beratBadan: 0,
          lastLogin: DateTime.now(),
          age: 0
      );
    }


    /*'nama': user.name,
      'umur': user.age,
      "gender": user.gender,
      "berat-badan":user.beratBadan,
      "tinggi":user.tinggiBadan
      */

  }

  static Future<List<MakananModel>> get userFoodRecomendation async {
    var user = await userProfile;
    return await CaloriRepositoy.getSafeFoodByPenyakit(user.disase);

  }

}
