import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/department.dart';
import 'package:web_lms/model/group_role.dart';
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
    BaseResponse? baseResponse = await client.getListClass();
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listData!.add(ClassModel.fromJson(element));
      });
    }
  }
}
