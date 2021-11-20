import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';

import 'add_file_system_controller.dart';

class AddFileSystemPage extends GetWidget<AddFileSystemController> {
  final _controller = Get.lazyPut(() => AddFileSystemController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: Get.height / 2,
        width: Get.width / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerDialog(
                  title: controller.pFileSystem != null
                      ? 'Cập nhật file'
                      : 'Thêm file'),
              Utils.space(16, 16),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.space(16, 0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFieldCustom(
                                  editingController:
                                      controller.edtController[0],
                                  maxLines: 1,
                                  hint: 'Tên file',
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
                          CustomButton(
                            title: 'Chọn file',
                            onTab: () => controller.pickFile(),
                          ),
                          Utils.space(0, 16),
                          Obx(
                            () => Visibility(
                                visible: controller.fileCurrent.value != '' ||
                                    controller.pFileSystem?.linkFile != null,
                                child: Text(
                                  'Đã chọn file: ' +
                                      ((controller.fileCurrent.value != '')
                                          ? controller.fileCurrent.value
                                          : Utils.concatUrl(controller
                                                  .pFileSystem?.linkFile ??
                                              '')),
                                  style: AppResource.s15b,
                                  maxLines: 4,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
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
                    onTab: () => controller.getData(),
                    title: 'Đồng ý',
                    background: ColorResource.colorPrimary,
                  ),
                  Utils.space(16, 0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
