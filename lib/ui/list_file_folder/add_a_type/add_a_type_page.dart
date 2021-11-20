import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';

import 'add_a_type_controller.dart';

class AddATypePage extends GetWidget<AddATypeController> {
  final _controller = Get.lazyPut(() => AddATypeController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: Get.height / 1.8,
        width: Get.width / 3,
        child: SingleChildScrollView(
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
                                  hint: 'Tên danh mục',
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
                                  onTap: () => controller.timePicker(5),
                                  editingController:
                                      controller.edtController[5],
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          Utils.space(0, 16),
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
