import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/model/user.dart';
import 'package:get/get.dart';
import 'department.dart';

class Subject {
  String? sId;
  String? name;
  String? title;
  int? idDepartment;
  int? data;
  String? description;
  int? status;
  String? createdAt;
  User? createdBy;
  int? id;
  int? iV;
  Department? department;
  var isChoose = false.obs;
  Subject(
      {this.sId,
      this.name,
      this.idDepartment,
      this.description,
      this.data,
      this.createdAt,
      this.createdBy,
      this.id,
      this.iV,
      this.status,
      this.department});

  Subject.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    title = json['name'];
    idDepartment = json['idDepartment'];
    description = json['description'];
    if (json['createdAt'] != null) {
      createdAt = TimeUtils.convertTimeToFormated(
          json['createdAt'], TimeUtils.locateDatetime, TimeUtils.dateFormat);
    }
    if (json['createdBy'] != null) createdBy = User.fromJson(json['createdBy']);
    id = json['id'];
    status = json['status'];
    iV = json['__v'];
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (sId != null) data['_id'] = sId;
    if (name != null) data['name'] = name;
    if (status != null) data['status'] = status;
    if (idDepartment != null) data['idDepartment'] = idDepartment;
    if (description != null) data['description'] = description;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (this.data != null) data['data'] = this.data;
    if (createdBy != null) data['createdBy'] = createdBy!.toJson();
    if (id != null) data['id'] = id;
    if (iV != null) data['__v'] = iV;
    if (department != null) {
      data['department'] = department!.toJson();
    }
    return data;
  }
}
