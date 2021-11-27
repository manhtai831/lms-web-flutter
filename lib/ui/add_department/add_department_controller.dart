import 'package:file_picker/file_picker.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base64.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/department.dart';
import 'package:web_lms/ui/list_department/list_department_controller.dart';

class AddDepartmentController extends BaseController {
  Department? pDepartment;
  List<TextEditingController> edtController = [];
  var isActive = false.obs;
  var imageCurrent = Rxn();
  var avatar;
  int? idSemester;

  @override
  initialData() {
    pDepartment = Get.arguments;
    for (int i = 0; i < 10; i++) {
      edtController.add(TextEditingController());
    }
    edtController[0].text = pDepartment?.name ?? '';
    edtController[1].text = pDepartment?.description ?? '';
    edtController[4].text = pDepartment?.semester?.name ?? '';
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

  sugestion(String pattern) async {
    BaseSemester baseSemester = BaseSemester(title: pattern.toString());
    await baseSemester.getData();
    return baseSemester.listData;
  }

  valueSelected(value) {
    idSemester = value.id;
  }

  @override
  getJsonObjectRequest() {
    return Department(
        id: pDepartment?.id,
        name: edtController[0].text,
        description: edtController[1].text,
        idSemester: idSemester,
        data: avatar,
        status: isActive.value ? 1 : 0);
  }
}
