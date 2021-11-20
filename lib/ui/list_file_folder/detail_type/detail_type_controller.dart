import 'dart:collection';

import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/file_folder.dart';

class DetailTypeContorller extends BaseController {
  var dFileFolder = FileFolder().obs;
  FileFolder? pFileFolder;
  ClassModel? classModel;

  int? idClass;
  int? idGroupType;
  var statusEnd = ''.obs;

  @override
  initialData() async {
    idClass = Get.arguments[0];
    idGroupType = Get.arguments[1];
    pFileFolder = Get.arguments[2];
    await super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    Map<String, dynamic> classMap = HashMap();
    classMap['id'] = pFileFolder?.id;
    BaseResponse? baseResponse = await client.getDetailFileFolder(m: classMap);
    if (checkError(baseResponse)) {
      dFileFolder.value = FileFolder.fromJson(baseResponse?.data);
      statusEnd.value = TimeUtils.convertStringToDate(
                  dFileFolder.value.endTime ?? '', TimeUtils.locateDatetime2)
              .isAfter(DateTime.now())
          ? 'Đang diễn ra'
          : 'Đã hết hạn';
    }
  }
}
