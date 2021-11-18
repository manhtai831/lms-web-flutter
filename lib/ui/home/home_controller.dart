import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/local_service/shared_pref.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/core/resource/string_resource.dart';
import 'package:web_lms/model/user.dart';
import 'package:web_lms/ui/login/login_page.dart';

class HomeController extends BaseController {
  List<ItemDrawer> listItem = [];
  var indexView = 0.obs;
  var visiblePopup = false.obs;
  var user = User().obs;

  @override
  initialData() async {
    addListItem();
    await getData();
  }

  addListItem() {
    listItem.add(ItemDrawer(0, 'Người dùng', true.obs));
    listItem.add(ItemDrawer(1, 'Repository', false.obs));
    listItem.add(ItemDrawer(2, 'Học kì', false.obs));
    listItem.add(ItemDrawer(3, 'Khối ngành', false.obs));
    listItem.add(ItemDrawer(4, 'Môn học', false.obs));
    listItem.add(ItemDrawer(5, 'Lớp học', false.obs));
    listItem.add(ItemDrawer(6, 'Danh mục', false.obs));
    listItem.add(ItemDrawer(7, 'Nhóm danh mục', false.obs));
    listItem.add(ItemDrawer(8, 'Cấu hình quyền', false.obs));
  }

  pickFeature(int index) {
    Future.delayed(const Duration(milliseconds: 150), () {
      for (int i = 0; i < listItem.length; i++) {
        listItem[i].isChoose.value = false;
      }
      listItem[index].isChoose.value = true;
      indexView.value = index;
    });
  }

  logout() {
    visiblePopup.value = false;
    SharedPref.clear();
    StringResource.token = '';
    Get.offAll(() => LoginPage());
  }

  @override
  getDataSuccessFromAPI() async {
    client = await NetworkUtils.getClientInstance();
    BaseResponse? baseResponse = await client.getInfoUser();
    if (checkError(baseResponse)) {
      user.value = User.fromJson(baseResponse?.data);
    }
  }
}

class ItemDrawer {
  int? id;
  String? title;
  var isChoose = false.obs;

  ItemDrawer(this.id, this.title, this.isChoose);
}
