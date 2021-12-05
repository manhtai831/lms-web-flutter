import 'package:web_lms/model/repository.dart';
import 'package:web_lms/model/semester.dart';
import 'package:web_lms/model/user.dart';

class Department {
  String? sId;
  String? name;
  String? title;
  int? idSemester;
  List<int>? listRepo;
  List<Repository>? listRepoObj;
  String listRepoStrings = '';
  String? image;
  String? data;
  String? description;
  String? createAt;
  int? status;
  User? createBy;
  int? id;
  int? iV;
  Semester? semester;

  Department(
      {this.sId,
      this.name,
      this.idSemester,
      this.image,
      this.listRepo,
      this.description,
      this.status,
      this.data,
      this.createAt,
      this.createBy,
      this.id,
      this.iV,
      this.semester});

  Department.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    title = json['name'];
    idSemester = json['idSemester'];
    image = json['image'];
    status = json['status'];
    if (json['listRepoObj'] != null) {
      listRepoObj = [];
      json['listRepoObj'].forEach((element) {
        Repository repository = Repository.fromJson(element);
        listRepoObj!.add(repository);
        listRepoStrings += '${repository.title}; ';
      });
      if (listRepoStrings.length > 2) {
        listRepoStrings =
            listRepoStrings.substring(0, listRepoStrings.length - 2);
      }
    }
    description = json['description'];
    createAt = json['createAt'];
    createBy =
        json['createBy'] != null ? User.fromJson(json['createBy']) : null;
    semester =
        json['semester'] != null ? Semester.fromJson(json['semester']) : null;
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (sId != null) data['_id'] = sId;
    if (name != null) data['name'] = name;
    if (idSemester != null) data['idSemester'] = idSemester;
    if (image != null) data['image'] = image;
    if (status != null) data['status'] = status;
    if (description != null) data['description'] = description;
    if (createAt != null) data['createAt'] = createAt;
    if (this.data != null) data['data'] = this.data;
    if (listRepo != null) data['listRepo'] = listRepo;
    if (createBy != null) {
      data['createBy'] = createBy!.toJson();
    }
    if (id != null) data['id'] = id;
    if (iV != null) data['__v'] = iV;
    if (semester != null) data['semester'] = semester;
    return data;
  }
}
