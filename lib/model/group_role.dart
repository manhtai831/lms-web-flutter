import 'package:get/get.dart';

class GroupRole {
  String? name;
  String? title;
  int? id;
  String? description;
  List<int>? roles;
  var isChoose = false.obs;

  GroupRole({this.name, this.title, this.roles, this.id, this.description});

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
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = name;
    if (id != null) data['id'] = id;
    if (description != null) data['description'] = description;
    if (roles != null) data['roles'] = roles;
    return data;
  }
}
