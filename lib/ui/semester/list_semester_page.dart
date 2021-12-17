import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/add_semester/add_semester_page.dart';
import 'package:web_lms/ui/semester/list_semester_controller.dart';

class ListSemesterPage extends GetWidget<ListSemesterController> {
  final _controller = Get.lazyPut(() => ListSemesterController());

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
              'Danh sách kì học',
              style: AppResource.s15b
                  .copyWith(fontSize: 23, color: ColorResource.colorPrimary),
            ),
            Flexible(
              flex: 3,
              child: Container(),
            ),
            Visibility(
              visible:
                  PersonManager.getInstance().hasRole(KeyRole.tim_kiem_hoc_ky),
              child: Flexible(
                child: TextFieldCustom(
                  padV: 12,
                  hint: 'Tên kì học',
                  editingController: controller.edtController,
                ),
              ),
            ),
            Utils.space(8, 0),
            Visibility(
              visible:
                  PersonManager.getInstance().hasRole(KeyRole.tim_kiem_hoc_ky),
              child: CustomButton(
                title: 'Tìm kiếm',
                onTab: () => controller.search(),
              ),
            ),
            Utils.space(8, 0),
            Visibility(
              visible: PersonManager.getInstance().hasRole(KeyRole.them_hoc_ky),
              child: CustomButton(
                onTab: () =>
                    Get.dialog(AddSemesterPage(), barrierDismissible: false),
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
                tableCell(header: 'TÊN Kì học'.toUpperCase()),
                tableCell(header: 'Mô tả'.toUpperCase()),
                tableCell(header: 'thời gian bắt đầu'.toUpperCase()),
                tableCell(header: 'Thời gian kết thúc'.toUpperCase()),
                // tableCell(header: 'trạng thái'.toUpperCase()),
                tableCell(header: 'người tạo'.toUpperCase()),
                tableCell(header: 'Repository'.toUpperCase()),
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
                    0: controller.listSemester.isNotEmpty
                        ? const FixedColumnWidth(64)
                        : const FlexColumnWidth(),
                    // 1: FlexColumnWidth(),
                    // 2: FixedColumnWidth(64),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: controller.listSemester.isNotEmpty
                      ? controller.listSemester
                          .mapIndexed(
                            (index, element) => TableRow(
                              children: [
                                tableCell(text: (index + 1).toString()),
                                tableCell(text: element.name),
                                tableCell(text: element.description),
                                tableCell(text: element.startTime),
                                tableCell(text: element.endTime),
                                // tableCell(
                                //     text: element.status == 1
                                //         ? 'Đã kích hoạt'
                                //         : 'Chưa kích hoạt'),
                                tableCell(text: element.createBy?.name),
                                Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                    child:
                                        Text(element.repository?.title ?? '')),
                                feature(
                                    canDelete: PersonManager.getInstance()
                                        .hasRole(KeyRole.xoa_hoc_ky),
                                    onDelete: () => Get.dialog(
                                        ConfirmDialog(
                                          message:
                                              'Xác nhận xóa học kì \"${element.name}\"',
                                          onConfirm: () => controller
                                              .deleteSemester(element.id ?? -1),
                                        ),
                                        barrierDismissible: false),
                                    canUpdate: PersonManager.getInstance()
                                        .hasRole(KeyRole.cap_nhat_hoc_ky),
                                    onUpdate: () => Get.dialog(
                                        AddSemesterPage(),
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

Widget feature({
  Function? onUpdate,
  bool? canUpdate,
  Function? onDetail,
  bool? canDetail,
  Function? onDelete,
  bool? canDelete,
  Function? onSendNotification,
  bool? canSendNotify,
}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (onUpdate != null && (canUpdate ?? false))
            Tooltip(
              message: 'Cật nhật',
              child: Material(
                color: ColorResource.transparent,
                child: InkWell(
                  onTap: () => onUpdate.call(),
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
          if (onUpdate != null && (canUpdate ?? false)) Utils.space(4, 0),
          if (onDetail != null && (canDetail ?? false))
            Tooltip(
              message: 'Chi tiết',
              child: Material(
                color: ColorResource.transparent,
                child: InkWell(
                  onTap: () => onDetail.call(),
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
          if (onDetail != null && (canDetail ?? false)) Utils.space(4, 0),
          if (onDelete != null && (canDelete ?? false))
            Tooltip(
              message: 'Xóa',
              child: Material(
                color: ColorResource.transparent,
                child: InkWell(
                  onTap: () => onDelete.call(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete,
                      color: ColorResource.colorPrimary,
                    ),
                  ),
                ),
              ),
            ),
          if (onDelete != null && (canDelete ?? false)) Utils.space(4, 0),
          if (onSendNotification != null && (canSendNotify ?? false))
            Tooltip(
              message: 'Gửi thông báo',
              child: Material(
                color: ColorResource.transparent,
                child: InkWell(
                  onTap: () => onSendNotification.call(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.send,
                      color: ColorResource.colorPrimary,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    ),
  );
}

Widget tableCell({String? text, String? header, Widget? child}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    child: child ??
        SelectableText(
          header ?? text ?? '',
          cursorColor: Colors.red,
          showCursor: false,
          toolbarOptions: const ToolbarOptions(
              copy: true, selectAll: true, cut: false, paste: false),
          style: header != null ? AppResource.s15b : AppResource.s15r,
          textAlign: TextAlign.center,
        ),
  );
}
