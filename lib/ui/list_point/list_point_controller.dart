import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/status.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/file_student.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/model/info_quiz.dart';

class ListPointController extends BaseController {
  var listFileStudent = <FileStudent>[].obs;
  var listInfoQuiz = <InfoQuiz>[].obs;
  var listClass = <ClassModel>[].obs;
  var listType = <FileFolder>[].obs;
  var listGroupType = <GroupType>[].obs;
  int? idClass = -1;
  int? idType = -1;
  var groupTypeTitle = ''.obs;
  var typeTitle = ''.obs;
  var type = ''.obs;

  TextEditingController edtController = TextEditingController();

  @override
  initialData() async {
    await getListClass();
    setStatus(Status.success);
  }

  @override
  getDataSuccessFromAPI() async {
    BaseFileStudent baseClassModel =
        BaseFileStudent(idClass: idClass, idDocumentType: idType);
    await baseClassModel.getData();
    listFileStudent.clear();
    listFileStudent.value = baseClassModel.listData!;
  }

  Future<List<ClassModel>> getListClass({String? p}) async {
    BaseClassModel baseClassModel = BaseClassModel(title: p);
    await baseClassModel.getData();
    return baseClassModel.listData ?? [];
  }

  Future getListFileFolder({int? idGroupType}) async {
    BaseFileFolder baseClassModel = BaseFileFolder(idGroupType: idGroupType);
    await baseClassModel.getData();
    listType.clear();
    listType.value = baseClassModel.listData ?? [];
  }

  Future getListGroupType() async {
    BaseGroupType baseClassModel = BaseGroupType(idClass: idClass);
    await baseClassModel.getData();
    listGroupType.clear();
    listGroupType.addAll(baseClassModel.listData ?? []);
  }

  deleteSemester(int i) {}

  Future selected(ClassModel suggestion) async {
    idClass = suggestion.id;
    listGroupType.clear();
    listType.clear();
    await getListGroupType();
    groupTypeTitle.value = '';
  }

  suggestCallBack(String pattern) async {
    return await getListClass(p: pattern);
  }

  getValueCallBack(value, int i) async {
    if (i == 0) {
      groupTypeTitle.value = (value as GroupType).title ?? '';
      listType.clear();
      await getListFileFolder(idGroupType: value.id);
      typeTitle.value = '';
    }
    if (i == 1) {
      setStatus(Status.loading);
      typeTitle.value = (value as FileFolder).title ?? '';
      idType = value.id;
      type.value = value.type ?? '';
      if (value.type == 'QUIZ') {
        BaseInfoQuiz baseInfoQuiz = BaseInfoQuiz(idDocumentType: value.id);
        await baseInfoQuiz.getData();
        listInfoQuiz.clear();
        listInfoQuiz.value = baseInfoQuiz.listData;
      } else {
        await getData();
      }

      setStatus(Status.success);
    }
  }

  sendNotification(FileStudent element) async {
    BaseSendNotification baseSendNotification = BaseSendNotification(
        idUser: element.user?.id, idFileAttach: element.id);
    await baseSendNotification.getData();
  }
}
