import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/add_repo/add_repository_page.dart';

import 'list_repository_controller.dart';

class ListRepositoryPage extends GetWidget<ListRepositoryController> {
  final _controller = Get.lazyPut(() => ListRepositoryController());

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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Danh sách repository',
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
              hint: 'Tên repository',
              editingController: controller.edtController,
            ),
          ),
          Utils.space(8, 0),
          CustomButton(
            title: 'Tìm kiếm',
            onTab: () => controller.search(),
          ),
          Utils.space(8, 0),
          CustomButton(
            onTab: () =>
                Get.dialog(AddRepositoryPage(), barrierDismissible: false),
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
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  'STT',
                  style: AppResource.s15b,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  'TÊN repository'.toUpperCase(),
                  style: AppResource.s15b,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  'Mô tả'.toUpperCase(),
                  style: AppResource.s15b,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  'thời gian tạo'.toUpperCase(),
                  style: AppResource.s15b,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  'người tạo'.toUpperCase(),
                  style: AppResource.s15b,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  'ẢNH',
                  style: AppResource.s15b,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
          () => BaseView(
            status: controller.status.value,
            child: SingleChildScrollView(
              child: Table(
                border:
                    TableBorder.all(color: ColorResource.grey.withOpacity(0.5)),
                columnWidths:  <int, TableColumnWidth>{
                  0: controller.listRepository.isNotEmpty ? const FixedColumnWidth(64): const FlexColumnWidth(),
                  // 1: FlexColumnWidth(),
                  // 2: FixedColumnWidth(64),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: controller.listRepository.isNotEmpty ? controller.listRepository
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
                              element.title ?? '',
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Text(
                              element.content ?? '',
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Text(
                              element.createdAt ?? '',
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Text(
                              element.createdBy?.name ?? '',
                              style: AppResource.s15r,
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              child: element.image == null
                                  ? const Text('Chưa có')
                                  : RenderImage.imageNetwork(
                                      Utils.concatUrl(element.image ?? ''),
                                      height: 80)),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Tooltip(
                                    message: 'Cật nhật',
                                    child: Material(
                                      color: ColorResource.transparent,
                                      child: InkWell(
                                        onTap: () => Get.dialog(
                                            AddRepositoryPage(),
                                            arguments: element,
                                            barrierDismissible: false),
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
                                  // Tooltip(
                                  //   message: 'Chi tiết',
                                  //   child: Material(
                                  //     color: ColorResource.transparent,
                                  //     child: InkWell(
                                  //       onTap: () => null,
                                  //       child: const Padding(
                                  //         padding: EdgeInsets.all(8.0),
                                  //         child: Icon(
                                  //           Icons.details,
                                  //           color: ColorResource.colorPrimary,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Utils.space(4, 0),
                                  Tooltip(
                                    message: 'Xóa',
                                    child: Material(
                                      color: ColorResource.transparent,
                                      child: InkWell(
                                        onTap: () => Get.dialog(
                                            ConfirmDialog(
                                              message:
                                                  'Xác nhận xóa repository \"${element.title}\"',
                                              onConfirm: () =>
                                                  controller.deleteRepository(
                                                      element.id ?? -1),
                                            ),
                                            barrierDismissible: false),
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
                    .toList() : Utils.emptyTable(),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
