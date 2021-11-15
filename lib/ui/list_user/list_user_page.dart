import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/core/textfield/text_field_custom.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/ui/add_user/add_user_page.dart';
import 'package:web_lms/ui/list_user/list_user_controller.dart';
import 'package:collection/collection.dart';

class ListUserPage extends GetWidget<ListUserController> {
  final _controller = Get.lazyPut(() => ListUserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: ColorResource.grey,
          blurRadius: 3,
        )
      ], color: ColorResource.white),
      child: _body(),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Danh sách người dùng',
              style: AppResource.s15b
                  .copyWith(fontSize: 23, color: ColorResource.colorPrimary),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              child: TextFieldCustom(
                padV: 12,
                hint: 'Tên tài khoản',
              ),
            ),
            Utils.space(8, 0),
            CustomButton(
              title: 'Tìm kiếm',
            ),
            Utils.space(8, 0),
            CustomButton(
              title: 'Thêm',
            )
          ],
        ),
        Utils.space(0, 16),
        Table(
          border: TableBorder.all(color: ColorResource.grey),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(64),
            // 1: FlexColumnWidth(),
            // 2: FixedColumnWidth(64),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    'STT',
                    style: AppResource.s15b,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    'TÊN TÀI KHOẢN',
                    style: AppResource.s15b,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    'NGÀY SINH',
                    style: AppResource.s15b,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    'SỐ ĐIỆN THOẠI',
                    style: AppResource.s15b,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    'CHUYÊN NGÀNH',
                    style: AppResource.s15b,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    'HỌC KÌ',
                    style: AppResource.s15b,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text(
                    'CHỨC NĂNG',
                    style: AppResource.s15b,
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Obx(
            () => SingleChildScrollView(
              child: Table(
                border:
                    TableBorder.all(color: ColorResource.grey.withOpacity(0.5)),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(64),
                  // 1: FlexColumnWidth(),
                  // 2: FixedColumnWidth(64),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: controller.listUser
                    .mapIndexed(
                      (index, element) => TableRow(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Text(
                              (index + 1).toString(),
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Text(
                              element.userName ?? '',
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Text(
                              element.birth ?? '',
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Text(
                              element.phoneNumber ?? '',
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Text(
                              element.chuyenNganh ?? '',
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Text(
                              element.kiHoc ?? '',
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: SingleChildScrollView(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Tooltip(
                                    message: 'Cật nhật',
                                    child: Material(
                                      color: ColorResource.transparent,
                                      child: InkWell(
                                        onTap: () => Get.dialog(AddUserPage()),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            CupertinoIcons.pen,
                                            color: ColorResource.colorPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Utils.space(4, 0),
                                  Tooltip(
                                    message: 'Reset password',
                                    child: Material(
                                      color: ColorResource.transparent,
                                      child: InkWell(
                                        onTap: () => Get.dialog(ConfirmDialog(
                                          message:
                                              'Xác nhận reset password của tài khoản \"${element.userName}\"',
                                          onConfirm: () => controller
                                              .resetPassword(element.id ?? -1),
                                        )),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.reset_tv,
                                            color: ColorResource.colorPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Utils.space(4, 0),
                                  Tooltip(
                                    message: 'Chi tiết',
                                    child: Material(
                                      color: ColorResource.transparent,
                                      child: InkWell(
                                        onTap: () => null,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.details,
                                            color: ColorResource.colorPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Utils.space(4, 0),
                                  Tooltip(
                                    message: 'Xóa',
                                    child: Material(
                                      color: ColorResource.transparent,
                                      child: InkWell(
                                        onTap: () => Get.dialog(ConfirmDialog(
                                          message:
                                              'Xác nhận xóa người dùng \"${element.name}\"',
                                          onConfirm: () => controller
                                              .deleteUser(element.id ?? -1),
                                        )),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: ColorResource.colorPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
