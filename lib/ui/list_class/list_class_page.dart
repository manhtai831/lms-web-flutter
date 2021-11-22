import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/add_class/add_class_page.dart';
import 'package:web_lms/ui/list_class/list_class_controller.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class ListClassPage extends GetWidget<ListClassController> {
  final _controller = Get.lazyPut(() => ListClassController());

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
              'Danh sách lớp học',
              style: AppResource.s15b
                  .copyWith(fontSize: 23, color: ColorResource.colorPrimary),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 250,
                    child: TextFieldCustom(
                      padV: 12,
                      hint: 'Tên lớp học',
                      editingController: controller.edtController,
                    ),
                  ),
                  // Utils.space(8, 6),
                  // TextFieldCustom(
                  //   padV: 12,
                  //   hint: 'Tên môn học',
                  //   editingController: controller.edtController,
                  // ),
                  Utils.space(8, 0),
                  CustomButton(
                    title: 'Tìm kiếm',
                    // onTab: () => controller.search(),
                  ),
                  Utils.space(8, 0),
                  CustomButton(
                    onTab: () =>
                        Get.dialog(AddClassPage(), barrierDismissible: false),
                    title: 'Thêm',
                  )
                ],
              ),
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
                tableCell(header: 'STT'.toUpperCase()),
                tableCell(header: 'TÊN lớp học'.toUpperCase()),
                tableCell(header: 'Mô tả'.toUpperCase()),
                tableCell(header: 'Thời gian tạo'.toUpperCase()),
                tableCell(header: 'người tạo'.toUpperCase()),
                tableCell(header: 'Môn học'.toUpperCase()),
                tableCell(header: 'CHỨC NĂNG'.toUpperCase()),
              ],
            ),
          ],
        ),
        Expanded(
          child: Obx(
            () => BaseView(
              status: controller.status.value,
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(
                      color: ColorResource.grey.withOpacity(0.5)),
                  columnWidths: <int, TableColumnWidth>{
                    0: controller.listCLass.isNotEmpty
                        ? const FixedColumnWidth(64)
                        : const FlexColumnWidth(),
                    // 1: FlexColumnWidth(),
                    // 2: FixedColumnWidth(64),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: controller.listCLass.isNotEmpty
                      ? controller.listCLass
                          .mapIndexed(
                            (index, element) => TableRow(
                              children: [
                                tableCell(text: (index + 1).toString()),
                                tableCell(text: element.name),
                                tableCell(text: element.description),
                                tableCell(text: element.createAt),
                                tableCell(text: element.createBy?.name),
                                tableCell(text: element.subject?.name),
                                feature(
                                    onDelete: () => Get.dialog(
                                        ConfirmDialog(
                                          message:
                                              'Xác nhận xóa lớp học \"${element.name}\"',
                                          onConfirm: () => controller
                                              .delete(element.id ?? -1),
                                        ),
                                        barrierDismissible: false),
                                    onUpdate: () => Get.dialog(AddClassPage(),
                                        arguments: element,
                                        barrierDismissible: false))
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
    );
  }
}
