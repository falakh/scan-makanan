class UserModel {
  final int age;
  final String name;
  final String gender;
  final List<String> disase;
  final int beratBadan;
  final int tinggiBadan;

  UserModel({this.age, this.name, this.gender, this.disase,this.beratBadan,this.tinggiBadan});
  static UserModel dummy() {
      return new UserModel(
        age: 0,
        disase: ["test","test 2"],
        gender: "Wanita",
        name: ""
      );
  }
}

enum Gender{
  Pria,Wanita

}