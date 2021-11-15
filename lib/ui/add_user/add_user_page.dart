import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/dropdown/dropdown_custom.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/core/textfield/text_field_custom.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/ui/add_user/add_user_controller.dart';

class AddUserPage extends GetWidget<AddUserController> {
  final _controller = Get.lazyPut(() => AddUserController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 650,
        width: Get.width * 2 / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerDialog(title: 'Thêm người dùng'),
              Utils.space(16, 16),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.space(16, 0),
                    Container(
                      width: Get.width / 5,
                      height: 400,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorResource.colorPrimary)),
                      alignment: Alignment.center,
                      child: Text('Tải ảnh lên'),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Utils.space(16, 0),
                              Expanded(
                                child: TextFieldCustom(
                                  maxLines: 1,
                                  hint: 'Tên tài khoản',
                                ),
                              ),
                              Utils.space(16, 0),
                              Expanded(
                                child: TextFieldCustom(
                                  hint: 'Mật khẩu',
                                  maxLines: 1,
                                  obscureText: true,
                                  inputType: TextInputType.visiblePassword,
                                ),
                              ),
                              Utils.space(16, 0),
                            ],
                          ),
                          Utils.space(0, 16),
                          Obx(
                            () => SingleChildScrollView(
                              child: Row(
                                children: [
                                  Utils.space(16, 0),
                                  Switch(
                                    onChanged: (b) => controller.isActive
                                        .value = !controller.isActive.value,
                                    value: controller.isActive.value,
                                    activeColor: ColorResource.colorPrimary,
                                    activeTrackColor:
                                        ColorResource.colorPrimary10,
                                    inactiveThumbColor: ColorResource.grey,
                                    inactiveTrackColor:
                                        ColorResource.grey.withOpacity(0.5),
                                  ),
                                  InkWell(
                                      onTap: () => controller.isActive.value =
                                          !controller.isActive.value,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Trạng thái kích hoạt',
                                          style: AppResource.s15r,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Tên người dùng',
                                  ),
                                ),
                                Utils.space(16, 0),
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Ngày sinh',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Giới tính',
                                  ),
                                ),
                                Utils.space(16, 0),
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Địa chỉ',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Email',
                                  ),
                                ),
                                Utils.space(16, 0),
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Số điện thoại',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Utils.space(0, 16),
              Container(
                width: double.infinity,
                height: 1,
                color: ColorResource.grey,
              ),
              Utils.space(0, 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    onTab: () => Get.back(),
                    title: 'Hủy',
                    background: ColorResource.grey,
                  ),
                  Utils.space(16, 0),
                  CustomButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    onTab: () => Get.back(),
                    title: 'Đồng ý',
                    background: ColorResource.colorPrimary,
                  ),
                  Utils.space(16, 0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
