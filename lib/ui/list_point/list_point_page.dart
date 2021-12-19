import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/dropdown/dropdown_custom.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/textfield/type_ahead_custom.dart';
import 'package:web_lms/ui/add_point/add_point_page.dart';
import 'package:web_lms/ui/list_point/list_point_controller.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class ListPointPage extends GetWidget<ListPointController> {
  final _controller = Get.lazyPut(() => ListPointController());

  ListPointPage({Key? key}) : super(key: key);

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
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Điểm',
                style: AppResource.s15b
                    .copyWith(fontSize: 23, color: ColorResource.colorPrimary),
              ),
              Visibility(
                visible: controller.listFileStudent.isNotEmpty ||
                    controller.listInfoQuiz.isNotEmpty,
                child: CustomButton(
                  onTab: () => controller.exportExcel(),
                  title: 'Xuất excel',
                ),
              )
            ],
          ),
          Utils.space(0, 16),
          Row(
            children: [
              Expanded(
                child: TypeAheadCustom(
                  padV: 12,
                  hint: 'Chọn lớp học',
                  editingController: controller.edtController,
                  onSuggestionSelected: (suggestion) =>
                      controller.selected(suggestion),
                  suggestCallBack: (pattern) async =>
                      await controller.suggestCallBack(pattern),
                ),
              ),
              Utils.space(16, 8),
              Expanded(
                child: DropdownCustom(
                  currentValue: controller.groupTypeTitle.value,
                  hint: 'Chọn một danh mục cha',
                  listItems: controller.listGroupType,
                  getCurrentValue: (value, index) =>
                      controller.getValueCallBack(value, 0),
                ),
              ),
              Utils.space(16, 8),
              Expanded(
                child: DropdownCustom(
                  currentValue: controller.typeTitle.value,
                  hint: 'Chọn một danh mục con',
                  listItems: controller.listType,
                  getCurrentValue: (value, index) =>
                      controller.getValueCallBack(value, 1),
                ),
              ),
            ],
          ),
          Utils.space(0, 8),
          controller.type.value == 'QUIZ' ? viewIsQuiz() : viewNotQuiz()
        ],
      ),
    );
  }

  Widget viewNotQuiz() {
    return Expanded(
      child: Column(
        children: [
          Table(
            border: TableBorder.all(color: ColorResource.grey.withOpacity(0.5)),
            columnWidths: <int, TableColumnWidth>{
              0: const FixedColumnWidth(64),
              6: FixedColumnWidth(Get.width / 5),
              // 2: FixedColumnWidth(64),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  tableCell(header: 'STT'.toUpperCase()),
                  tableCell(header: 'Sinh viên'.toUpperCase()),
                  tableCell(header: 'File'.toUpperCase()),
                  tableCell(header: 'Đường dẫn'.toUpperCase()),
                  tableCell(header: 'Thời gian nộp'.toUpperCase()),
                  tableCell(header: 'Điểm'.toUpperCase()),
                  tableCell(header: 'Ghi chú'.toUpperCase()),
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
                      0: controller.listFileStudent.isNotEmpty
                          ? const FixedColumnWidth(64)
                          : const FlexColumnWidth(),
                      6: FixedColumnWidth(Get.width / 5),
                      // 2: FixedColumnWidth(64),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: controller.listFileStudent.isNotEmpty
                        ? controller.listFileStudent
                            .mapIndexed(
                              (index, element) => TableRow(
                                children: [
                                  tableCell(text: (index + 1).toString()),
                                  tableCell(text: element.user?.name),
                                  tableCell(text: element.name),
                                  tableCell(
                                    child: Tooltip(
                                      message: 'Mở đường dẫn',
                                      child: CustomButton(
                                        background: ColorResource.transparent,
                                        onTab: () {
                                          Utils.launchInBrowser(
                                              element.link ?? '');
                                        },
                                        child: Text(
                                          element.link ?? '',
                                          maxLines: 2,
                                          style: AppResource.s15r.copyWith(
                                              color:
                                                  ColorResource.colorPrimary),
                                        ),
                                      ),
                                    ),
                                  ),
                                  tableCell(text: element.createdAt),
                                  tableCell(
                                      text: element.point == null
                                          ? ''
                                          : element.point.toString()),
                                  tableCell(text: element.note),
                                  feature(
                                      canUpdate: PersonManager.getInstance()
                                          .hasRole(KeyRole.cap_nhat_diem),
                                      onUpdate: () => Get.dialog(AddPointPage(),
                                          arguments: element,
                                          barrierDismissible: false),
                                      canSendNotify: PersonManager.getInstance()
                                          .hasRole(KeyRole.thong_bao_diem),
                                      onSendNotification: () =>
                                          controller.sendNotification(element))
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
    );
  }

  Widget viewIsQuiz() {
    return Expanded(
      child: Column(
        children: [
          Table(
            border: TableBorder.all(color: ColorResource.grey.withOpacity(0.5)),
            columnWidths: <int, TableColumnWidth>{
              0: const FixedColumnWidth(64),
              6: FixedColumnWidth(Get.width / 5),
              // 2: FixedColumnWidth(64),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  tableCell(header: 'STT'.toUpperCase()),
                  tableCell(header: 'Sinh viên'.toUpperCase()),
                  tableCell(header: 'Thời gian bắt đầu'.toUpperCase()),
                  tableCell(header: 'Thời gian nộp'.toUpperCase()),
                  tableCell(header: 'Điểm'.toUpperCase()),
                  // tableCell(header: 'CHỨC NĂNG'.toUpperCase()),
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
                      0: controller.listInfoQuiz.isNotEmpty
                          ? const FixedColumnWidth(64)
                          : const FlexColumnWidth(),
                      6: FixedColumnWidth(Get.width / 5),
                      // 2: FixedColumnWidth(64),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: controller.listInfoQuiz.isNotEmpty
                        ? controller.listInfoQuiz
                            .mapIndexed(
                              (index, element) => TableRow(
                                children: [
                                  tableCell(text: (index + 1).toString()),
                                  tableCell(text: element.user?.name),
                                  tableCell(text: element.startTime),
                                  tableCell(text: element.endTime),
                                  tableCell(
                                      text: element.point != null
                                          ? '${element.point}'
                                          : ''),
                                  // feature(
                                  //     onUpdate: () => Get.dialog(Container(),
                                  //         barrierDismissible: false),
                                  //     onSendNotification: () {})
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
    );
  }
}
