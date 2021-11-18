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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.sId != null) data['_id'] = this.sId;
    if(this.id != null) data['id'] = this.id;
    if(this.description != null) data['description'] = this.description;
    if(this.name != null) data['name'] = this.name;
    return data;
  }
}
