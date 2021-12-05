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
    // name = json['name'] + ' (.' + (json['linkFile'] ?? '').split('.')[1] + ')';
    name = json['name'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sId != null) data['_id'] = sId;
    if (idClass != null) data['idClass'] = idClass;
    if (idSubject != null) data['idSubject'] = idSubject;
    if (this.data != null) data['data'] = this.data;
    if (name != null) data['name'] = name;
    if (description != null) data['description'] = description;
    if (listClass != null) data['listClass'] = listClass;
    if (createAt != null) data['createAt'] = createAt;
    if (createBy != null) data['createBy'] = createBy;
    if (id != null) data['id'] = id;
    if (iV != null) data['__v'] = iV;
    if (linkFile != null) data['linkFile'] = linkFile;
    if (updateAt != null) data['updateAt'] = updateAt;
    if (updateBy != null) data['updateBy'] = updateBy;
    return data;
  }
}
