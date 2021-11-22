import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/model/answer.dart';

class AddAnswerController extends BaseController {
  Answer? mAnswer;
  TextEditingController edtController = TextEditingController();

  @override
  initialData() async {

  }

  @override
  getDataSuccessFromAPI() async {
    Answer answer = Answer(content:edtController.text);
    Get.back(result: answer);
  }
}
