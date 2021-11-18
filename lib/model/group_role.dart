import 'package:get/get.dart';

class GroupRole {
  String? name;
  String? title;
  int? id;
  String? description;
  List<int>? roles;
  var isChoose = false.obs;

  GroupRole({this.name, this.roles, this.id, this.description});

  GroupRole.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['name'];
    id = json['id'];
    description = json['description'];
    if (json['roles'] != null) {
      roles = [];
      json['roles'].forEach((element) => roles!.add(element));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) data['name'] = this.name;
    if (this.id != null) data['id'] = this.id;
    if (this.description != null) data['description'] = this.description;
    if (this.roles != null) data['roles'] = this.roles;
    return data;
  }
}
