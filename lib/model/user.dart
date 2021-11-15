class User {
  List<Permission>? permission;
  String? sId;
  String? name;
  String? userName;
  String? email;
  String? password;
  String? token;
  int? id;
  String? birth;
  String? phoneNumber;
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
      this.birth,
      this.password,
      this.phoneNumber,
      this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    if (json['permission'] != null) {
      permission = [];
      json['permission'].forEach((v) {
        permission!.add(new Permission.fromJson(v));
      });
    }
    sId = json['_id'];
    name = json['name'];
    userName = json['userName'];
    kiHoc = json['kiHoc'];
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
    if (this.password != null) data['password'] = this.password;
    if (this.name != null) data['name'] = this.name;
    if (this.userName != null) data['userName'] = this.userName;
    if (this.email != null) data['email'] = this.email;
    if (this.token != null) data['token'] = this.token;
    if (this.id != null) data['id'] = this.id;
    if (this.birth != null) data['birth'] = this.birth;
    if (this.phoneNumber != null) data['phoneNumber'] = this.phoneNumber;
    if (this.avatar != null) data['avatar'] = this.avatar;
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
