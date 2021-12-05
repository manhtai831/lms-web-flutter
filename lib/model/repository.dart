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
    if (sId != null) data['_id'] = sId;
    if (title != null) data['title'] = title;
    if (type != null) data['type'] = type;
    if (this.data != null) data['data'] = this.data;
    if (image != null) data['image'] = image;
    if (content != null) data['content'] = content;
    if (id != null) data['id'] = id;
    return data;
  }
}
