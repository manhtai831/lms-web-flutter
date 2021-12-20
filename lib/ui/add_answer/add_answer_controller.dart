import 'package:get/get.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/answer.dart';
import 'package:web_lms/model/question.dart';

class AddAnswerController extends BaseController {
  Answer? mAnswer;
  Question? mQuestion;
  TextEditingController edtController = TextEditingController();

  @override
  initialData() async {
    if (Get.arguments is Answer) {
      mAnswer = Get.arguments;
    } else if (Get.arguments is Question) {
      mQuestion = Get.arguments;
    }
    edtController.text = mAnswer?.content ?? '';
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (mAnswer != null) {
      baseResponse = await client.updateAnswer(getJsonObjectRequest());
    } else {
      baseResponse = await client.createAnswer(getJsonObjectRequest());
    }
    if (checkError(baseResponse)) {
      Get.back();
      Utils.snackBar(
          message: mAnswer != null
              ? 'Cập nhật câu trả lời thành công'
              : 'Thêm câu trả lời thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    return Answer(
        id: mAnswer?.id,
        idCauHoi: mAnswer?.idCauHoi ?? mQuestion?.id,
        content: edtController.text);
  }
}
