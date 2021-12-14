import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base64.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/date_time/date_time_utils.dart';
import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/group_role.dart';
import 'package:web_lms/model/user.dart';
import 'package:web_lms/ui/list_user/list_user_controller.dart';

class AddUserController extends BaseController {
  var isActive = false.obs;
  User? pUser;
  List<TextEditingController> edtController = [];
  var listGroupRole = <GroupRole>[].obs;
  var imageCurrent = Rxn();
  var currentGroup = ''.obs;
  var idGroup;
  var currentGender = ''.obs;
  var idGender;
  var avatar;
  List<ClassModel> listClass = [];
  int? idDepartment = -1;
  int? idSemester = -1;
  BaseGroupRole? baseGroupRole;

  @override
  initialData() async {
    for (int i = 0; i < 11; i++) {
      edtController.add(TextEditingController());
    }
    checkArgument();
    baseGroupRole = BaseGroupRole();
    await baseGroupRole!.getData();
    baseGroupRole!.listData!.forEach((element) {
      listGroupRole.add(element);
    });
    currentGroup.value = pUser?.nameGroup ?? '';
  }

  @override
  getDataSuccessFromAPI() async {
    print('get Dataaaaaaaaa' + pUser.toString());
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
    if (edtController[8].text.trim().isEmpty) {
      idDepartment = -1;
    }
    if (edtController[9].text.trim().isEmpty) {
      idSemester = -1;
    }
    return User(
        id: pUser?.id,
        userName: edtController[0].text,
        password: edtController[1].text,
        name: edtController[2].text,
        birth: edtController[3].text,
        gender: currentGender.value,
        address: edtController[5].text,
        email: edtController[6].text,
        phoneNumber: edtController[7].text,
        chuyenNganhId: idDepartment,
        avatar: pUser?.avatar,
        kiHocId: idSemester,
        data: avatar,
        idGroup: idGroup);
  }

  void checkArgument() {
    if (Get.arguments != null) {
      pUser = Get.arguments;
      edtController[0].text = pUser?.userName ?? '';
      edtController[1].text = pUser?.password ?? '';
      edtController[2].text = pUser?.name ?? '';
      edtController[3].text = pUser?.birth ?? '';
      currentGender.value = pUser?.gender ?? '';

      // edtController[4].text = gender ?? '';
      edtController[5].text = pUser?.address ?? '';
      edtController[6].text = pUser?.email ?? '';
      edtController[7].text = pUser?.phoneNumber ?? '';
      edtController[8].text = pUser?.chuyenNganh?.title ?? '';
      edtController[9].text = pUser?.kiHoc?.title ?? '';
      idDepartment = pUser?.chuyenNganhId;
      idSemester = pUser?.kiHocId;
      idGroup = pUser?.idGroup;
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

  sugestion(String pattern, int index) async {
    if (index == 8) {
      BaseDepartment baseSemester = BaseDepartment(title: pattern.toString());
      await baseSemester.getData();
      return baseSemester.listData;
    } else if (index == 9) {
      BaseSemester baseSemester = BaseSemester(title: pattern.toString());
      await baseSemester.getData();
      return baseSemester.listData;
    } else if (index == 10) {
      if (listClass.isEmpty) {
        BaseClassModel baseClassModel =
            BaseClassModel(title: pattern.toString());
        await baseClassModel.getData();
        listClass = baseClassModel.listData ?? [];
      }
      return listClass;
    } else {
      return [];
    }
  }

  valueSelected(value, int index) {
    if (index == 8) {
      idDepartment = value.id;
    } else if (index == 9) {
      idSemester = value.id;
    } else if (index == 10) {
      edtController[10].text += value.title;
    }
  }

  getCurrentValue(value, index) {
    if (index == 0) {
      currentGender.value = value.title;
    } else if (index == 1) {
      currentGroup.value = value.title;
      idGroup = value.id;
    }
  }

  onTabClass(ClassModel suggest) {
    suggest.isChoose.value = !suggest.isChoose.value;
    edtController[10].text = '';
    listClass.forEach((element) {
      if (element.isChoose.value) {
        edtController[10].text += '${element.title}; ';
      }
    });
  }
}
