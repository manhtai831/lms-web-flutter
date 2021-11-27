import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/model/subject.dart';
import 'package:web_lms/model/user.dart';
import 'package:get/get.dart';

class ClassModel {
  String? sId;
  String? name;
  String? description;
  int? idSubject;
  Subject? subject;
  String? createAt;
  User? createBy;
  int? id;
  int? iV;
  var isChoose = false.obs;

  ClassModel(
      {this.sId,
      this.name,
      this.description,
      this.idSubject,
      this.createAt,
      this.createBy,
      this.id,
      this.iV});

  ClassModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    idSubject = json['idSubject'];
    if (json['subject'] != null) subject = Subject.fromJson(json['subject']);
    if (json['createAt'] != null) {
      createAt = TimeUtils.convertTimeToFormated(
          json['createAt'], TimeUtils.locateDatetime, TimeUtils.dateFormat);
    }
    createBy =
        json['createBy'] != null ? new User.fromJson(json['createBy']) : null;
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['idSubject'] = this.idSubject;
    data['createAt'] = this.createAt;
    data['subject'] = this.subject;
    if (this.createBy != null) {
      data['createBy'] = this.createBy!.toJson();
    }
    data['id'] = this.id;
    data['__v'] = this.iV;
    return data;
  }
}
