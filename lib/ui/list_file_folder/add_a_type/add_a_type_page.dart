import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/textfield/type_ahead_custom.dart';
import 'package:web_lms/model/question.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

import 'add_a_type_controller.dart';

class AddATypePage extends GetWidget<AddATypeController> {
  final _controller = Get.lazyPut(() => AddATypeController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GestureDetector(
        onTap: () => FocusScope.of(Get.context!).requestFocus(FocusNode()),
        child: SizedBox(
          height: Get.height / 1.2,
          width: Get.width / 1.2,
          child: Column(
            children: [
              headerDialog(
                  title: controller.pFileFolder != null
                      ? 'Cập nhật danh muc'
                      : 'Thêm danh mục'),
              Utils.space(16, 16),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.space(16, 0),
                    Expanded(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => TextFieldCustom(
                                      editingController:
                                          controller.edtController[0],
                                      error: controller.error[0],
                                      maxLines: 1,
                                      hint: 'Tên danh mục',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Utils.space(0, 16),
                            TextFieldCustom(
                              hint: 'Mô tả',
                              editingController: controller.edtController[1],
                              maxLines: 1,
                            ),
                            Utils.space(0, 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFieldCustom(
                                    hint: 'Ngày bắt đầu',
                                    isReadOnly: true,
                                    error: controller.error[2],
                                    editingController:
                                        controller.edtController[2],
                                    maxLines: 1,
                                    onTap: () => controller.datePicker(2),
                                  ),
                                ),
                                Utils.space(16, 16),
                                Expanded(
                                  child: TextFieldCustom(
                                    hint: 'Giờ bắt đầu',
                                    isReadOnly: true,
                                    error: controller.error[3],
                                    onTap: () => controller.timePicker(3),
                                    editingController:
                                        controller.edtController[3],
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Utils.space(0, 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFieldCustom(
                                    hint: 'Ngày kết thúc',
                                    isReadOnly: true,
                                    error: controller.error[4],
                                    onTap: () => controller.datePicker(4),
                                    editingController:
                                        controller.edtController[4],
                                    maxLines: 1,
                                  ),
                                ),
                                Utils.space(16, 16),
                                Expanded(
                                  child: TextFieldCustom(
                                    hint: 'Giờ kết thúc',
                                    isReadOnly: true,
                                    error: controller.error[5],
                                    onTap: () => controller.timePicker(5),
                                    editingController:
                                        controller.edtController[5],
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Utils.space(0, 16),
                            Obx(
                              () => Row(
                                children: [
                                  Checkbox(
                                      value: controller.isQuiz.value,
                                      onChanged: (v) => controller.isQuiz
                                          .value = !controller.isQuiz.value),
                                  InkWell(
                                    onTap: () => controller.isQuiz.value =
                                        !controller.isQuiz.value,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 24),
                                      child: Text(
                                        'Là quiz',
                                        style: AppResource.s15b,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Utils.space(0, 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isQuiz.value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: TypeAheadCustom(
                      hint: 'Câu hỏi',
                      maxLines: 1,
                      editingController: controller.edtController[6],
                      suggestCallBack: (pattern) async =>
                          await controller.suggestion(pattern),
                      onSuggestionSelected: (suggestion) => null,
                      itemBuilder: (Question suggestion) => Row(
                        children: [
                          Obx(
                            () => Checkbox(
                                value: suggestion.isChoose.value,
                                onChanged: (v) =>
                                    controller.suggestionSelected(suggestion)),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () =>
                                  controller.suggestionSelected(suggestion),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 24),
                                child: Text(
                                  suggestion.content ?? '',
                                  style: AppResource.s15b,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isQuiz.value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Table(
                      border: TableBorder.all(color: ColorResource.grey),
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(64),
                        // 1: FixedColumnWidth(80),
                        // 1: FlexColumnWidth(),
                        // 2: FixedColumnWidth(64),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            tableCell(header: 'STT'.toUpperCase()),
                            tableCell(header: 'Câu hỏi'.toUpperCase()),
                            // tableCell(header: 'Câu trả lời'.toUpperCase()),
                            // tableCell(header: 'CHỨC NĂNG'.toUpperCase()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => Visibility(
                    visible: controller.isQuiz.value,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Table(
                        border: TableBorder.all(
                            color: ColorResource.grey.withOpacity(0.5)),
                        columnWidths: <int, TableColumnWidth>{
                          0: controller.listQuestion.isNotEmpty
                              ? const FixedColumnWidth(64)
                              : const FlexColumnWidth(),
                          // 1: FixedColumnWidth(80),

                          // 2: FixedColumnWidth(64),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: controller.listQuestion.isNotEmpty
                            ? controller.listQuestion
                                .mapIndexed(
                                  (index, element) => TableRow(
                                    children: [
                                      tableCell(text: (index + 1).toString()),
                                      tableCell(text: element.content),
                                      // tableCell(text: element.content),
                                      // feature(
                                      //   onDelete: () => Get.dialog(
                                      //       ConfirmDialog(
                                      //         message:
                                      //         'Xác nhận xóa câu trả lời \"${element.content}\"',
                                      //         onConfirm: () =>
                                      //             controller.deleteAnswer(index),
                                      //       ),
                                      //       barrierDismissible: false),
                                      // )
                                    ],
                                  ),
                                )
                                .toList()
                            : Utils.emptyTable(),
                      ),
                    ),
                  ),
                ),
              ),
              Utils.space(0, 42),
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
                    onTab: () => controller.request(),
                    title: 'Đồng ý',
                    background: ColorResource.colorPrimary,
                  ),
                  Utils.space(16, 0),
                ],
              ),
              Utils.space(0, 16),
            ],
          ),
        ),
      ),
    );
  }
}
