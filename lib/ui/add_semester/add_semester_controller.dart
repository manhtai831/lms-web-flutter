import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/date_time/date_time_utils.dart';
import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/repository.dart';
import 'package:web_lms/model/semester.dart';
import 'package:web_lms/ui/semester/list_semester_controller.dart';

class AddSemesterController extends BaseController {
  var isActive = false.obs;
  Semester? pSemester;
  List<TextEditingController> edtController = [];
  int? idRepo;

  @override
  initialData() {
    pSemester = Get.arguments;
    for (int i = 0; i < 8; i++) {
      edtController.add(TextEditingController());
    }

    edtController[0].text = pSemester?.name ?? '';
    edtController[1].text = pSemester?.description ?? '';
    edtController[2].text = pSemester?.startTime ?? '';
    edtController[3].text = pSemester?.endTime ?? '';
    edtController[4].text = pSemester?.repository?.title ?? '';
    if (pSemester?.status == 0) {
      isActive.value = false;
    } else if (pSemester?.status == 1) {
      isActive.value = true;
    }
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (pSemester != null) {
      baseResponse = await client.updateSemester(getJsonObjectRequest());
    } else {
      baseResponse = await client.createSemester(getJsonObjectRequest());
    }

    if (checkError(baseResponse)) {
      Get.back();
      ListSemesterController listRepositoryController = Get.find();
      listRepositoryController.getData();
      Utils.snackBar(
          message: pSemester != null
              ? 'Cập nhật thành công'
              : 'Thêm repository thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    return Semester(
      id: pSemester?.id,
      name: edtController[0].text,
      description: edtController[1].text,
      status: isActive.value ? 1 : 0,
      startTime: '${edtController[2].text} 00:00:00',
      endTime: '${edtController[3].text} 00:00:00',
      idRepository: idRepo,
    );
  }

  datePicker(int i) async {
    DateTime? date = await DateTimeUtils.showDatePickerDialog(Get.context!);
    if (date != null) {
      edtController[i].text =
          TimeUtils.convertDateTimeToFormat(date, TimeUtils.dateFormat);
    }
  }

  valueSelected(value) {
    idRepo = value.id;
  }

  sugestion(pattern) async {
    BaseRepository baseRepository = BaseRepository(title: pattern.toString());
    await baseRepository.getData();
    return baseRepository.listData;
  }
}
