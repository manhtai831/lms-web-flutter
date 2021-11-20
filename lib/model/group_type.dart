import 'package:get/get.dart';

class GroupType {
  String? sId;
  String? name;
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
    if (this.sId != null) data['_id'] = this.sId;
    if (this.name != null) data['name'] = this.name;
    if (this.idClass != null) data['idClass'] = this.idClass;
    if (this.description != null) data['description'] = this.description;
    if (this.listClass != null) data['listClass'] = this.listClass;
    if (this.createAt != null) data['createAt'] = this.createAt;
    if (this.createBy != null) data['createBy'] = this.createBy;
    if (this.id != null) data['id'] = this.id;
    if (this.iV != null) data['__v'] = this.iV;
    if (this.updateAt != null) data['updateAt'] = this.updateAt;
    if (this.updateBy != null) data['updateBy'] = this.updateBy;
    return data;
  }
}
