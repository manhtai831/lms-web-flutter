import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base64.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/file_system.dart';
import 'package:web_lms/ui/list_file_folder/list_file_folder_controller.dart';

class AddFileSystemController extends BaseController {
  FileSystem? pFileSystem;
  List<TextEditingController> edtController = [];
  int? idClass;
  int? idSubject;
  var fileCurrent = ''.obs;
  var fileBase64;
  var error = <String?>[].obs;

  @override
  initialData() async {
    if (Get.arguments[0] == 'fileSystemClass') {
      idClass = Get.arguments[1];
    } else {
      idSubject = Get.arguments[1];
    }

    if ((Get.arguments[2] is FileSystem)) {
      pFileSystem = Get.arguments[2];
    }

    for (int i = 0; i < 5; i++) {
      edtController.add(TextEditingController());
      error.add(null);
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
        idSubject: idSubject,
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

  request() async {
    error[0] = Utils.validate(s: edtController[0].text);
    if (Utils.checkValidate(l: error)) {
      await getData();
    }
  }
}
