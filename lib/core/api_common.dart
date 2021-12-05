import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/department.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/file_student.dart';
import 'package:web_lms/model/file_system.dart';
import 'package:web_lms/model/group_role.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/model/info_quiz.dart';
import 'package:web_lms/model/question.dart';
import 'package:web_lms/model/repository.dart';
import 'package:web_lms/model/semester.dart';
import 'package:web_lms/model/subject.dart';
import 'package:web_lms/model/user.dart';

class BaseDeleteUser extends BaseController {
  int? id;

  BaseDeleteUser({this.id});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.deleteUser(getJsonObjectRequest());
    if (checkError(baseResponse)) {
      Utils.snackBar(message: 'Đã xóa người dùng');
    }
  }

  @override
  getJsonObjectRequest() {
    // TODO: implement getJsonObjectRequest
    return User(id: id);
  }
}

class BaseUser extends BaseController {
  String? title;
  List<User> listData = [];

  BaseUser({this.title});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getListUserSearch(getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData.add(User.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (title != null) map['name'] = title;
    return map;
  }
}

class BaseResetPassword extends BaseController {
  int? id;

  BaseResetPassword({this.id});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.resetPassword(getJsonObjectRequest());
    if (checkError(baseResponse)) {
      Utils.snackBar(message: 'Reset password thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    // TODO: implement getJsonObjectRequest
    return User(id: id);
  }
}

class BaseRepository extends BaseController {
  String? title;
  List<Repository>? listData = [];

  BaseRepository({this.title});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getListRepositorySearch(getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(Repository.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (title != null) map['title'] = title;
    return map;
  }
}

class BaseSemester extends BaseController {
  String? title;
  List<Semester>? listData = [];

  BaseSemester({this.title});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getListSemesterSearch(getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(Semester.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (title != null) map['name'] = title;
    return map;
  }
}

class BaseDepartment extends BaseController {
  String? title;
  List<Department>? listData = [];

  BaseDepartment({this.title});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getListDepartmentSearch(getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(Department.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (title != null) map['name'] = title;
    return map;
  }
}

class BaseSubject extends BaseController {
  String? title;
  List<Subject>? listData = [];

  BaseSubject({this.title});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getListSubjectSearch(getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(Subject.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (title != null) map['name'] = title;
    return map;
  }
}

class BaseGroupRole extends BaseController {
  String? title;
  List<GroupRole>? listData = [];

  BaseGroupRole({this.title});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getListGroup();
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(GroupRole.fromJson(element));
      });
    }
  }
}

class BaseClassModel extends BaseController {
  String? title;
  List<ClassModel>? listData = [];

  BaseClassModel({this.title});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getListClass(m: getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(ClassModel.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (title != null) map['name'] = title;
    return map;
  }
}

class BaseGroupType extends BaseController {
  int? idClass;
  List<GroupType>? listData = [];

  BaseGroupType({this.idClass});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getListGroupType(m: getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(GroupType.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (idClass != null) map['idClass'] = idClass;
    return map;
  }
}

class BaseFileSystem extends BaseController {
  int? idClass;
  int? idSubject;
  List<FileSystem>? listData = [];

  BaseFileSystem({this.idClass, this.idSubject});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getListFileSystem(m: getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(FileSystem.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (idClass != null) map['idClass'] = idClass;
    if (idSubject != null) map['idSubject'] = idSubject;
    return map;
  }
}

class BaseFileStudent extends BaseController {
  int? idClass;
  int? idDocumentType;
  List<FileStudent>? listData = [];

  BaseFileStudent({this.idDocumentType, this.idClass});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getListFileStudent(m: getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(FileStudent.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (idDocumentType != null) map['idDocumentType'] = idDocumentType;
    if (idClass != null) map['idClass'] = idClass;
    return map;
  }
}

class BaseFileFolder extends BaseController {
  int? idGroupType;
  List<FileFolder>? listData = [];

  BaseFileFolder({this.idGroupType});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getListFileFolder(m: getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(FileFolder.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (idGroupType != null) map['idGroupType'] = idGroupType;
    return map;
  }
}

class BaseQuestion extends BaseController {
  String? content;
  int? idMonHoc;
  List<Question> listData = [];

  BaseQuestion({this.content, this.idMonHoc});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.getAllQuestionsQuick(m: getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData.add(Question.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (content != null) map['content'] = content;
    if (idMonHoc != null) map['idMonHoc'] = idMonHoc;
    return map;
  }
}

class BaseInfoQuiz extends BaseController {
  String? content;
  int? idDocumentType;
  List<InfoQuiz> listData = [];

  BaseInfoQuiz({this.content, this.idDocumentType});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getInfoQuiz(m: getParameters());
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData.add(InfoQuiz.fromJson(element));
      });
    }
  }

  @override
  getParameters() {
    super.getParameters();
    if (content != null) map['content'] = content;
    if (idDocumentType != null) map['idDocumentType'] = idDocumentType;
    return map;
  }
}
