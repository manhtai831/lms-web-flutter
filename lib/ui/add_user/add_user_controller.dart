import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_lms/core/base64.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/date_time/date_time_utils.dart';
import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/user.dart';
import 'package:web_lms/ui/list_user/list_user_controller.dart';

class AddUserController extends BaseController {
  var isActive = false.obs;
  User? pUser;
  List<TextEditingController> edtController = [];
  var imageCurrent = Rxn();
  var avatar;

  @override
  initialData() {
    for (int i = 0; i < 10; i++) {
      edtController.add(TextEditingController());
    }
    checkArgument();
  }

  @override
  getDataSuccessFromAPI() async {
    if (pUser != null) {
      BaseResponse? baseResponse =
          await client.updateUser(getJsonObjectRequest());
      if (checkError(baseResponse)) {
        ListUserController listUserController = Get.find();
        listUserController.initialData();
        Get.back();
        Utils.snackBar(message: 'Cập nhật tài khoản thành công');
      }
    } else {
      BaseResponse? baseResponse =
          await client.register(getJsonObjectRequest());
      if (checkError(baseResponse)) {
        ListUserController listUserController = Get.find();
        listUserController.initialData();
        Get.back();
        Utils.snackBar(message: 'Thêm tài khoản thành công');
      }
    }
  }

  @override
  getJsonObjectRequest() {
    return User(
      id: pUser?.id,
      userName: edtController[0].text,
      password: edtController[1].text,
      name: edtController[2].text,
      birth: edtController[3].text,
      // gender: edtController[1].text,
      address: edtController[5].text,
      email: edtController[6].text,
      phoneNumber: edtController[7].text,
      chuyenNganh: edtController[8].text,
      kiHoc: edtController[9].text,
      data: avatar,
    );
  }

  void checkArgument() {
    if (Get.arguments != null) {
      pUser = Get.arguments;
      edtController[0].text = pUser?.userName ?? '';
      edtController[1].text = pUser?.password ?? '';
      edtController[2].text = pUser?.name ?? '';
      edtController[3].text = pUser?.birth ?? '';
      String? gender;
      if (pUser?.gender == 0) {
        gender = 'Nam';
      } else if (pUser?.gender == 1) {
        gender = 'Nữ';
      }
      edtController[4].text = gender ?? '';
      edtController[5].text = pUser?.address ?? '';
      edtController[6].text = pUser?.email ?? '';
      edtController[7].text = pUser?.phoneNumber ?? '';
      edtController[8].text = pUser?.chuyenNganh ?? '';
      edtController[9].text = pUser?.kiHoc ?? '';
    }
  }

  pickImage() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      imageCurrent.value = pickedFile.files.first.bytes!;
      avatar = Base64Converter.convertImageToBase64(file: pickedFile);
    }
  }

  datePicker() async {
    DateTime? date = await DateTimeUtils.showDatePickerDialog(Get.context!);
    if (date != null) {
      edtController[3].text =
          TimeUtils.convertDateTimeToFormat(date, TimeUtils.dateFormat);
    }
  }
}
