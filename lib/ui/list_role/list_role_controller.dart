import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/group_role.dart';
import 'package:get/get.dart';
import 'package:web_lms/model/role.dart';

class ListRoleController extends BaseController {
  var listGroup = <GroupRole>[].obs;
  var listRole = <Role>[].obs;
  TextEditingController edtNameGroup = TextEditingController();
  TextEditingController edtDescriptionGroup = TextEditingController();
  var visibleBody = true.obs;
  var visibleHeader = true.obs;
  var isFullRole = false.obs;

  @override
  initialData() async {
    await super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    await getGroupRole();
  }

  getGroupRole() async {
    BaseResponse? baseResponse = await client.getListGroup();
    if (checkError(baseResponse)) {
      listGroup.clear();
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      for (int i = 0; i < basePageResponse.data!.length; i++) {
        GroupRole gr = GroupRole.fromJson(basePageResponse.data![i]);
        if (i == 0) {
          gr.isChoose.value = true;
          listGroup.add(gr);
        } else {
          gr.isChoose.value = false;
          listGroup.add(gr);
        }
      }
      await getRole();
      if (listGroup.isNotEmpty) {
        edtNameGroup.text = listGroup[0].name ?? '';
        edtDescriptionGroup.text = listGroup[0].description ?? '';
        int count = 0;
        listGroup[0].roles?.forEach((element) {
          listRole.forEach((element1) {
            if (element == element1.id) {
              element1.isChoose.value = true;
              count++;
            }
          });
        });
        if (count == listRole.length) {
          isFullRole.value = true;
        } else {
          isFullRole.value = false;
        }
      }
    }
  }

  getRole({List<int>? list}) async {
    BaseResponse? baseResponse = await client.getListRole(l: list);
    if (checkError(baseResponse)) {
      listRole.clear();
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listRole.add(Role.fromJson(element));
      });
    }
  }

  showRole(GroupRole element) async {
    visibleBody.value = true;
    visibleHeader.value = true;
    int count = 0;

    for (int i = 0; i < listGroup.length; i++) {
      listGroup[i].isChoose.value = false;
    }
    element.isChoose.value = true;
    edtNameGroup.text = element.name ?? '';
    edtDescriptionGroup.text = element.description ?? '';
    listRole.forEach((element1) {
      element1.isChoose.value = false;
    });
    element.roles!.forEach((element) {
      listRole.forEach((element1) {
        if (element == element1.id) {
          element1.isChoose.value = true;
          count++;
        }
      });
    });
    if (count == listRole.length) {
      isFullRole.value = true;
    } else {
      isFullRole.value = false;
    }
  }

  chooseRole(Role element) {
    element.isChoose.value = !element.isChoose.value;
  }

  delete() {
    listGroup.forEach((element) {
      if (element.isChoose.isTrue) {
        Get.dialog(ConfirmDialog(
          message:
              'Bạn có chắc chắn nhóm quyền \"${element.name}\" không tồn tại',
          onConfirm: () => deleteGroup(element),
        ));
      }
    });
  }

  deleteGroup(GroupRole role) async {
    BaseResponse? baseResponse =
        await client.deleteGroup(GroupRole(id: role.id));
    if (checkError(baseResponse)) {
      Get.back();
      getData();
      Utils.snackBar(message: 'Xóa nhóm quyền thành công');
    }
  }

  addGroup() {
    listGroup.forEach((element) {
      element.isChoose.value = false;
    });
    edtDescriptionGroup.text = '';
    edtNameGroup.text = '';
    visibleBody.value = false;
    visibleHeader.value = false;
  }

  updateAndAdd() async {
    GroupRole? group;
    listGroup.forEach((element) {
      if (element.isChoose.value) group = element;
    });
    List<int> roles = [];
    if (group != null) {
      listRole.forEach((element) {
        if (element.isChoose.value) {
          roles.add(element.id ?? -1);
        }
      });
    }

    BaseResponse? baseResponse;
    GroupRole request = GroupRole(
        id: group?.id,
        name: edtNameGroup.text,
        description: edtDescriptionGroup.text,
        roles: roles);
    if (group != null) {
      baseResponse = await client.updateGroup(request);
    } else {
      baseResponse = await client.createGroup(request);
    }

    if (checkError(baseResponse)) {
      getData();
      Utils.snackBar(
          message: group != null
              ? 'Cập nhật nhóm quyền thành công'
              : 'Thêm nhóm quyền thành công');
    }
  }

  pickFullRole() {
    isFullRole.value = !isFullRole.value;
    listRole.forEach((element) {
      element.isChoose.value = isFullRole.value;
    });
  }
}
