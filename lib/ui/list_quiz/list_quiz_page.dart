import 'package:web_lms/core/base_component/base_view.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/add_quiz/add_quiz_page.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

import 'list_quiz_controller.dart';

class ListQuizPage extends GetWidget<ListQuizController> {
  final _controller = Get.lazyPut(() => ListQuizController());

  ListQuizPage({Key? key}) : super(key: key);

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
              'Danh sách câu hỏi',
              style: AppResource.s15b
                  .copyWith(fontSize: 23, color: ColorResource.colorPrimary),
            ),
            Flexible(
              flex: 3,
              child: Container(),
            ),
            Visibility(
              // visible:
              //     PersonManager.getInstance().hasRole(KeyRole.tim_kiem_cau_hoi),
              visible: false,
              child: Flexible(
                child: TextFieldCustom(
                  padV: 12,
                  hint: 'Câu hỏi',
                  // editingController: controller.edtController,
                ),
              ),
            ),
            Utils.space(8, 0),
            Visibility(
              // visible:
              //     PersonManager.getInstance().hasRole(KeyRole.tim_kiem_cau_hoi),
              visible: false,
              child: CustomButton(
                title: 'Tìm kiếm',
                // onTab: () => controller.search(),
              ),
            ),
            Utils.space(8, 0),
            Visibility(
              visible:
                  PersonManager.getInstance().hasRole(KeyRole.them_cau_hoi),
              child: CustomButton(
                onTab: () => Get.dialog(AddQuizPage(),
                    arguments: [controller.idMonHoc],
                    barrierDismissible: false),
                title: 'Thêm',
              ),
            )
          ],
        ),
        Utils.space(0, 16),
        Obx(
          () => Expanded(
            child: BaseView(
              status: controller.status1.value,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: controller.listSubject
                              .mapIndexed((index, element) => Column(
                                    children: [
                                      Obx(
                                        () => CustomButton(
                                          onTab: () =>
                                              controller.pickSubject(element),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 12),
                                          child: Text(
                                            element.name ?? '',
                                            style: AppResource.s15b.copyWith(
                                                color: element.isChoose.value
                                                    ? ColorResource.white
                                                    : ColorResource
                                                        .colorPrimary),
                                          ),
                                          background: element.isChoose.value
                                              ? ColorResource.colorPrimary
                                              : ColorResource.white,
                                        ),
                                      ),
                                      Utils.line()
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  Utils.space(16, 16),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Table(
                          border: TableBorder.all(
                              color: ColorResource.grey.withOpacity(0.5)),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(64),
                            1: FlexColumnWidth(),
                            // 2: FixedColumnWidth(64),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                tableCell(header: 'STT'.toUpperCase()),
                                tableCell(header: 'Câu hỏi'.toUpperCase()),
                                // tableCell(header: 'Danh mục'.toUpperCase()),
                                tableCell(
                                    header: 'Thời gian tạo'.toUpperCase()),
                                tableCell(header: 'Người tạo'.toUpperCase()),
                                tableCell(header: 'CHỨC NĂNG'.toUpperCase()),
                              ],
                            ),
                          ],
                        ),
                        Obx(
                          () => Expanded(
                            flex: 2,
                            child: BaseView(
                              status: controller.status.value,
                              child: SingleChildScrollView(
                                child: Table(
                                  border: TableBorder.all(
                                      color:
                                          ColorResource.grey.withOpacity(0.5)),
                                  columnWidths: <int, TableColumnWidth>{
                                    0: controller.listQuestion.isNotEmpty
                                        ? const FixedColumnWidth(64)
                                        : const FlexColumnWidth(),
                                    1: const FlexColumnWidth(),
                                    // 2: FixedColumnWidth(64),
                                  },
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: controller.listQuestion.isNotEmpty
                                      ? controller.listQuestion
                                          .mapIndexed(
                                            (index, element) => TableRow(
                                              children: [
                                                tableCell(
                                                    text:
                                                        (index + 1).toString()),
                                                tableCell(
                                                    text: element.content),
                                                // tableCell(
                                                // text: element.danhMuc?.name),
                                                tableCell(
                                                    text: element.createdAt),
                                                tableCell(
                                                    text: element
                                                        .mCreatedBy?.name),
                                                feature(
                                                    onDelete: () => Get.dialog(
                                                        ConfirmDialog(
                                                          message:
                                                              'Xác nhận xóa câu hỏi \"${element.content}\"',
                                                          onConfirm: () => controller
                                                              .deleteQuestion(
                                                                  element.id ??
                                                                      -1),
                                                        ),
                                                        barrierDismissible:
                                                            false),
                                                    canUpdate: PersonManager
                                                            .getInstance()
                                                        .hasRole(KeyRole
                                                            .cap_nhat_cau_hoi),
                                                    canDelete: PersonManager
                                                            .getInstance()
                                                        .hasRole(
                                                            KeyRole
                                                                .xoa_cau_hoi),
                                                    onUpdate: () => Get.dialog(
                                                        AddQuizPage(),
                                                        arguments: [
                                                          controller.idMonHoc,
                                                          element
                                                        ],
                                                        barrierDismissible:
                                                            false))
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
