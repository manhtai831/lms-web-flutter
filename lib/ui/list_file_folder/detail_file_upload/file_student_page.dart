import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/list_file_folder/detail_file_upload/file_student_controller.dart';
import 'package:web_lms/ui/list_file_folder/detail_type/detail_type_page.dart';

class DetailFileStudentPage extends GetWidget<DetailFileStudentController> {
  final _controller = Get.lazyPut(() => DetailFileStudentController());

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
                  title:
                      'Chi tiết ' + (controller.dFileStudent.value.name ?? '')),
              Utils.space(16, 16),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Obx(
                  () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rowView(
                            key: 'Lớp học',
                            value:
                                controller.dFileStudent.value.classModel?.name),
                        Utils.space(0, 8),
                        Utils.line(),
                        Utils.space(0, 8),
                        rowView(
                            key: 'Danh mục',
                            value:
                                controller.dFileStudent.value.fileFolder?.name),
                        Utils.space(0, 8),
                        Utils.line(),
                        Utils.space(0, 8),
                        rowView(
                            key: 'Người đăng',
                            value: controller.dFileStudent.value.user?.name),
                        Utils.space(0, 8),
                        Utils.line(),
                        Utils.space(0, 8),
                        rowView(
                            key: 'Thời gian nộp',
                            value: controller.dFileStudent.value.createdAt),
                        Utils.space(0, 8),
                      ]),
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
                    title: 'Đóng',
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
