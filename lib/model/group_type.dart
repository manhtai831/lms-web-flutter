import 'package:get/get.dart';

class GroupType {
  String? sId;
  String? name;
  String? title;
  String? description;
  List<int>? listClass;
  String? createAt;
  int? createBy;
  int? id;
  int? idClass;
  int? iV;
  String? updateAt;
  int? updateBy;
  var isChoose = false.obs;

  GroupType(
      {this.sId,
      this.name,
      this.description,
      this.listClass,
      this.createAt,
      this.createBy,
      this.id,
      this.idClass,
      this.iV,
      this.updateAt,
      this.updateBy});

  GroupType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    title = json['name'];
    description = json['description'];
    idClass = json['idClass'];
    listClass = json['listClass'].cast<int>();
    createAt = json['createAt'];
    createBy = json['createBy'];
    id = json['id'];
    iV = json['__v'];
    updateAt = json['updateAt'];
    updateBy = json['updateBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (sId != null) data['_id'] = sId;
    if (name != null) data['name'] = name;
    if (idClass != null) data['idClass'] = idClass;
    if (description != null) data['description'] = description;
    if (listClass != null) data['listClass'] = listClass;
    if (createAt != null) data['createAt'] = createAt;
    if (createBy != null) data['createBy'] = createBy;
    if (id != null) data['id'] = id;
    if (iV != null) data['__v'] = iV;
    if (updateAt != null) data['updateAt'] = updateAt;
    if (updateBy != null) data['updateBy'] = updateBy;
    return data;
  }
}
