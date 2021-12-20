import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/core/status.dart';
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
        child: Obx(
          () => Column(children: [
            Text(
              'Sign in',
              style: AppResource.s15b
                  .copyWith(fontSize: 20, color: ColorResource.colorPrimary),
            ),
            Utils.space(0, 32),
            TextFieldCustom(
              editingController: controller.edtLogin,
              maxLines: 1,
              onValidator: (v) => controller.onValidate(1),
              error: controller.errorUserName.value,
              hint: 'Tài khoản',
            ),
            Utils.space(0, 16),
            TextFieldCustom(
              editingController: controller.edtPassword,
              obscureText: true,
              maxLines: 1,
              error: controller.errorPassword.value,
              onValidator: (v) => controller.onValidate(2),
              hint: 'Mật khẩu',
              inputType: TextInputType.visiblePassword,
            ),
            Utils.space(0, 32),
            Obx(
              () => CustomButton(
                // width: double.infinity,
                // child: const Text(
                //   'Đăng nhập',
                //   textAlign: TextAlign.center,
                // ),
                alignment: Alignment.center,
                title: "Đăng nhập",
                child: controller.status.value == Status.loading
                    ? Utils.loading(height: 23, color: ColorResource.white)
                    : Text(
                        'Đăng nhập',
                        style: AppResource.s15b
                            .copyWith(color: ColorResource.white),
                      ),
                onTab: () async => await controller.login(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
