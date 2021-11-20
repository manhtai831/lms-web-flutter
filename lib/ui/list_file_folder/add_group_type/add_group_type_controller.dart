import 'package:flutter/material.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/ui/list_file_folder/list_file_folder_controller.dart';

class AddGroupTypeController extends BaseController {
  GroupType? pGroupType;
  List<TextEditingController> edtController = [];
  int? idClass;

  @override
  initialData() async {
    idClass = Get.arguments[0];
    if (Get.arguments.length > 1) {
      pGroupType = Get.arguments[1];
    }

    for (int i = 0; i < 5; i++) {
      edtController.add(TextEditingController());
    }
    edtController[0].text = pGroupType?.name ?? '';
    edtController[1].text = pGroupType?.name ?? '';
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (pGroupType != null) {
      baseResponse = await client.updateGroupType(getJsonObjectRequest());
    } else {
      baseResponse = await client.createGroupType(getJsonObjectRequest());
    }
    if (checkError(baseResponse)) {
      ListFileFolderController fileFolderController = Get.find();
      fileFolderController.getListGroupType();
      Get.back();
      Utils.snackBar(
          message: pGroupType != null
              ? 'Cập nhật nhóm danh mục thành công'
              : 'Thêm nhóm danh mục thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    return GroupType(
        id: pGroupType?.id,
        name: edtController[0].text,
        description: edtController[1].text,
        idClass: idClass);
  }
}
