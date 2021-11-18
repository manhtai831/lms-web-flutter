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
    createdAt = json['createdAt'];
    createdBy = User.fromJson(json['createdBy']);
    id = json['id'];
    status = json['status'];
    iV = json['__v'];
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sId != null) data['_id'] = this.sId;
    if (this.name != null) data['name'] = this.name;
    if (this.status != null) data['status'] = this.status;
    if (this.idDepartment != null) data['idDepartment'] = this.idDepartment;
    if (this.description != null) data['description'] = this.description;
    if (this.createdAt != null) data['createdAt'] = this.createdAt;
    if (this.data != null) data['data'] = this.data;
    if (this.createdBy != null) data['createdBy'] = this.createdBy!.toJson();
    if (this.id != null) data['id'] = this.id;
    if (this.iV != null) data['__v'] = this.iV;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    return data;
  }
}
