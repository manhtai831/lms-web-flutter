import 'package:web_lms/model/answer.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/subject.dart';
import 'package:get/get.dart';
import 'package:web_lms/model/user.dart';

class Question {
  String? content;
  String? title;
  List<int>? listCauTraLoi;
  List<Answer>? listCauTraLoiObject;
  int? idDanhMuc;
  FileFolder? danhMuc;
  int? idMonHoc;
  Subject? monHoc;
  int? idDapAp;
  String? createdAt;
  int? createdBy;
  String? sId;
  int? id;
  int? iV;
  User? mCreatedBy;
  var isChoose = false.obs;

  Question(
      {this.content,
      this.listCauTraLoi,
      this.idDanhMuc,
      this.idMonHoc,
      this.listCauTraLoiObject,
      this.idDapAp,
      this.createdAt,
      this.createdBy,
      this.sId,
      this.id,
      this.iV});

  Question.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    title = json['content'];
    // listCauTraLoi = json['listCauTraLoi'].cast<int>();
    idDanhMuc = json['idDanhMuc'];
    idMonHoc = json['idMonHoc'];
    if (json['danhMuc'] != null) {
      danhMuc = FileFolder.fromJson(json['danhMuc']);
    }

    if (json['listCauTraLoiObject'] != null) {
      listCauTraLoiObject = [];
      json['listCauTraLoiObject'].forEach((element) {
        listCauTraLoiObject!.add(Answer.fromJson(element));
      });
    }
    if (json['mCreatedBy'] != null) {
      mCreatedBy = User.fromJson(json['mCreatedBy']);
    }
    if (json['monHoc'] != null) {
      monHoc = Subject.fromJson(json['monHoc']);
    }
    idDapAp = json['idDapAp'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    sId = json['_id'];
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['listCauTraLoi'] = this.listCauTraLoi;
    data['idDanhMuc'] = this.idDanhMuc;
    if (this.listCauTraLoiObject != null) {
      data['listCauTraLoiObject'] =
          this.listCauTraLoiObject!.map((v) => v.toJson()).toList();
    }
    data['idMonHoc'] = this.idMonHoc;
    data['idDapAp'] = this.idDapAp;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['__v'] = this.iV;
    return data;
  }
}
