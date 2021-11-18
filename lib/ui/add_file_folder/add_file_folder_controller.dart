import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/ui/list_file_folder/list_file_folder_controller.dart';

class AddFileFolderController extends BaseController {
  FileFolder? pFolder;
  List<TextEditingController> edtController = [];
  var currentType = ''.obs;

  @override
  initialData() async {
    pFolder = Get.arguments;
    for (int i = 0; i < 10; i++) {
      edtController.add(TextEditingController());
    }
    edtController[0].text = pFolder?.name ?? '';
    edtController[1].text = pFolder?.description ?? '';
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (pFolder != null) {
      baseResponse = await client.updateFileFolder(getJsonObjectRequest());
    } else {
      baseResponse = await client.createFileFolder(getJsonObjectRequest());
    }

    if (checkError(baseResponse)) {
      ListFileFolderController listDepartController = Get.find();
      listDepartController.getData();
      Get.back();
      Utils.snackBar(
          message: pFolder != null
              ? 'Cập nhật danh mục thành công'
              : 'Thêm danh mục thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    return FileFolder(
      id: pFolder?.id,
      name: edtController[0].text,
      description: edtController[1].text,
      type: currentType.value,
    );
  }
}
