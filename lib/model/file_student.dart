import 'package:get/get.dart';
import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/user.dart';

class FileStudent {
  String? sId;
  String? name;
  String? link;
  String? note;
  int? idUser;
  User? user;
  int? idClass;
  ClassModel? classModel;
  int? idDocumentType;
  FileFolder? fileFolder;
  String? createdAt;
  int? createdBy;
  int? point;
  int? id;
  int? iV;
  var isChoose = false.obs;

  FileStudent(
      {this.sId,
      this.name,
      this.point,
      this.note,
      this.link,
      this.idUser,
      this.idClass,
      this.idDocumentType,
      this.createdAt,
      this.createdBy,
      this.id,
      this.iV});

  FileStudent.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    point = json['point'];
    note = json['note'];
    link = json['link'];
    idUser = json['idUser'];
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }
    if (json['class'] != null) {
      classModel = ClassModel.fromJson(json['class']);
    }
    if (json['documentType'] != null) {
      fileFolder = FileFolder.fromJson(json['documentType']);
    }
    idClass = json['idClass'];

    idDocumentType = json['idDocumentType'];
    if (json['createdAt'] != null) {
      createdAt = TimeUtils.convertTimeToFormated(json['createdAt'],
          TimeUtils.locateDatetime, TimeUtils.timeDateFormat);
    }
    createdBy = json['createdBy'];
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sId != null) data['_id'] = sId;
    if (name != null) data['name'] = name;
    if (note != null) data['note'] = note;
    if (point != null) data['point'] = point;
    if (link != null) data['link'] = link;
    if (idUser != null) data['idUser'] = idUser;
    if (idClass != null) data['idClass'] = idClass;
    if (idDocumentType != null) data['idDocumentType'] = idDocumentType;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (createdBy != null) data['createdBy'] = createdBy;
    if (id != null) data['id'] = id;
    if (iV != null) data['__v'] = iV;
    return data;
  }
}
