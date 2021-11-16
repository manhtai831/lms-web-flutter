import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/user.dart';
import 'package:get/get.dart';

class ListUserController extends BaseController {
  var listUser = <User>[].obs;
  TextEditingController edtController = TextEditingController();
  @override
  initialData() async {
    await handleDelay(150);
    return super.initialData();
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
    BaseUser baseSemester = BaseUser(title: edtController.text.trim());
    await baseSemester.getData();
    listUser.clear();
    listUser.value = baseSemester.listData;
  }
}
