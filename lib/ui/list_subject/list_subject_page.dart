import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/add_subject/add_subject_page.dart';
import 'package:web_lms/ui/list_subject/list_subject_controller.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class ListSubjectPage extends GetWidget<ListSubjectController> {
  final _controller = Get.lazyPut(() => ListSubjectController());

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
              'Danh sách môn học',
              style: AppResource.s15b
                  .copyWith(fontSize: 23, color: ColorResource.colorPrimary),
            ),
            Flexible(
              flex: 3,
              child: Container(),
            ),
            Visibility(
              visible:
                  PersonManager.getInstance().hasRole(KeyRole.tim_kiem_mon_hoc),
              child: Flexible(
                child: TextFieldCustom(
                  padV: 12,
                  hint: 'Tên môn học',
                  editingController: controller.edtController,
                ),
              ),
            ),
            Utils.space(8, 0),
            Visibility(
              visible:
                  PersonManager.getInstance().hasRole(KeyRole.tim_kiem_mon_hoc),
              child: CustomButton(
                title: 'Tìm kiếm',
                onTab: () => controller.search(),
              ),
            ),
            Utils.space(8, 0),
            Visibility(
              visible:
                  PersonManager.getInstance().hasRole(KeyRole.them_mon_hoc),
              child: CustomButton(
                onTab: () =>
                    Get.dialog(AddSubjectPage(), barrierDismissible: false),
                title: 'Thêm',
              ),
            )
          ],
        ),
        Utils.space(0, 16),
        Table(
          border: TableBorder.all(color: ColorResource.grey.withOpacity(0.5)),
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
                tableCell(header: 'TÊN môn học'.toUpperCase()),
                tableCell(header: 'Mô tả'.toUpperCase()),
                // tableCell(header: 'trạng thái'.toUpperCase()),
                tableCell(header: 'Thời gian tạo'.toUpperCase()),
                tableCell(header: 'người tạo'.toUpperCase()),
                tableCell(header: 'Chuyên ngành'.toUpperCase()),
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
                    0: controller.listSubject.isNotEmpty
                        ? const FixedColumnWidth(64)
                        : const FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: controller.listSubject.isNotEmpty
                      ? controller.listSubject
                          .mapIndexed(
                            (index, element) => TableRow(
                              children: [
                                tableCell(text: (index + 1).toString()),
                                tableCell(text: element.name),
                                tableCell(text: element.description),
                                // tableCell(
                                //     text: element.status == 1
                                //         ? 'Đã kích hoạt'
                                //         : 'Chưa kích hoạt'),
                                tableCell(text: element.createdAt ?? ''),
                                tableCell(text: element.createdBy?.name),
                                Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                    child:
                                        Text(element.department?.name ?? '')),
                                feature(
                                    onDelete: () => Get.dialog(
                                        ConfirmDialog(
                                          message:
                                              'Xác nhận xóa repository \"${element.name}\"',
                                          onConfirm: () => controller
                                              .delete(element.id ?? -1),
                                        ),
                                        barrierDismissible: false),
                                    canDelete: PersonManager.getInstance()
                                        .hasRole(KeyRole.xoa_mon_hoc),
                                    canUpdate: PersonManager.getInstance()
                                        .hasRole(KeyRole.cap_nhat_mon_hoc),
                                    onUpdate: () => Get.dialog(AddSubjectPage(),
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
