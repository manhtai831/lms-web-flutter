import 'package:web_lms/model/semester.dart';
import 'package:web_lms/model/user.dart';

class Department {
  String? sId;
  String? name;
  int? idSemester;
  String? image;
  String? data;
  String? description;
  String? createAt;
  int? status;
  User? createBy;
  int? id;
  int? iV;
  Semester? semester;

  Department(
      {this.sId,
      this.name,
      this.idSemester,
      this.image,
      this.description,
      this.status,
      this.data,
      this.createAt,
      this.createBy,
      this.id,
      this.iV,
      this.semester});

  Department.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    idSemester = json['idSemester'];
    image = json['image'];
    status = json['status'];
    description = json['description'];
    createAt = json['createAt'];
    createBy =
        json['createBy'] != null ? User.fromJson(json['createBy']) : null;
    semester =
        json['semester'] != null ? Semester.fromJson(json['semester']) : null;
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sId != null) data['_id'] = this.sId;
    if (this.name != null) data['name'] = this.name;
    if (this.idSemester != null) data['idSemester'] = this.idSemester;
    if (this.image != null) data['image'] = this.image;
    if (this.status != null) data['status'] = this.status;
    if (this.description != null) data['description'] = this.description;
    if (this.createAt != null) data['createAt'] = this.createAt;
    if (this.data != null) data['data'] = this.data;
    if (this.createBy != null) {
      data['createBy'] = this.createBy!.toJson();
    }
    if (this.id != null) data['id'] = this.id;
    if (this.iV != null) data['__v'] = this.iV;
    if (this.semester != null) data['semester'] = this.semester;
    return data;
  }
}
