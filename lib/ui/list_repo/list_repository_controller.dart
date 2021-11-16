import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/model/repository.dart';
import 'package:get/get.dart';

class ListRepositoryController extends BaseController {
  var listRepository = <Repository>[].obs;
  TextEditingController edtController = TextEditingController();
  @override
  initialData() {
    return super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getListRepository();
    if (checkError(baseResponse)) {
      listRepository.clear();
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listRepository.add(Repository.fromJson(element));
      });
    }
  }

  deleteRepository(int i) async {
    BaseResponse? baseResponse =
        await client.deleteRepository(Repository(id: i));
    if (checkError(baseResponse)) {
      await getData();
    }
  }

  search() async {
    BaseRepository baseSemester =
        BaseRepository(title: edtController.text.trim());
    await baseSemester.getData();
    listRepository.clear();
    listRepository.value = baseSemester.listData!;
  }
}
