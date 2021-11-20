import 'package:web_lms/core/date_time/date_time_utils.dart';
import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/list_file_folder/detail_type/detail_type_controller.dart';

class DetailTypePage extends GetWidget<DetailTypeContorller> {
  final _controller = Get.lazyPut(() => DetailTypeContorller());

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
                title: 'Chi tiết ' + (controller.dFileFolder.value.name ?? '')),
            Utils.space(16, 16),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Obx(
                () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowView(
                          key: 'Lớp học',
                          value: controller.dFileFolder.value.mClass?.name),
                      Utils.space(0, 8),
                      Utils.line(),
                      Utils.space(0, 8),
                      rowView(
                          key: 'Danh mục',
                          value: controller.dFileFolder.value.groupType?.name),
                      Utils.space(0, 8),
                      Utils.line(),
                      Utils.space(0, 8),
                      rowView(
                          key: 'Mô tả',
                          value: controller
                              .dFileFolder.value.groupType?.description),
                      Utils.space(0, 8),
                      Utils.line(),
                      Utils.space(0, 8),
                      rowView(
                          key: 'Thời gian bắt đầu',
                          value: controller.dFileFolder.value.startTime),
                      Utils.space(0, 8),
                      Utils.line(),
                      Utils.space(0, 8),
                      rowView(
                          key: 'Thời gian kết thúc',
                          value: controller.dFileFolder.value.endTime),
                      Utils.space(0, 8),
                      Utils.line(),
                      Utils.space(0, 8),
                      rowView(
                          key: 'Trạng thái', value: controller.statusEnd.value),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
    ));
  }
}

Widget rowView({String? key, String? value}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            key ?? '',
            style: AppResource.s15r.copyWith(color: ColorResource.black),
          ),
        ),
        Expanded(
          child: Text(
            value ?? '',
            style: AppResource.s15m.copyWith(color: ColorResource.colorPrimary),
          ),
        ),
      ],
    ),
  );
}
