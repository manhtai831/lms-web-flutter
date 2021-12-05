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
    if (json['startTime'] != null) {
      startTime = TimeUtils.convertTimeToFormated(
          json['startTime'], TimeUtils.locateDatetime2, TimeUtils.dateFormat);
    }
    if (json['endTime'] != null) {
      endTime = TimeUtils.convertTimeToFormated(
          json['endTime'], TimeUtils.locateDatetime2, TimeUtils.dateFormat);
    }
    status = json['status'];
    createBy =
        json['createBy'] != null ? User.fromJson(json['createBy']) : null;
    id = json['id'];
    repository = json['repository'] != null
        ? Repository.fromJson(json['repository'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sId != null) data['_id'] = sId;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (status != null) data['status'] = status;
    if (idRepository != null) data['idRepository'] = idRepository;
    if (endTime != null) data['endTime'] = endTime;
    if (startTime != null) data['startTime'] = startTime;
    if (createAt != null) data['createAt'] = createAt;
    if (createBy != null) {
      data['createBy'] = createBy!.toJson();
    }
    if (id != null) data['id'] = id;
    if (repository != null) {
      data['repository'] = repository!.toJson();
    }
    return data;
  }
}
