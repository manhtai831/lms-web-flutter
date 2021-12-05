import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/add_answer/add_answer_page.dart';
import 'package:web_lms/ui/add_quiz/add_quiz_controller.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class AddQuizPage extends GetWidget<AddQuizController> {
  final _controller = Get.lazyPut(() => AddQuizController());

  AddQuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: Get.height * 3 / 4,
        width: Get.width * 2 / 3,
        child: Column(
          children: [
            headerDialog(
                title: controller.pQuestion != null
                    ? 'Cập nhật câu hỏi'
                    : 'Thêm câu hỏi'),
            Utils.space(16, 16),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextFieldCustom(
                    editingController: controller.edtController,
                    maxLines: 1,
                    hint: 'Câu hỏi',
                  ),
                  Utils.space(0, 16),
                  Text(
                    'Câu trả lời',
                    style: AppResource.s15b.copyWith(fontSize: 18),
                  ),
                  Utils.space(0, 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      onTab: () => controller.addAnswer(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      width: 150,
                      title: 'Thêm câu trả lời',
                    ),
                  ),
                  Utils.space(0, 0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Table(
                border: TableBorder.all(color: ColorResource.grey),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(64),
                  1: FixedColumnWidth(80),
                  // 1: FlexColumnWidth(),
                  // 2: FixedColumnWidth(64),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      tableCell(header: 'STT'.toUpperCase()),
                      tableCell(header: 'Đáp án'.toUpperCase()),
                      tableCell(header: 'Câu trả lời'.toUpperCase()),
                      tableCell(header: 'CHỨC NĂNG'.toUpperCase()),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Table(
                    border: TableBorder.all(
                        color: ColorResource.grey.withOpacity(0.5)),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(64),
                      1: FixedColumnWidth(80),

                      // 2: FixedColumnWidth(64),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: controller.listAnswer
                        .mapIndexed(
                          (index, element) => TableRow(
                            children: [
                              tableCell(text: (index + 1).toString()),
                              Obx(() => tableCell(
                                  child: Checkbox(
                                      value: element.isDapAnDung.value,
                                      onChanged: (v) => controller
                                          .pickAnswerCorrect(element)))),
                              tableCell(text: element.content),
                              feature(
                                onDelete: () => Get.dialog(
                                    ConfirmDialog(
                                      message:
                                          'Xác nhận xóa câu trả lời \"${element.content}\"',
                                      onConfirm: () =>
                                          controller.deleteAnswer(index),
                                    ),
                                    barrierDismissible: false),
                              )
                            ],
                          ),
                        )
                        .toList(),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  onTab: () => Get.back(),
                  title: 'Hủy',
                  background: ColorResource.grey,
                ),
                Utils.space(16, 0),
                CustomButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  onTab: () => controller.getData(),
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
    );
  }
}
