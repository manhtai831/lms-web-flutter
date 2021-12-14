import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/dropdown/dropdown_custom.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/core/render_image.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/core/textfield/text_field_custom.dart';
import 'package:web_lms/core/textfield/type_ahead_custom.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/base_item.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/ui/add_user/add_user_controller.dart';

class AddUserPage extends GetWidget<AddUserController> {
  final _controller = Get.lazyPut(() => AddUserController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: Get.height * 3 / 4,
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
                    Column(
                      children: [
                        Material(
                          color: ColorResource.transparent,
                          child: InkWell(
                            onTap: () => controller.pickImage(),
                            child: Container(
                              width: Get.width / 5,
                              height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorResource.colorPrimary)),
                              alignment: Alignment.center,
                              child: Obx(
                                () => controller.imageCurrent.value == null
                                    ? controller.pUser?.avatar != null
                                        ? RenderImage.imageNetwork(
                                            Utils.concatUrl(
                                                controller.pUser?.avatar ?? ''))
                                        : Utils.space(0, 0)
                                    : RenderImage.getImageStorage(
                                        path64: controller.imageCurrent.value),
                              ),
                            ),
                          ),
                        ),
                        Utils.space(0, 12),
                        const Text('Tải ảnh lên')
                      ],
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
                                  editingController:
                                      controller.edtController[0],
                                  maxLines: 1,
                                  isReadOnly: controller.pUser != null,
                                  hint: 'Tên tài khoản',
                                ),
                              ),
                              Utils.space(16, 0),
                              Expanded(
                                child: TextFieldCustom(
                                  hint: 'Mật khẩu',
                                  editingController:
                                      controller.edtController[1],
                                  maxLines: 1,
                                  obscureText: true,
                                  inputType: TextInputType.visiblePassword,
                                ),
                              ),
                              Utils.space(16, 0),
                            ],
                          ),
                          Utils.space(0, 16),
                          /*Obx(
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
                          ),*/
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Tên người dùng',
                                    editingController:
                                        controller.edtController[2],
                                  ),
                                ),
                                Utils.space(16, 0),
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Ngày sinh',
                                    isReadOnly: true,
                                    onTap: () => controller.datePicker(),
                                    editingController:
                                        controller.edtController[3],
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
                                  child: Obx(
                                    () => DropdownCustom(
                                      hint: 'Giới tính',
                                      listItems: [
                                        BaseItem(id: 0, title: 'Nam'),
                                        BaseItem(id: 1, title: 'Nữ'),
                                      ],
                                      getCurrentValue: (value, index) =>
                                          controller.getCurrentValue(value, 0),
                                      currentValue:
                                          controller.currentGender.value,
                                    ),
                                  ),
                                ),
                                Utils.space(16, 0),
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Địa chỉ',
                                    editingController:
                                        controller.edtController[5],
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
                                    editingController:
                                        controller.edtController[6],
                                  ),
                                ),
                                Utils.space(16, 0),
                                Expanded(
                                  child: TextFieldCustom(
                                    maxLines: 1,
                                    hint: 'Số điện thoại',
                                    editingController:
                                        controller.edtController[7],
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
                                  child: TypeAheadCustom(
                                    maxLines: 1,
                                    hint: 'Chuyên ngành',
                                    editingController:
                                        controller.edtController[8],
                                    suggestCallBack: (pattern) async =>
                                        await controller.sugestion(pattern, 8),
                                    onSuggestionSelected: (value) =>
                                        controller.valueSelected(value, 8),
                                  ),
                                ),
                                Utils.space(16, 0),
                                Expanded(
                                  child: TypeAheadCustom(
                                    maxLines: 1,
                                    hint: 'Học kì',
                                    editingController:
                                        controller.edtController[9],
                                    suggestCallBack: (pattern) async =>
                                        await controller.sugestion(pattern, 9),
                                    onSuggestionSelected: (value) =>
                                        controller.valueSelected(value, 9),
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
                                  child: Obx(
                                    () => DropdownCustom(
                                      hint: 'Quyền',
                                      listItems: controller.listGroupRole,
                                      getCurrentValue: (value, index) =>
                                          controller.getCurrentValue(value, 1),
                                      currentValue:
                                          controller.currentGroup.value,
                                    ),
                                  ),
                                ),
                                Utils.space(16, 0),
                                Expanded(
                                  child: TypeAheadCustom(
                                    hint: 'Lớp học',
                                    editingController:
                                        controller.edtController[10],
                                    itemBuilder: (ClassModel suggest) =>
                                        Obx(() => InkWell(
                                              onTap: () => controller
                                                  .onTabClass(suggest),
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                      value: suggest
                                                          .isChoose.value,
                                                      onChanged: (bool? b) =>
                                                          suggest.isChoose
                                                                  .value =
                                                              !suggest.isChoose
                                                                  .value),
                                                  Text(
                                                    suggest.title ?? '',
                                                    style: AppResource.s15m
                                                        .copyWith(
                                                            color: suggest
                                                                    .isChoose
                                                                    .value
                                                                ? ColorResource
                                                                    .colorPrimary
                                                                : ColorResource
                                                                    .black),
                                                  ),
                                                ],
                                              ),
                                            )),
                                    suggestCallBack: (pattern) async =>
                                        await controller.sugestion(pattern, 10),
                                    // onSuggestionSelected: (value) =>
                                    //     controller.valueSelected(value, 10),
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
                    onTab: () => controller.getData(),
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
