import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/subject.dart';

class ListFileFolderController extends BaseController
    with SingleGetTickerProviderMixin {
  var listFileFolder = <FileFolder>[].obs;
  TextEditingController edtController = TextEditingController();
  var currentType = ''.obs;
  var tabController;
  var visibleView = <bool>[].obs;
  var listClass = <ClassModel>[].obs;
  var listSubject = <Subject>[].obs;

  search() {}

  @override
  initialData() async {
    tabController = TabController(length: 2, vsync: this);
    visibleView.add(true);
    for (int i = 0; i < 4; i++) {
      visibleView.add(false);
    }
    await super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    getListSubject();
    await getListClass();
  }

  delete(int i) async {
    BaseResponse? baseResponse =
        await client.deleteFileFolder(FileFolder(id: i));
    if (checkError(baseResponse)) {
      BaseResponse? baseResponse = await client.getListFileFolder();
      if (checkError(baseResponse)) {
        listFileFolder.clear();
        BasePageResponse basePageResponse =
            BasePageResponse.fromJson(baseResponse?.data);
        basePageResponse.data!.forEach((element) {
          listFileFolder.add(FileFolder.fromJson(element));
        });
      }
      Get.back();
      Utils.snackBar(message: 'Xóa thành công');
    }
  }

  getListClass() async {
    BaseClassModel baseClassModel = BaseClassModel();
    await baseClassModel.getData();
    listClass.value = baseClassModel.listData!;
  }

  getListSubject() async {
    BaseSubject baseClassModel = BaseSubject();
    await baseClassModel.getData();
    listSubject.value = baseClassModel.listData!;
  }

  pickView1(element) {
    listSubject.forEach((element) {
      element.isChoose.value = false;
    });
    listClass.forEach((element) {
      element.isChoose.value = false;
    });
    element.isChoose.value = true;
    if (element is ClassModel) {
      showGroupType(element.id ?? -1);
      visibleView[1] = true;
      visibleView[2] = false;
      visibleView[3] = false;
    } else if (element is Subject) {
      visibleView[1] = false;
      visibleView[2] = false;
      visibleView[3] = true;
    }
  }

  showGroupType(int id) {}
}
