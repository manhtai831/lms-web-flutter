import 'package:get/get.dart';

class Answer {
  String? sId;
  int? idCauHoi;
  String? content;
  String? createdAt;
  int? createdBy;
  int? id;
  int? iV;
  var isDapAnDung = false.obs;

  Answer(
      {this.sId,
      this.idCauHoi,
      this.content,
      this.createdAt,
      this.createdBy,
      this.id,
      this.iV});

  Answer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idCauHoi = json['idCauHoi'];
    content = json['content'];
    // createdAt = json['createdAt'];
    // createdBy = json['createdBy'];
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['idCauHoi'] = this.idCauHoi;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['id'] = this.id;
    data['__v'] = this.iV;
    return data;
  }
}
