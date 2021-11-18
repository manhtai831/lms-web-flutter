import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/subject.dart';
import 'package:web_lms/model/user.dart';

class FileFolder {
  String? sId;
  String? name;
  String? description;
  int? idClass;
  ClassModel? mClass;
  Subject? subject;
  String? type;
  String? link;
  String? createdAt;
  int? createdBy;
  User? oCreatedBy;
  int? idSubject;
  int? id;
  int? iV;

  FileFolder(
      {this.sId,
      this.name,
      this.idClass,
      this.type,
      this.description,
      this.link,
      this.createdAt,
      this.createdBy,
      this.idSubject,
      this.id,
      this.iV});

  FileFolder.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    idClass = json['idClass'];
    description = json['description'];
    mClass = json['class'];
    if (json['oCreatedBy'] != null)
      oCreatedBy = User.fromJson(json['oCreatedBy']);
    type = json['type'];
    link = json['link'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    idSubject = json['idSubject'];
    subject = json['subject'];
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sId != null) data['_id'] = this.sId;
    if (this.name != null) data['name'] = this.name;
    if (this.description != null) data['description'] = this.description;
    if (this.idClass != null) data['idClass'] = this.idClass;
    if (this.mClass != null) data['mClass'] = this.mClass;
    if (this.type != null) data['type'] = this.type;
    if (this.link != null) data['link'] = this.link;
    if (this.createdAt != null) data['createdAt'] = this.createdAt;
    if (this.createdBy != null) data['createdBy'] = this.createdBy;
    if (this.idSubject != null) data['idSubject'] = this.idSubject;
    if (this.subject != null) data['subject'] = this.subject;
    if (this.id != null) data['id'] = this.id;
    if (this.iV != null) data['__v'] = this.iV;
    return data;
  }
}
