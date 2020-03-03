class MakananModel {
  int id;
  String name;
  String imageLink;
  int energi;
  int berat;

  MakananModel({this.imageLink, this.name, this.id});
  MakananModel.fromJson(Map<String, dynamic> json) {
    energi = json['energi'];
    berat = json['berat'];
    imageLink = json['Link'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['energi'] = this.energi;
    data['berat'] = this.berat;
    data['Link'] = this.imageLink;
    data['name'] = this.name;
    return data;
  }
}
