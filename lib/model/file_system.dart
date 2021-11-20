import 'package:get/get.dart';

class FileSystem {
  String? sId;
  String? name;
  String? description;
  String? data;
  int? idClass;
  int? idSubject;
  List<int>? listClass;
  String? createAt;
  int? createBy;
  int? id;
  int? iV;
  String? linkFile;
  String? updateAt;
  int? updateBy;
  var isChoose = false.obs;

  FileSystem(
      {this.sId,
      this.name,
      this.description,
      this.listClass,
      this.idClass,
      this.createAt,
      this.idSubject,
      this.data,
      this.createBy,
      this.id,
      this.iV,
      this.linkFile,
      this.updateAt,
      this.updateBy});

  FileSystem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] + ' (.' + (json['linkFile'] ?? '').split('.')[1] + ')';
    description = json['description'];
    listClass = json['listClass'].cast<int>();
    createAt = json['createAt'];
    idClass = json['idClass'];
    idSubject = json['idSubject'];
    createBy = json['createBy'];
    id = json['id'];
    iV = json['__v'];
    linkFile = json['linkFile'];
    updateAt = json['updateAt'];
    updateBy = json['updateBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sId != null) data['_id'] = this.sId;
    if (this.idClass != null) data['idClass'] = this.idClass;
    if (this.idSubject != null) data['idSubject'] = this.idSubject;
    if (this.data != null) data['data'] = this.data;
    if (this.name != null) data['name'] = this.name;
    if (this.description != null) data['description'] = this.description;
    if (this.listClass != null) data['listClass'] = this.listClass;
    if (this.createAt != null) data['createAt'] = this.createAt;
    if (this.createBy != null) data['createBy'] = this.createBy;
    if (this.id != null) data['id'] = this.id;
    if (this.iV != null) data['__v'] = this.iV;
    if (this.linkFile != null) data['linkFile'] = this.linkFile;
    if (this.updateAt != null) data['updateAt'] = this.updateAt;
    if (this.updateBy != null) data['updateBy'] = this.updateBy;
    return data;
  }
}
