import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/department.dart';

class ListDepartController extends BaseController {
  TextEditingController edtController = TextEditingController();
  var listDepartment = <Department>[].obs;

  @override
  initialData() {
    return super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getListDepartment();
    if (checkError(baseResponse)) {
      listDepartment.clear();
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listDepartment.add(Department.fromJson(element));
      });
    }
  }

  deleteSemester(int i) async {
    BaseResponse? baseResponse =
        await client.deleteDepartment(Department(id: i));
    if (checkError(baseResponse)) {
      getData();
      Get.back();
      Utils.snackBar(message: 'Xóa kì học thành công');
    }
  }
}
