import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/file_student.dart';
import 'package:web_lms/model/file_system.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/model/subject.dart';
import 'package:web_lms/ui/list_file_folder/add_a_type/add_a_type_page.dart';
import 'package:web_lms/ui/list_file_folder/add_file_system/add_file_system_page.dart';
import 'package:web_lms/ui/list_file_folder/add_group_type/add_group_type_page.dart';

class ListFileFolderController extends BaseController {
  var listFileFolder = <FileFolder>[].obs;
  TextEditingController edtController = TextEditingController();
  var currentType = ''.obs;
  TabController? tabController;
  TabController? tabController1;
  var visibleView = <bool>[].obs;
  var listClass = <ClassModel>[].obs;
  var listSubject = <Subject>[].obs;

  var listGroupType = <GroupType>[].obs;
  var listFileSystem = <FileSystem>[].obs;

  var listType = <FileFolder>[].obs;

  var listFileStudent = <FileStudent>[].obs;

  var deleteFile_GroupType = 'Xóa nhóm danh mục'.obs;
  var addFile_GroupType = 'Thêm nhóm danh mục'.obs;

  int? idGroupType;
  int? idClass;
  int? idType;
  int? idSubject;
  int? idSubjectForQuiz;

  @override
  initialData() async {
    tabController = TabController(length: 2, vsync: TabControllerSign());
    tabController1 = TabController(length: 2, vsync: TabControllerSign());
    tabController1!.addListener(() {
      if (tabController1!.index == 0) {
        deleteFile_GroupType.value = 'Xóa nhóm danh mục';
        addFile_GroupType.value = 'Thêm nhóm danh mục';
      } else {
        deleteFile_GroupType.value = 'Xóa file';
        addFile_GroupType.value = 'Thêm file';
      }
    });
    visibleView.add(true);
    for (int i = 0; i < 5; i++) {
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

  getListGroupType() async {
    BaseGroupType baseClassModel = BaseGroupType(idClass: idClass);
    await baseClassModel.getData();
    listGroupType.clear();
    listGroupType.value = baseClassModel.listData!;
  }

  getListFileSystem() async {
    BaseFileSystem baseClassModel;
    if (idSubject != null) {
      baseClassModel = BaseFileSystem(idSubject: idSubject);
    } else {
      baseClassModel = BaseFileSystem(idClass: idClass);
    }
    await baseClassModel.getData();
    listFileSystem.clear();
    listFileSystem.value = baseClassModel.listData!;
  }

  getListFileFolder({int? idGroupType}) async {
    BaseFileFolder baseClassModel = BaseFileFolder(idGroupType: idGroupType);
    await baseClassModel.getData();
    listType.clear();
    listType.value = baseClassModel.listData!;
  }

  getListFileStudent() async {
    BaseFileStudent baseClassModel =
        BaseFileStudent(idClass: idClass, idDocumentType: idType);
    await baseClassModel.getData();
    listFileStudent.clear();
    listFileStudent.value = baseClassModel.listData!;
  }

  pickView1(element) async {
    listSubject.forEach((element) {
      element.isChoose.value = false;
    });
    listClass.forEach((element) {
      element.isChoose.value = false;
    });
    element.isChoose.value = true;

    if (element is ClassModel) {
      idClass = element.id;
      idSubject = null;
      idSubjectForQuiz = element.idSubject;
      visibleView[1] = true;
      visibleView[2] = false;
      visibleView[3] = false;
      visibleView[5] = false;
    } else {
      idSubject = element.id;
      visibleView[2] = false;
      visibleView[3] = false;
      visibleView[5] = true;
    }
    await getListGroupType();
    await getListFileSystem();
  }

  pickView2(element) {
    listGroupType.forEach((element) {
      element.isChoose.value = false;
    });
    listFileSystem.forEach((element) {
      element.isChoose.value = false;
    });
    element.isChoose.value = true;
    if (element is GroupType) {
      getListFileFolder(idGroupType: element.id);
      idGroupType = element.id;
      visibleView[1] = true;
      visibleView[2] = true;
      visibleView[3] = false;
    } else if (element is FileSystem) {
      visibleView[1] = true;
      visibleView[2] = false;
      visibleView[3] = false;
    }
  }

  pickView3(element) {
    listType.forEach((element) {
      element.isChoose.value = false;
    });
    element.isChoose.value = true;
    if (element is FileFolder) {
      idType = element.id;
      if (element.type == 'QUIZ') {
        visibleView[3] = false;
      } else {
        getListFileStudent();
        visibleView[1] = true;
        visibleView[2] = true;
        visibleView[3] = true;
      }
    }
  }

  addType_FileSys({bool? isOnly}) {
    if (tabController1!.index == 0 && isOnly == null) {
      Get.dialog(AddGroupTypePage(),
          barrierDismissible: false, arguments: [idClass]);
    } else if (tabController1!.index == 1 || isOnly == true) {
      Get.dialog(AddFileSystemPage(),
          barrierDismissible: false, arguments: [idClass]);
    }
  }

  deleteType_FileSys() async {
    if (tabController1!.index == 0) {
      listGroupType.forEach((element) async {
        if (element.isChoose.value) {
          await Get.dialog(
              ConfirmDialog(
                onConfirm: () async {
                  BaseResponse? baseResponse =
                      await client.deleteGroupType(GroupType(id: element.id));
                  if (checkError(baseResponse)) {
                    getListGroupType();
                    Get.back();
                    Utils.snackBar(message: 'Xóa danh mục thành công');
                    visibleView[2] = false;
                    listType.forEach((element) {
                      element.isChoose.value = false;
                    });
                  }
                },
                message: 'Xác nhận xóa danh mục \"${element.name}',
              ),
              barrierDismissible: false);
        }
      });
    } else {
      listFileSystem.forEach((element) async {
        if (element.isChoose.value) {
          await Get.dialog(ConfirmDialog(
            onConfirm: () async {
              BaseResponse? baseResponse =
                  await client.deleteFileSystem(FileSystem(id: element.id));
              if (checkError(baseResponse)) {
                getListFileSystem();
                Get.back();
                Utils.snackBar(message: 'Xóa file hệ thống thành công');
              }
            },
            message: 'Xác nhận xóa file \"${element.name}',
          ));
        }
      });
    }
  }

  addFileFolder() async {
    await Get.dialog(AddATypePage(),
        arguments: [idClass, idGroupType, null, idSubjectForQuiz],
        barrierDismissible: false);
  }

  deleteFileFolder() {
    listType.forEach((element) async {
      if (element.isChoose.value) {
        BaseResponse? baseResponse =
            await client.deleteFileFolder(FileFolder(id: element.id));
        if (checkError(baseResponse)) {
          getListFileFolder(idGroupType: idGroupType);
          visibleView[3] = false;
          Get.back();
          Utils.snackBar(message: 'Xóa danh mục thành công');
        }
      }
    });
  }

  deleteFile() async {
    listFileStudent.forEach((element) async {
      if (element.isChoose.value) {
        BaseResponse? baseResponse =
            await client.deleteFileStudent(FileStudent(id: element.id));
        if (checkError(baseResponse)) {
          getListFileStudent();
          Get.back();
          Utils.snackBar(message: 'Xóa file thành công');
        }
      }
    });
  }

  pickView4(FileStudent element) {
    listFileStudent.forEach((element) {
      element.isChoose.value = false;
    });
    element.isChoose.value = true;
  }
}

class TabControllerSign extends GetxController
    with SingleGetTickerProviderMixin {}
