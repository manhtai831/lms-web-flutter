import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_lms/core/base64.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/file_system.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/ui/list_file_folder/list_file_folder_controller.dart';

class AddFileSystemController extends BaseController {
  FileSystem? pFileSystem;
  List<TextEditingController> edtController = [];
  int? idClass;
  var fileCurrent = ''.obs;
  var fileBase64;
  @override
  initialData() async {
    idClass = Get.arguments[0];
    if (Get.arguments.length > 1) {
      pFileSystem = Get.arguments[1];
    }

    for (int i = 0; i < 5; i++) {
      edtController.add(TextEditingController());
    }
    edtController[0].text = pFileSystem?.name ?? '';
    edtController[1].text = pFileSystem?.description ?? '';
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (pFileSystem != null) {
      baseResponse = await client.updateFileSystem(getJsonObjectRequest());
    } else {
      baseResponse = await client.createFileSystem(getJsonObjectRequest());
    }
    if (checkError(baseResponse)) {
      ListFileFolderController fileFolderController = Get.find();
      fileFolderController.getListFileSystem();
      Get.back();
      Utils.snackBar(
          message: pFileSystem != null
              ? 'Cập nhật file thành công'
              : 'Thêm file thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    return FileSystem(
        id: pFileSystem?.id,
        name: edtController[0].text,
        linkFile: pFileSystem?.linkFile,
        description: edtController[1].text,
        data: fileBase64,
        idClass: idClass);
  }

  pickFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      fileCurrent.value = pickedFile.files.first.name;
      fileBase64 = Base64Converter.convertImageToBase64(file: pickedFile);
    }
  }
}
