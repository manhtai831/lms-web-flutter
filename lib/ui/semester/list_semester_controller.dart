import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/semester.dart';
import 'package:get/get.dart';

class ListSemesterController extends BaseController {
  var listSemester = <Semester>[].obs;
  TextEditingController edtController = TextEditingController();

  @override
  initialData() {
    return super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getListSemester();
    if (checkError(baseResponse)) {
      listSemester.clear();
      BasePageResponse basePageResponse =
      BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listSemester.add(Semester.fromJson(element));
      });
    }
  }

  deleteSemester(int i) async {
    BaseResponse? baseResponse = await client.deleteSemester(Semester(id: i));
    if (checkError(baseResponse)) {
      Utils.snackBar(message: 'Xóa thành công');
      await getData();
    }
  }

  search() async {
    BaseSemester baseSemester = BaseSemester(title: edtController.text.trim());
    await baseSemester.getData();
    listSemester.clear();
    listSemester.value = baseSemester.listData!;
  }
}
