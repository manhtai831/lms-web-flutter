import 'package:file_picker/file_picker.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base64.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/department.dart';
import 'package:web_lms/model/repository.dart';
import 'package:web_lms/ui/list_department/list_department_controller.dart';

class AddDepartmentController extends BaseController {
  Department? pDepartment;
  List<TextEditingController> edtController = [];
  var isActive = false.obs;
  var imageCurrent = Rxn();
  var avatar;
  int? idSemester;
  BaseRepository? baseRepository;
  List<Repository> listRepo = [];
  List<int> listRepoID = [];
  var error = <String?>[].obs;

  @override
  initialData() {
    pDepartment = Get.arguments;
    for (int i = 0; i < 10; i++) {
      edtController.add(TextEditingController());
      error.add(null);
    }
    edtController[0].text = pDepartment?.name ?? '';
    edtController[1].text = pDepartment?.description ?? '';
    edtController[4].text = pDepartment?.semester?.name ?? '';
    String s = '';
    pDepartment?.listRepoObj?.forEach((element) {
      s += '${element.title}; ';
      listRepoID.add(element.id ?? -1);
    });
    edtController[5].text = s;

    idSemester = pDepartment?.idSemester;
    if (pDepartment?.status == 0) {
      isActive.value = false;
    } else if (pDepartment?.status == 1) {
      isActive.value = true;
    }
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (pDepartment != null) {
      baseResponse = await client.updateDepartment(getJsonObjectRequest());
    } else {
      baseResponse = await client.createDepartment(getJsonObjectRequest());
    }

    if (checkError(baseResponse)) {
      ListDepartController listDepartController = Get.find();
      listDepartController.getData();
      Get.back();
      Utils.snackBar(
          message: pDepartment != null
              ? 'Cập nhật khối ngành thành công'
              : 'Thêm khối ngành thành công');
    }
  }

  pickImage() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      imageCurrent.value = pickedFile.files.first.bytes!;
      avatar = Base64Converter.convertImageToBase64(file: pickedFile);
      // print(pickedFile.files.first);
    }
  }

  sugestion(String pattern, int index) async {
    if (index == 4) {
      BaseSemester baseSemester = BaseSemester(title: pattern.toString());
      await baseSemester.getData();
      return baseSemester.listData;
    } else if (index == 5) {
      if (listRepo.isEmpty) {
        baseRepository ??= BaseRepository();
        baseRepository?.listData?.clear();
        await baseRepository?.getData();
        baseRepository!.listData?.forEach((element) {
          pDepartment?.listRepoObj?.forEach((element1) {
            if (element.id == element1.id) {
              element.isChoose.value = true;
            }
          });
        });

        listRepo = baseRepository!.listData!;
      }
      return listRepo;
    } else
      return [];
  }

  valueSelected(value) {
    if (value is Repository) {
      value.isChoose.value = !value.isChoose.value;
      edtController[5].text = '';
      listRepoID.clear();
      listRepo.forEach((element) {
        if (element.isChoose.value) {
          edtController[5].text += '${element.title ?? ''}; ';
          listRepoID.add(element.id ?? -1);
        }
      });
    } else {
      idSemester = value.id;
    }
  }

  @override
  getJsonObjectRequest() {
    return Department(
        id: pDepartment?.id,
        name: edtController[0].text,
        description: edtController[1].text,
        idSemester: idSemester,
        data: avatar,
        listRepo: listRepoID,
        status: isActive.value ? 1 : 0);
  }

  request() async {
    error[0] = Utils.validate(s: edtController[0].text);
    if (Utils.checkValidate(l: error)) {
      await getData();
    }
  }
}
