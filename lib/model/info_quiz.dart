import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/user.dart';

class InfoQuiz {
  String? sId;
  int? idDocumentType;
  int? idUser;
  String? startTime;
  String? endTime;
  int? id;
  int? iV;
  int? point;
  FileFolder? documentType;
  User? user;

  InfoQuiz(
      {this.sId,
      this.idDocumentType,
      this.idUser,
      this.startTime,
      this.endTime,
      this.id,
      this.iV,
      this.point,
      this.documentType,
      this.user});

  InfoQuiz.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idDocumentType = json['idDocumentType'];
    idUser = json['idUser'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    id = json['id'];
    iV = json['__v'];
    point = json['point'];
    documentType = json['documentType'] != null
        ? FileFolder.fromJson(json['documentType'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['idDocumentType'] = this.idDocumentType;
    data['idUser'] = this.idUser;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['id'] = this.id;
    data['__v'] = this.iV;
    data['point'] = this.point;
    if (this.documentType != null) {
      data['documentType'] = this.documentType!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
