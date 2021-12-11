import 'package:web_lms/model/department.dart';
import 'package:web_lms/model/semester.dart';

class User {
  List<Permission>? permission;
  String? sId;
  String? name;
  String? title;
  String? nameGroup;
  String? data;
  String? userName;
  String? email;
  String? password;
  String? token;
  String? gender;
  int? id;
  int? idGroup;
  String? birth;
  String? phoneNumber;
  String? address;
  String? avatar;
  Department? chuyenNganh;
  int? chuyenNganhId;
  Semester? kiHoc;
  int? kiHocId;

  User(
      {this.permission,
      this.sId,
      this.name,
      this.userName,
      this.email,
      this.token,
      this.id,
      this.gender,
      this.idGroup,
      this.birth,
      this.password,
      this.phoneNumber,
      this.avatar,
      this.kiHoc,
      this.data,
      this.chuyenNganh,
      this.address,
      this.kiHocId,
      this.chuyenNganhId});

  User.fromJson(Map<String, dynamic> json) {
    if (json['permission'] != null) {
      permission = [];
      json['permission'].forEach((v) {
        permission!.add(Permission.fromJson(v));
      });
    }
    sId = json['_id'];
    gender = json['gender'];
    chuyenNganhId = json['chuyenNganhId'];
    kiHocId = json['kiHocId'];
    idGroup = json['idGroup'];
    nameGroup = json['nameGroup'];
    password = json['password'];
    name = json['name'];
    title = json['name'];
    userName = json['userName'];
    if (json['kiHoc'] != null) kiHoc = Semester.fromJson(json['kiHoc']);
    address = json['address'];
    email = json['email'];
    token = json['token'];
    id = json['id'];
    if (json['chuyenNganh'] != null) {
      chuyenNganh = Department.fromJson(json['chuyenNganh']);
    }
    birth = json['birth'];
    phoneNumber = json['phoneNumber'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (permission != null) {
      data['permission'] = permission!.map((v) => v.toJson()).toList();
    }
    if (sId != null) data['_id'] = sId;
    if (gender != null) data['gender'] = gender;
    if (idGroup != null) data['idGroup'] = idGroup;
    if (kiHocId != null) data['kiHocId'] = kiHocId;
    if (nameGroup != null) data['nameGroup'] = nameGroup;
    if (address != null) data['address'] = address;
    if (chuyenNganhId != null) data['chuyenNganhId'] = chuyenNganhId;
    if (password != null) data['password'] = password;
    if (name != null) data['name'] = name;
    if (userName != null) data['userName'] = userName;
    if (email != null) data['email'] = email;
    if (token != null) data['token'] = token;
    if (this.data != null) data['data'] = this.data;
    if (id != null) data['id'] = id;
    if (birth != null) data['birth'] = birth;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (avatar != null) data['avatar'] = avatar;
    if (chuyenNganh != null) data['chuyenNganh'] = chuyenNganh;
    if (kiHoc != null) data['kiHoc'] = kiHoc;
    return data;
  }
}

class Permission {
  String? sId;
  String? name;
  int? idRole;
  int? id;

  Permission({this.sId, this.idRole});

  Permission.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idRole = json['idRole'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['idRole'] = idRole;
    return data;
  }
}
