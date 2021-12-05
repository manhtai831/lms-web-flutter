import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/model/subject.dart';
import 'package:web_lms/model/user.dart';
import 'package:get/get.dart';

class ClassModel {
  String? sId;
  String? name;
  String? title;
  String? description;
  int? idSubject;
  int? idAccount;
  Subject? subject;
  String? createAt;
  User? createBy;
  User? account;
  int? id;
  int? iV;
  var isChoose = false.obs;

  ClassModel(
      {this.sId,
      this.name,
      this.description,
      this.idAccount,
      this.idSubject,
      this.createAt,
      this.createBy,
      this.id,
      this.iV});

  ClassModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    title = json['name'];
    idAccount = json['idGiangVien'];

    description = json['description'];
    idSubject = json['idSubject'];
    if (json['subject'] != null) subject = Subject.fromJson(json['subject']);
    if (json['createAt'] != null) {
      createAt = TimeUtils.convertTimeToFormated(
          json['createAt'], TimeUtils.locateDatetime, TimeUtils.dateFormat);
    }
    createBy =
        json['createBy'] != null ? new User.fromJson(json['createBy']) : null;
    account =
        json['giangVien'] != null ? new User.fromJson(json['giangVien']) : null;
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (sId != null) data['_id'] = sId;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (idSubject != null) data['idSubject'] = idSubject;
    if (idAccount != null) data['idGiangVien'] = idAccount;
    if (createAt != null) data['createAt'] = createAt;
    if (subject != null) data['subject'] = subject;
    if (createBy != null) {
      data['createBy'] = createBy!.toJson();
    }
    if (id != null) data['id'] = id;
    if (iV != null) data['__v'] = iV;
    return data;
  }
}
