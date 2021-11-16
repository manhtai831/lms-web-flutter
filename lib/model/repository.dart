import 'package:web_lms/model/user.dart';

class Repository {
  String? sId;
  String? title;
  String? content;
  String? image;
  String? data;
  String? createdAt;
  User? createdBy;
  int? id;

  Repository(
      {this.sId, this.title, this.id, this.image, this.data, this.content});

  Repository.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['createdAt'];
    if (json['createdBy'] != null) createdBy = User.fromJson(json['createdBy']);
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sId != null) data['_id'] = this.sId;
    if (this.title != null) data['title'] = this.title;
    if (this.data != null) data['data'] = this.data;
    if (this.image != null) data['image'] = this.image;
    if (this.content != null) data['content'] = this.content;
    if (this.id != null) data['id'] = this.id;
    return data;
  }
}
