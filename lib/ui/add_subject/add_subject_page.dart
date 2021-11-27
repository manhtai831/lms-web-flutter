import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/textfield/type_ahead_custom.dart';
import 'package:web_lms/ui/add_subject/add_subject_controller.dart';

class AddSubjectPage extends GetWidget<AddSubjectController> {
  final _controller = Get.lazyPut(() => AddSubjectController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: Get.width / 4,
        width: Get.height * 2 / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerDialog(
                  title: controller.pSubject != null
                      ? 'Cập nhật môn học'
                      : 'Thêm môn học'),
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
                                    hint: 'Tên môn học',
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
                          // Obx(
                          //   () => SingleChildScrollView(
                          //     child: Row(
                          //       children: [
                          //         Utils.space(16, 0),
                          //         Switch(
                          //           onChanged: (b) => controller.isActive
                          //               .value = !controller.isActive.value,
                          //           value: controller.isActive.value,
                          //           activeColor: ColorResource.colorPrimary,
                          //           activeTrackColor:
                          //               ColorResource.colorPrimary10,
                          //           inactiveThumbColor: ColorResource.grey,
                          //           inactiveTrackColor:
                          //               ColorResource.grey.withOpacity(0.5),
                          //         ),
                          //         InkWell(
                          //             onTap: () => controller.isActive.value =
                          //                 !controller.isActive.value,
                          //             child: Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Text(
                          //                 'Trạng thái kích hoạt',
                          //                 style: AppResource.s15r,
                          //               ),
                          //             ))
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Utils.space(0, 16),
                          TypeAheadCustom(
                            maxLines: 1,
                            hint: 'Chuyên ngành',
                            editingController: controller.edtController[4],
                            suggestCallBack: (pattern) async =>
                                await controller.sugestion(pattern),
                            onSuggestionSelected: (value) =>
                                controller.valueSelected(value),
                          ),
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
