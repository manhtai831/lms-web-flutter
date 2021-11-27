import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/model/user.dart';
import 'package:get/get.dart';

class Repository {
  String? sId;
  String? title;
  String? type;
  String? content;
  String? image;
  String? data;
  String? createdAt;
  User? createdBy;
  int? id;

  var isChoose = false.obs;

  Repository({
    this.sId,
    this.title,
    this.id,
    this.image,
    this.data,
    this.content,
    this.type,
  });

  Repository.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    content = json['content'];
    if (json['createdAt'] != null) {
      createdAt = TimeUtils.convertTimeToFormated(
          json['createdAt'], TimeUtils.locateDatetime, TimeUtils.dateFormat);
    }

    if (json['createdBy'] != null) createdBy = User.fromJson(json['createdBy']);
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sId != null) data['_id'] = this.sId;
    if (this.title != null) data['title'] = this.title;
    if (this.type != null) data['type'] = this.type;
    if (this.data != null) data['data'] = this.data;
    if (this.image != null) data['image'] = this.image;
    if (this.content != null) data['content'] = this.content;
    if (this.id != null) data['id'] = this.id;
    return data;
  }
}
