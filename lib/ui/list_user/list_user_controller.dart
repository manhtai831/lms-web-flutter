import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/status.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/group_role.dart';
import 'package:web_lms/model/user.dart';
import 'package:get/get.dart';

class ListUserController extends BaseController {
  var listUser = <User>[].obs;
  var listGroupRole = <GroupRole>[].obs;
  var listClass = <ClassModel>[].obs;
  int? idGroup;
  TextEditingController edtController = TextEditingController();

  @override
  initialData() async {
    // await handleDelay(150);
    await getGroupRole();
    await getClass();
    return await super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getListUser();
    listUser.clear();
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      for (var element in basePageResponse.data!) {
        listUser.add(User.fromJson(element));
      }
    }
    setStatus(Status.success);
  }

  getGroupRole() async {
    BaseGroupRole baseGroupRole = BaseGroupRole();
    await baseGroupRole.getData();
    listGroupRole.value = [
      GroupRole(title: 'Tất cả', name: 'Tất cả', id: -1),
      ...baseGroupRole.listData ?? []
    ];
  }

  deleteUser(int id) async {
    BaseDeleteUser baseDeleteUser = BaseDeleteUser(id: id);
    await baseDeleteUser.getData();
    await getData();
  }

  resetPassword(int id) async {
    BaseResetPassword baseDeleteUser = BaseResetPassword(id: id);
    await baseDeleteUser.getData();
  }

  search() async {
    int? id = (idGroup == -1 || idGroup == null) ? null : idGroup;
    BaseUser baseSemester =
        BaseUser(title: edtController.text.trim(), idGroup: id);
    await baseSemester.getData();
    listUser.clear();
    listUser.value = baseSemester.listData;
  }

  getCurrentValue(value) {
    idGroup = value.id;
  }

  getClass()async {
    BaseClassModel baseGroupRole = BaseClassModel();
    await baseGroupRole.getData();
    listClass.value = [
      ClassModel(title: 'Tất cả', name: 'Tất cả', id: -1),
      ...baseGroupRole.listData ?? []
    ];
  }
}
