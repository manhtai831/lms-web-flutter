import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';

import 'add_group_type_controller.dart';

class AddGroupTypePage extends GetWidget<AddGroupTypeController> {
  final _controller = Get.lazyPut(() => AddGroupTypeController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: Get.height / 2.3,
        width: Get.width / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerDialog(
                  title: controller.pGroupType != null
                      ? 'Cập nhật nhóm danh muc'
                      : 'Thêm nhóm danh mục'),
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
                                child: Obx(
                                  () => TextFieldCustom(
                                    editingController:
                                        controller.edtController[0],
                                    error: controller.error[0],
                                    maxLines: 1,
                                    hint: 'Tên danh mục',
                                  ),
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
                    onTab: () => controller.request(),
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
