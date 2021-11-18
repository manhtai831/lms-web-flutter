import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/list_role/list_role_controller.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class ListRolePage extends GetWidget<ListRoleController> {
  final _controller = Get.lazyPut(() => ListRoleController());

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: Get.height,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: ColorResource.grey,
                blurRadius: 3,
              )
            ], color: ColorResource.white),
            child: Column(
              children: [
                Text(
                  'Nhóm quyền',
                  style: AppResource.s15b.copyWith(fontSize: 18),
                ),
                Utils.space(0, 12),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: ColorResource.colorPrimary,
                ),
                Utils.space(0, 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    width: 170,
                    title: 'Thêm nhóm quyền',
                    onTab: () => controller.addGroup(),
                  ),
                ),
                Utils.space(0, 12),
                Expanded(
                  child: Obx(
                    () => Column(
                      children: controller.listGroup
                          .mapIndexed(
                            (index, element) => Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: ColorResource.grey.withOpacity(0.3),
                                ),
                                CustomButton(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 12),
                                  background: element.isChoose.value
                                      ? ColorResource.colorPrimary
                                      : ColorResource.white,
                                  onTab: () => controller.showRole(element),
                                  child: Text(
                                    element.name ?? '',
                                    style: AppResource.s15r.copyWith(
                                        color: element.isChoose.value
                                            ? ColorResource.white
                                            : ColorResource.black),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Utils.space(16, 0),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            height: Get.height,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: ColorResource.grey,
                blurRadius: 3,
              )
            ], color: ColorResource.white),
            child: Column(
              children: [
                Text(
                  'Thông tin nhóm',
                  style: AppResource.s15b.copyWith(fontSize: 18),
                ),
                Utils.space(0, 12),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: ColorResource.colorPrimary,
                ),
                Utils.space(0, 12),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            background: ColorResource.grey,
                            title: 'Xóa nhóm quyền',
                            onTab: () => controller.delete(),
                          ),
                          Utils.space(16, 0),
                          CustomButton(
                            onTab: () => controller.updateAndAdd(),
                            background: ColorResource.colorPrimary,
                            title: 'Cập nhật',
                          ),
                        ],
                      ),
                      Utils.space(0, 12),
                      TextFieldCustom(
                        editingController: controller.edtNameGroup,
                        hint: 'Tên nhóm',
                      ),
                      Utils.space(0, 12),
                      TextFieldCustom(
                        editingController: controller.edtDescriptionGroup,
                        hint: 'Mô tả',
                      ),
                      Utils.space(0, 12),
                      Obx(
                        () => Visibility(
                          visible: controller.visibleHeader.value,
                          child: Table(
                            border: TableBorder.all(color: ColorResource.grey),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(64),
                              1: FixedColumnWidth(64),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: [
                                  tableCell(header: 'STT'.toUpperCase()),
                                  tableCell(
                                    child: Obx(
                                      () => Checkbox(
                                          value: controller.isFullRole.value,
                                          activeColor:
                                              ColorResource.colorPrimary,
                                          onChanged: (v) =>
                                              controller.pickFullRole()),
                                    ),
                                  ),
                                  tableCell(
                                      header: 'Quyền truy cập'.toUpperCase()),
                                  tableCell(header: 'Mô tả'.toUpperCase()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.visibleBody.value,
                          child: Expanded(
                            child: Obx(
                              () => SingleChildScrollView(
                                controller: ScrollController(),
                                child: Table(
                                  border: TableBorder.all(
                                      color:
                                          ColorResource.grey.withOpacity(0.5)),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FixedColumnWidth(64),
                                    1: FixedColumnWidth(64),
                                  },
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: controller.listRole
                                      .mapIndexed(
                                        (index, element) => TableRow(
                                          children: [
                                            tableCell(
                                                text: (index + 1).toString()),
                                            tableCell(
                                                child: Obx(
                                              () => Checkbox(
                                                  value: element.isChoose.value,
                                                  activeColor: ColorResource
                                                      .colorPrimary,
                                                  onChanged: (v) => controller
                                                      .chooseRole(element)),
                                            )),
                                            tableCell(
                                                child: CustomButton(
                                              onTab: () => controller
                                                  .chooseRole(element),
                                              background:
                                                  ColorResource.transparent,
                                              child: Text(
                                                element.name ?? '',
                                                style: AppResource.s15b,
                                              ),
                                            )),
                                            tableCell(
                                                child: CustomButton(
                                              onTab: () => controller
                                                  .chooseRole(element),
                                              background:
                                                  ColorResource.transparent,
                                              child: Text(
                                                element.description ?? '',
                                                style: AppResource.s15b,
                                              ),
                                            )),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
