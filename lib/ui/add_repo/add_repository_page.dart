import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/dropdown/dropdown_custom.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/textfield/text_field_custom.dart';
import 'package:web_lms/ui/add_repo/add_repository_controller.dart';

class AddRepositoryPage extends GetWidget<AddRepositoryController> {
  final _controller = Get.lazyPut(() => AddRepositoryController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 650,
        width: Get.width * 2 / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerDialog(
                  title: controller.pRepository != null
                      ? 'Cập nhật repository'
                      : 'Thêm repository'),
              Utils.space(16, 16),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.space(16, 0),
                    Column(
                      children: [
                        Material(
                          color: ColorResource.transparent,
                          child: InkWell(
                            onTap: () => controller.pickImage(),
                            child: Container(
                              width: Get.width / 5,
                              height: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorResource.colorPrimary)),
                              alignment: Alignment.center,
                              child: Obx(
                                // () => controller.imageCurrent.value == null
                                //     ? RenderImage.imageNetwork(Utils.concatUrl(
                                //         controller.pRepository?.image ?? ''))
                                //     : RenderImage.getImageStorage(
                                //         path64: controller.imageCurrent.value),
                                () => controller.imageCurrent.value == null
                                    ? controller.pRepository?.image != null
                                        ? RenderImage.imageNetwork(
                                            Utils.concatUrl(
                                                controller.pRepository?.image ??
                                                    ''))
                                        : Utils.space(0, 0)
                                    : RenderImage.getImageStorage(
                                        path64: controller.imageCurrent.value),
                              ),
                            ),
                          ),
                        ),
                        const Text('Tải ảnh lên')
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Utils.space(16, 0),
                              Expanded(
                                child: Obx(
                                  () => TextFieldCustom(
                                    editingController:
                                        controller.edtController[0],
                                    error: controller.error[0],
                                    maxLines: 1,
                                    hint: 'Tên repository',
                                  ),
                                ),
                              ),
                              Utils.space(16, 0),
                              Expanded(
                                child: TextFieldCustom(
                                  hint: 'Mô tả',
                                  editingController:
                                      controller.edtController[1],
                                  maxLines: 1,
                                ),
                              ),
                              Utils.space(16, 0),
                              Utils.space(16, 0),
                            ],
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(16),
                              child: DropdownCustom(
                                hint: 'Chọn thể loại',
                                error: controller.error[2],
                                currentValue: controller.type,
                                listItems: Utils.typeRepository(),
                                getCurrentValue: (value, index) =>
                                    controller.getValue(value, index),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Utils.space(0, 16),
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
