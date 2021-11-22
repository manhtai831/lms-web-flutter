import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/answer.dart';
import 'package:web_lms/model/question.dart';
import 'package:web_lms/ui/add_answer/add_answer_page.dart';
import 'package:web_lms/ui/list_quiz/list_quiz_controller.dart';

class AddQuizController extends BaseController {
  Question? pQuestion;
  var listAnswer = <Answer>[].obs;
  TextEditingController edtController = TextEditingController();
  var idMonHoc;

  @override
  initialData() async {
    idMonHoc = Get.arguments[0];
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.createQuestion(getJsonObjectRequest());
    if (checkError(baseResponse)) {
      ListQuizController listQuizController = Get.find();
      listQuizController.getListQuestion();
      Get.back();
      Utils.snackBar(message: 'Thêm câu hỏi thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    var id;
    listAnswer.asMap().forEach((index, element) {
      if (element.isDapAnDung.value) {
        id = index;
      }
    });
    return Question(
      listCauTraLoiObject: listAnswer,
      idDapAp: id,
      content: edtController.text,
      idMonHoc: idMonHoc,
    );
  }

  addAnswer() async {
    var result = await Get.dialog(AddAnswerPage(), barrierDismissible: false);
    if (result != null) {
      listAnswer.add(result);
    }
  }

  deleteAnswer(int i) {
    listAnswer.removeAt(i);
  }

  pickAnswerCorrect(Answer element) {
    listAnswer.forEach((element) {
      element.isDapAnDung.value = false;
    });
    element.isDapAnDung.value = true;
  }
}