import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/dropdown/dropdown_custom.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/textfield/type_ahead_custom.dart';
import 'package:web_lms/model/base_item.dart';
import 'package:web_lms/ui/add_file_folder/add_file_folder_controller.dart';

class AddFileFolderPage extends GetWidget<AddFileFolderController> {
  final _controller = Get.lazyPut(() => AddFileFolderController());

  @override
  Widget build(BuildContext context) => Dialog(
        child: SizedBox(
          height: Get.height / 2.3,
          width: Get.width / 3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerDialog(
                    title: controller.pFolder != null
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
                            DropdownCustom(
                              hint: 'Thể loại',
                              listItems: [
                                BaseItem(id: 0, title: 'Assignment'),
                                BaseItem(id: 1, title: 'Lab'),
                                BaseItem(id: 2, title: 'Quiz'),
                              ],
                              getCurrentValue: (value, index) =>
                                  controller.currentType.value = value.title,
                              currentValue: controller.currentType.value,
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
