import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/add_answer/add_answer_controller.dart';

class AddAnswerPage extends GetWidget<AddAnswerController> {
  final _controller = Get.lazyPut(() => AddAnswerController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: Get.height / 2.6,
        width: Get.width / 2.5,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerDialog(title: 'Thêm câu trả lời'),
              Utils.space(16, 16),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    TextFieldCustom(
                      editingController: controller.edtController,
                      maxLines: 1,
                      hint: 'Câu trả lời',
                    ),
                    Utils.space(0, 16),
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
