import 'package:get/get.dart';
class Role {
  String? sId;
  int? id;
  String? name;
  String? description;
  var isChoose = false.obs;

  Role({this.sId, this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    description = json['description'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(sId != null) data['_id'] = sId;
    if(id != null) data['id'] = id;
    if(description != null) data['description'] = description;
    if(name != null) data['name'] = name;
    return data;
  }
}
