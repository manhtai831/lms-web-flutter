class User {
  List<Permission>? permission;
  String? sId;
  String? name;
  String? data;
  String? userName;
  String? email;
  String? password;
  String? token;
  int? gender;
  int? id;
  String? birth;
  String? phoneNumber;
  String? address;
  String? avatar;
  String? chuyenNganh;
  String? kiHoc;

  User(
      {this.permission,
      this.sId,
      this.name,
      this.userName,
      this.email,
      this.token,
      this.id,
      this.gender,
      this.birth,
      this.password,
      this.phoneNumber,
      this.avatar,
      this.kiHoc,
      this.data,
      this.chuyenNganh,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    if (json['permission'] != null) {
      permission = [];
      json['permission'].forEach((v) {
        permission!.add(new Permission.fromJson(v));
      });
    }
    sId = json['_id'];
    gender = json['gender'];
    password = json['password'];
    name = json['name'];
    userName = json['userName'];
    kiHoc = json['kiHoc'];
    address = json['address'];
    email = json['email'];
    token = json['token'];
    id = json['id'];
    chuyenNganh = json['chuyenNganh'];
    birth = json['birth'];
    phoneNumber = json['phoneNumber'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.permission != null) {
      data['permission'] = this.permission!.map((v) => v.toJson()).toList();
    }
    if (this.sId != null) data['_id'] = this.sId;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.address != null) data['address'] = this.address;
    if (this.password != null) data['password'] = this.password;
    if (this.name != null) data['name'] = this.name;
    if (this.userName != null) data['userName'] = this.userName;
    if (this.email != null) data['email'] = this.email;
    if (this.token != null) data['token'] = this.token;
    if (this.data != null) data['data'] = this.data;
    if (this.id != null) data['id'] = this.id;
    if (this.birth != null) data['birth'] = this.birth;
    if (this.phoneNumber != null) data['phoneNumber'] = this.phoneNumber;
    if (this.avatar != null) data['avatar'] = this.avatar;
    if (this.chuyenNganh != null) data['chuyenNganh'] = this.chuyenNganh;
    if (this.kiHoc != null) data['kiHoc'] = this.kiHoc;
    return data;
  }
}

class Permission {
  String? sId;
  int? idRole;

  Permission({this.sId, this.idRole});

  Permission.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idRole = json['idRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['idRole'] = this.idRole;
    return data;
  }
}
