import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/local_service/person_manager.dart';
import 'package:web_lms/core/local_service/shared_pref.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/core/network/rest_client.dart';
import 'package:web_lms/core/resource/key_resource.dart';
import 'package:web_lms/core/resource/string_resource.dart';
import 'package:web_lms/core/status.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/user.dart';
import 'package:web_lms/ui/home/home_controller.dart';
import 'package:web_lms/ui/home/home_page.dart';

class LoginController extends BaseController {
  TextEditingController edtLogin = TextEditingController(text: 'admin');
  TextEditingController edtPassword = TextEditingController(text: '123@123a');

  @override
  initialData() async {
    setStatus(Status.success);
    var b1 = await SharedPref.containKey(KeyResource.token);
    if (b1) {
      StringResource.token = await SharedPref.getString(KeyResource.token);
    }
    if (StringResource.token != '') {
      Get.offAll(() => HomePage());
    }
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
      Get.offAll(() => HomePage());
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
