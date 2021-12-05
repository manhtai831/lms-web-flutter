import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/model/subject.dart';
import 'package:web_lms/model/user.dart';
import 'package:get/get.dart';

class FileFolder {
  String? sId;
  String? name;
  String? title;
  String? description;
  int? idClass;
  int? idGroupType;
  GroupType? groupType;
  ClassModel? mClass;
  Subject? subject;
  List<int>? listIdQuestion;
  String? type;
  String? startTime;
  String? endTime;
  String? link;
  String? createdAt;
  int? createdBy;
  User? oCreatedBy;
  int? idSubject;
  int? id;
  int? iV;
  var isChoose = false.obs;

  FileFolder(
      {this.sId,
      this.name,
      this.idClass,
      this.idGroupType,
      this.startTime,
      this.listIdQuestion,
      this.groupType,
      this.endTime,
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
    title = json['name'];
    idClass = json['idClass'];
    description = json['description'];
    if (json['class'] != null) mClass = ClassModel.fromJson(json['class']);
    if (json['oCreatedBy'] != null) {
      oCreatedBy = User.fromJson(json['oCreatedBy']);
    }
    type = json['type'];
    link = json['link'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['createdAt'];
    if (json['groupType'] != null) {
      groupType = GroupType.fromJson(json['groupType']);
    }
    idGroupType = json['idGroupType'];
    createdBy = json['createdBy'];
    idSubject = json['idSubject'];
    subject = json['subject'];
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sId != null) data['_id'] = sId;
    if (name != null) data['name'] = name;
    if (startTime != null) data['startTime'] = startTime;
    if (description != null) data['description'] = description;
    if (idGroupType != null) data['idGroupType'] = idGroupType;
    if (endTime != null) data['endTime'] = endTime;
    if (groupType != null) data['groupType'] = groupType;
    if (listIdQuestion != null) data['listQuestion'] = listIdQuestion;
    if (idClass != null) data['idClass'] = idClass;
    if (mClass != null) data['mClass'] = mClass;
    if (type != null) data['type'] = type;
    if (link != null) data['link'] = link;
    if (createdAt != null) data['createdAt'] = createdAt;
    if (createdBy != null) data['createdBy'] = createdBy;
    if (idSubject != null) data['idSubject'] = idSubject;
    if (subject != null) data['subject'] = subject;
    if (id != null) data['id'] = id;
    if (iV != null) data['__v'] = iV;
    return data;
  }
}
