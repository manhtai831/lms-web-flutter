import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/core/textfield/text_field_custom.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/ui/login/login_controller.dart';

class LoginPage extends GetWidget<LoginController> {
  final _controller = Get.lazyPut(() => LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Center(
      child: Container(
        height: 300,
        width: 500,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: ColorResource.white,
            // border: Border.all(),
            boxShadow: [BoxShadow(color: ColorResource.grey, blurRadius: 5)]),
        child: Column(children: [
          Text(
            'Sign in',
            style: AppResource.s15b
                .copyWith(fontSize: 20, color: ColorResource.colorPrimary),
          ),
          Utils.space(0, 32),
          TextFieldCustom(
            editingController: controller.edtLogin,
            maxLines: 1,
            hint: 'Tài khoản',
          ),
          Utils.space(0, 16),
          TextFieldCustom(
            editingController: controller.edtPassword,
            obscureText: true,
            maxLines: 1,
            hint: 'Mật khẩu',
            inputType: TextInputType.visiblePassword,
          ),
          Utils.space(0, 32),
          CustomButton(
            // width: double.infinity,
            // child: const Text(
            //   'Đăng nhập',
            //   textAlign: TextAlign.center,
            // ),
            alignment: Alignment.center,
            title: "Đăng nhập",
            onTab: () async => await controller.login(),
          ),
        ]),
      ),
    );
  }
}
