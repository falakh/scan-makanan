class UserModel {
  final int age;
  final String name;
  final String gender;
  final List<String> disase;
  final int beratBadan;
  final int tinggiBadan;
  final String aktifitas;
  final DateTime lastLogin;

  static const TIDAK_AKTIF = "TIDAK AKTIF";
  static const CUKUP_AKTIF = "CUKUP AKTIF";
  static const AKTIF = "AKTIF";
  static const SANGAT_AKTIF = "SANGAT AKTIF";


  UserModel(
      {this.lastLogin,this.aktifitas, this.age, this.name, this.gender, this.disase, this.beratBadan, this.tinggiBadan});

  static UserModel dummy() {
    return new UserModel(
        aktifitas: TIDAK_AKTIF,
        age: 0,
        disase: [],
        gender: "Wanita",
        name: ""
    );
  }

  double get _kaloriPria {
    return 83.62 + (13.397 * beratBadan) + (4.799 * tinggiBadan) -
        (5.677 * age);
  }

  double get _kaloriWanita {
    return 447.593 + (9.247 * beratBadan) + (3.098 * tinggiBadan) -
        (4.333 * age);
  }

  double get _genderKalori {
    if (gender == "Laki-Laki") {
      return _kaloriPria;
    } else {
      return _kaloriPria;
    }
  }

  double get kaloriHarian {
    switch (aktifitas) {
      case TIDAK_AKTIF:
        return _genderKalori * 1.2;
        break;
      case CUKUP_AKTIF:
        return _genderKalori * 1.375;
      case AKTIF:
        return _genderKalori * 1.55;
      case SANGAT_AKTIF:
        return _genderKalori * 1.725;
        break;
    }
    return _genderKalori;
  }
}

enum Gender {
  Pria,
  Wanita
}