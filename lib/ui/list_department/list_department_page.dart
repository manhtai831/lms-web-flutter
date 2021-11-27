import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/add_department/add_department_page.dart';
import 'package:web_lms/ui/list_department/list_department_controller.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class ListDepartmentPage extends GetWidget<ListDepartController> {
  final _controller = Get.lazyPut(() => ListDepartController());
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
              'Danh sách khối ngành',
              style: AppResource.s15b
                  .copyWith(fontSize: 23, color: ColorResource.colorPrimary),
            ),
            Flexible(
              flex: 3,
              child: Container(),
            ),
            Flexible(
              child: TextFieldCustom(
                padV: 12,
                hint: 'Tên kì học',
                editingController: controller.edtController,
              ),
            ),
            Utils.space(8, 0),
            CustomButton(
              title: 'Tìm kiếm',
              // onTab: () => controller.search(),
            ),
            Utils.space(8, 0),
            CustomButton(
              onTab: () =>
                  Get.dialog(AddDepartmentPage(), barrierDismissible: false),
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
                tableCell(header: 'STT'.toUpperCase()),
                tableCell(header: 'Ngành học'.toUpperCase()),
                tableCell(header: 'Mô tả'.toUpperCase()),
                tableCell(header: 'Ảnh'.toUpperCase()),
                tableCell(header: 'người tạo'.toUpperCase()),
                // tableCell(header: 'trạng thái'.toUpperCase()),
                tableCell(header: 'Học kì'.toUpperCase()),
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
                    0: controller.listDepartment.isNotEmpty
                        ? const FixedColumnWidth(64)
                        : const FlexColumnWidth(),
                    // 1: FlexColumnWidth(),
                    // 2: FixedColumnWidth(64),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: controller.listDepartment.isNotEmpty
                      ? controller.listDepartment
                          .mapIndexed(
                            (index, element) => TableRow(
                              children: [
                                tableCell(text: (index + 1).toString()),
                                tableCell(text: element.name),
                                tableCell(text: element.description),
                                tableCell(
                                    child: RenderImage.imageNetwork(
                                        Utils.concatUrl(element.image ?? ''),
                                        height: 80)),
                                tableCell(text: element.createBy?.name),
                                // tableCell(
                                //     text: element.status == 1
                                //         ? 'Đã kích hoạt'
                                //         : 'Chưa kích hoạt'),
                                tableCell(text: element.semester?.title),
                                feature(
                                    onDelete: () => Get.dialog(
                                        ConfirmDialog(
                                          message:
                                              'Xác nhận xóa ngành \"${element.name}\"',
                                          onConfirm: () => controller
                                              .deleteSemester(element.id ?? -1),
                                        ),
                                        barrierDismissible: false),
                                    onUpdate: () => Get.dialog(
                                        AddDepartmentPage(),
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
