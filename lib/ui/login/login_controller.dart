import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/local_service/person_manager.dart';
import 'package:web_lms/core/local_service/shared_pref.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/core/network/rest_client.dart';
import 'package:web_lms/core/resource/key_resource.dart';
import 'package:web_lms/core/resource/string_resource.dart';
import 'package:web_lms/core/role_map.dart';
import 'package:web_lms/core/status.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/user.dart';
import 'package:web_lms/ui/home/home_controller.dart';
import 'package:web_lms/ui/home/home_page.dart';

class LoginController extends BaseController {
  TextEditingController edtLogin = TextEditingController(text: '');
  TextEditingController edtPassword = TextEditingController(text: '');

  @override
  initialData() async {
    setStatus(Status.loading);
    var b1 = await SharedPref.containKey(KeyResource.token);
    if (b1) {
      StringResource.token = await SharedPref.getString(KeyResource.token);
      BaseUserInfo baseUserInfo = BaseUserInfo();
      await baseUserInfo.getData();
      PersonManager.getInstance().user = baseUserInfo.user;
    }
    if (PersonManager.getInstance().hasRole(KeyRole.dang_nhap_cms)) {
      if (StringResource.token != '') {
        Get.offAll(() => HomePage());
      }
    }
    setStatus(Status.success);
  }

  @override
  getDataSuccessFromAPI() async {
    setStatus(Status.loading);

    var response = await client.login(getJsonObjectRequest());

    if (checkError(response)) {
      User user = User.fromJson(response?.data);
      Utils.snackBar(title: 'Xin chào ' + (user.name ?? ''));
      PersonManager.getInstance().user = user;
      await SharedPref.putString(KeyResource.token, user.token ?? '');
      setStatus(Status.success);

      StringResource.token = user.token ?? '';
      NetworkUtils.client = null;
      client = await NetworkUtils.getClientInstance();
      if (PersonManager.getInstance().hasRole(KeyRole.dang_nhap_cms)) {
        Get.offAll(() => HomePage());
      } else {
        Utils.snackBar(message: 'Vui lòng kiểm tra lại tài khoản');
      }
    }
    setStatus(Status.success);
  }

  @override
  getJsonObjectRequest() {
    return User(userName: edtLogin.text, password: edtPassword.text);
  }

  login() async {
    await getData();
  }
}
