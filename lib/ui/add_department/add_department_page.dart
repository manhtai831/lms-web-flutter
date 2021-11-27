import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/textfield/type_ahead_custom.dart';
import 'package:web_lms/model/repository.dart';
import 'package:web_lms/ui/add_department/add_department_controller.dart';

class AddDepartmentPage extends GetWidget<AddDepartmentController> {
  final _controller = Get.lazyPut(() => AddDepartmentController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 650,
        width: Get.width * 2 / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerDialog(
                  title: controller.pDepartment != null
                      ? 'Cập nhật khối ngành'
                      : 'Thêm khối ngành'),
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
                                () => controller.imageCurrent.value == null
                                    ? RenderImage.imageNetwork(Utils.concatUrl(
                                        controller.pDepartment?.image ?? ''))
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
                                    hint: 'Tên khối ngành',
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
                            ],
                          ),
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TypeAheadCustom(
                              maxLines: 1,
                              hint: 'Học kì',
                              editingController: controller.edtController[4],
                              suggestCallBack: (pattern) async =>
                                  await controller.sugestion(pattern, 4),
                              onSuggestionSelected: (value) =>
                                  controller.valueSelected(value),
                            ),
                          ),
                          Utils.space(0, 16),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TypeAheadCustom(
                              maxLines: 1,
                              hint: 'Repository',
                              editingController: controller.edtController[5],
                              itemBuilder: (Repository suggestion) => Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                        value: suggestion.isChoose.value,
                                        onChanged: (v) => controller
                                            .valueSelected(suggestion)),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () =>
                                          controller.valueSelected(suggestion),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 24),
                                        child: Text(
                                          suggestion.title ?? '',
                                          style: AppResource.s15b,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              suggestCallBack: (pattern) async =>
                                  await controller.sugestion(pattern, 5),
                              // onSuggestionSelected: (value) =>
                              //     controller.valueSelected(value),
                            ),
                          ),
                        ],
                      ),
                    ),
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
