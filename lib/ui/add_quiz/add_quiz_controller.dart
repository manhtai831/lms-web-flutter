import 'package:get/get.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
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
    pQuestion = Get.arguments[1];
    edtController.text = pQuestion?.content ?? '';
    listAnswer.value = pQuestion?.listCauTraLoiObject ?? [];
    listAnswer.forEach((element) {
      if (element.id == pQuestion?.idDapAp) {
        element.isDapAnDung.value = true;
      }
    });
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (pQuestion != null) {
      baseResponse = await client.updateQuestion(getJsonObjectRequest());
    } else {
      baseResponse = await client.createQuestion(getJsonObjectRequest());
    }

    if (checkError(baseResponse)) {
      ListQuizController listQuizController = Get.find();
      listQuizController.getListQuestion();
      Get.back();
      Utils.snackBar(
          message: pQuestion != null
              ? 'Cập nhật câu hỏi thành công'
              : 'Thêm câu hỏi thành công');
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
      id: pQuestion?.id,
      listCauTraLoiObject: listAnswer,
      idDapAp: id,
      content: edtController.text,
      idMonHoc: idMonHoc,
    );
  }

  addAnswer() async {
    var result = await Get.dialog(AddAnswerPage(),
        arguments: pQuestion, barrierDismissible: false);
    BaseAnswer baseAnswer = BaseAnswer(idCauHoi: pQuestion?.id);
    await baseAnswer.getData();
    int idChooseAnswer = -1;
    listAnswer.forEach((element) {
      if (element.isDapAnDung.isTrue) {
        idChooseAnswer = element.id ?? -1;
      }
    });
    listAnswer.value = baseAnswer.listData;
    listAnswer.forEach((element) {
      if (element.id == idChooseAnswer) {
        element.isDapAnDung.value = true;
      }
    });
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

  updateAnswer(Answer element) async {
    await Get.dialog(AddAnswerPage(),
        arguments: element, barrierDismissible: false);
    BaseAnswer baseAnswer = BaseAnswer(idCauHoi: element.idCauHoi);
    await baseAnswer.getData();
    int idChooseAnswer = -1;
    listAnswer.forEach((element) {
      if (element.isDapAnDung.isTrue) {
        idChooseAnswer = element.id ?? -1;
      }
    });
    listAnswer.value = baseAnswer.listData;
    listAnswer.forEach((element) {
      if (element.id == idChooseAnswer) {
        element.isDapAnDung.value = true;
      }
    });
  }
}
