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
    if (sId != null) data['_id'] = sId;
    if (idCauHoi != null) data['idCauHoi'] = idCauHoi;
    if (content != null) data['content'] = content;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (createdBy != null) data['createdBy'] = createdBy;
    if (id != null) data['id'] = id;
    if (iV != null) data['__v'] = iV;
    return data;
  }
}
