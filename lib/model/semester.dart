import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/model/repository.dart';
import 'package:web_lms/model/user.dart';

class Semester {
  String? sId;
  String? name;
  String? title;
  String? description;
  int? idRepository;
  int? status;
  String? createAt;
  String? endTime;
  String? startTime;
  User? createBy;
  int? id;
  Repository? repository;

  Semester(
      {this.sId,
      this.name,
      this.description,
      this.idRepository,
      this.createAt,
      this.createBy,
      this.status,
      this.id,
      this.repository,
      this.startTime,
      this.endTime});

  Semester.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    idRepository = json['idRepository'];
    title = json['name'];
    createAt = json['createAt'];
    startTime = TimeUtils.convertTimeToFormated(
        json['startTime'], TimeUtils.locateDatetime2, TimeUtils.dateFormat);
    endTime = TimeUtils.convertTimeToFormated(
        json['endTime'], TimeUtils.locateDatetime2, TimeUtils.dateFormat);
    status = json['status'];
    createBy =
        json['createBy'] != null ? User.fromJson(json['createBy']) : null;
    id = json['id'];
    repository = json['repository'] != null
        ? Repository.fromJson(json['repository'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sId != null) data['_id'] = this.sId;
    if (this.name != null) data['name'] = this.name;
    if (this.description != null) data['description'] = this.description;
    if (this.status != null) data['status'] = this.status;
    if (this.idRepository != null) data['idRepository'] = this.idRepository;
    if (this.endTime != null) data['endTime'] = this.endTime;
    if (this.startTime != null) data['startTime'] = this.startTime;
    if (this.createAt != null) data['createAt'] = this.createAt;
    if (this.createBy != null) {
      data['createBy'] = this.createBy!.toJson();
    }
    if (this.id != null) data['id'] = this.id;
    if (this.repository != null) {
      data['repository'] = this.repository!.toJson();
    }
    return data;
  }
}
