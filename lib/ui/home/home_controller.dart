import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  List<ItemDrawer> listItem = [];
  var indexView = 0.obs;

  @override
  initialData() {
    addListItem();
  }

  addListItem() {
    listItem.add(ItemDrawer(0, 'Người dùng', true.obs));
    listItem.add(
        ItemDrawer(1, 'Chức năng ' + listItem.length.toString(), false.obs));
    listItem.add(
        ItemDrawer(2, 'Chức năng ' + listItem.length.toString(), false.obs));
    listItem.add(
        ItemDrawer(3, 'Chức năng ' + listItem.length.toString(), false.obs));
    listItem.add(
        ItemDrawer(4, 'Chức năng ' + listItem.length.toString(), false.obs));
    listItem.add(
        ItemDrawer(5, 'Chức năng ' + listItem.length.toString(), false.obs));
    listItem.add(
        ItemDrawer(6, 'Chức năng ' + listItem.length.toString(), false.obs));
    listItem.add(
        ItemDrawer(7, 'Chức năng ' + listItem.length.toString(), false.obs));
    listItem.add(
        ItemDrawer(8, 'Chức năng ' + listItem.length.toString(), false.obs));
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
}

class ItemDrawer {
  int? id;
  String? title;
  var isChoose = false.obs;

  ItemDrawer(this.id, this.title, this.isChoose);
}
