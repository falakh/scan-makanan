class PenyakitModel {
  String penyakit;
  String pantangan;
  String penyakit1;

  PenyakitModel({this.penyakit, this.pantangan, this.penyakit1});

  PenyakitModel.fromJson(Map<String, dynamic> json) {
    penyakit = json['Penyakit'];
    pantangan = json['Pantangan'];
    penyakit1 = json['Penyakit__1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Penyakit'] = this.penyakit;
    data['Pantangan'] = this.pantangan;
    data['Penyakit__1'] = this.penyakit1;
    return data;
  }
}