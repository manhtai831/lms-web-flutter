import 'package:get/get.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/user.dart';

class FileStudent {
  String? sId;
  String? name;
  String? link;
  int? idUser;
  User? user;
  int? idClass;
  ClassModel? classModel;
  int? idDocumentType;
  FileFolder? fileFolder;
  String? createdAt;
  int? createdBy;
  int? id;
  int? iV;
  var isChoose = false.obs;

  FileStudent(
      {this.sId,
      this.name,
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
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sId != null) data['_id'] = this.sId;
    if (this.name != null) data['name'] = this.name;
    if (this.link != null) data['link'] = this.link;
    if (this.idUser != null) data['idUser'] = this.idUser;
    if (this.idClass != null) data['idClass'] = this.idClass;
    if (this.idDocumentType != null)
      data['idDocumentType'] = this.idDocumentType;
    if (this.createdAt != null) data['createdAt'] = this.createdAt;
    if (this.createdBy != null) data['createdBy'] = this.createdBy;
    if (this.id != null) data['id'] = this.id;
    if (this.iV != null) data['__v'] = this.iV;
    return data;
  }
}
