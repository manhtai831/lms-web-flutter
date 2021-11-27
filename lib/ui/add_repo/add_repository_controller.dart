import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base64.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/repository.dart';
import 'package:web_lms/ui/list_repo/list_repository_controller.dart';

class AddRepositoryController extends BaseController {
  Repository? pRepository;
  List<TextEditingController> edtController = [];
  var error = <String?>[].obs;
  var imageCurrent = Rxn();
  var avatar;
  String type = '';

  @override
  initialData() {
    pRepository = Get.arguments;
    for (int i = 0; i < 4; i++) {
      edtController.add(TextEditingController());
      error.add(null);
    }
    edtController[0].text = pRepository?.title ?? '';
    edtController[1].text = pRepository?.content ?? '';
    type = pRepository?.type ?? '';
  }

  pickImage() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      imageCurrent.value = pickedFile.files.first.bytes!;
      avatar = Base64Converter.convertImageToBase64(file: pickedFile);
      // print(pickedFile.files.first);
    }
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (pRepository != null) {
      baseResponse = await client.updateRepository(getJsonObjectRequest());
    } else {
      baseResponse = await client.createRepository(getJsonObjectRequest());
    }

    if (checkError(baseResponse)) {
      Get.back();
      ListRepositoryController listRepositoryController = Get.find();
      listRepositoryController.getData();
      Utils.snackBar(
          message: pRepository != null
              ? 'Cập nhật thành công'
              : 'Thêm repository thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    return Repository(
      id: pRepository?.id,
      title: edtController[0].text,
      content: edtController[1].text,
      data: avatar,
      type: type,
    );
  }

  getValue(value, index) {
    type = value.title;
  }

  request() async {
    int count = 0;
    if (edtController[0].text.trim().isEmpty) {
      error[0] = 'Vui lòng nhập tên repository';
      count++;
    } else {
      error[0] = null;
    }
    if (type.isEmpty) {
      error[2] = 'Vui lòng chọn một thể loại';
      count++;
    } else {
      error[2] = null;
    }

    if (count == 0) {
      await getData();
    }
  }
}
