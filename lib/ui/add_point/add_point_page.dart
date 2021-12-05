import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';

import 'add_point_controller.dart';

class AddPointPage extends GetWidget<AddPointController> {
  final _controller = Get.lazyPut(() => AddPointController());

  AddPointPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: Get.height / 2.5,
        width: Get.width / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerDialog(title: 'Cập nhật điểm'),
              Utils.space(16, 16),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => TextFieldCustom(
                        editingController: controller.edtController[0],
                        error: controller.error[0],
                        maxLines: 1,
                        inputType: TextInputType.number,
                        hint: 'Điểm',
                      ),
                    ),
                    Utils.space(16, 16),
                    TextFieldCustom(
                      hint: 'Ghi chú',
                      editingController: controller.edtController[1],
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
