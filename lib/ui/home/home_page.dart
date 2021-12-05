import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/core/resource/image_resource.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/ui/home/home_controller.dart';
import 'package:web_lms/ui/list_class/list_class_page.dart';
import 'package:web_lms/ui/list_department/list_department_page.dart';
import 'package:web_lms/ui/list_file_folder/list_file_folder_page.dart';
import 'package:web_lms/ui/list_point/list_point_page.dart';
import 'package:web_lms/ui/list_quiz/list_quiz_controller.dart';
import 'package:web_lms/ui/list_quiz/list_quiz_page.dart';
import 'package:web_lms/ui/list_repo/list_repository_page.dart';
import 'package:web_lms/ui/list_role/list_role_page.dart';
import 'package:web_lms/ui/list_subject/list_subject_page.dart';
import 'package:web_lms/ui/list_user/list_user_page.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class HomePage extends GetWidget<HomeController> {
  final _controller = Get.lazyPut(() => HomeController());
  final double widthDrawer = Get.width / 5;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.visiblePopup.value = false,
      child: Obx(
        () => Scaffold(
          backgroundColor: ColorResource.colorPrimary10,
          drawer: leftView(),
          appBar: AppBar(
            backgroundColor: ColorResource.colorPrimary,
            title: Text(
              controller.title.value,
              style: AppResource.s15b
                  .copyWith(color: ColorResource.white, fontSize: 22),
            ),
            actions: [
              userView(),
            ],
          ),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Obx(() => leftView()),
              Obx(
                () => Visibility(
                  visible: controller.visibleLeftView.value,
                  child: Container(
                    height: Get.height,
                    width: 1,
                    color: ColorResource.grey,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        // userView(),
                        Obx(
                          () => Expanded(child: mainView()),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 50,
                      child: Obx(
                        () => Visibility(
                            visible: controller.visiblePopup.value,
                            child: Container(
                              width: 200,
                              decoration: const BoxDecoration(
                                  color: ColorResource.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorResource.grey,
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Utils.space(0, 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        const Text('Chào '),
                                        Text(
                                          controller.user.value.name ?? '',
                                          style: AppResource.s15r.copyWith(
                                              color:
                                                  ColorResource.colorPrimary),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Utils.space(0, 16),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: ColorResource.colorPrimary,
                                  ),
                                  Utils.space(0, 8),
                                  CustomButton(
                                      onTab: () => controller.logout(),
                                      background: ColorResource.transparent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Đăng xuất',
                                            style: AppResource.s15b,
                                          ),
                                          Icon(Icons.logout)
                                        ],
                                      )),
                                  Utils.space(0, 16),
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftView() {
    return AnimatedBuilder(
      animation: controller.controllerAnimate!,
      builder: (_, child) => Transform.translate(
        offset: Offset(-widthDrawer * controller.controllerAnimate!.value, 0),
        child: child,
      ),
      child: Visibility(
        visible: controller.visibleLeftView.value,
        child: Container(
          width: controller.visibleLeftView.value ? widthDrawer : 0,
          color: ColorResource.white,
          height: Get.height,
          child: Column(
            children: [
              Container(
                height: Get.height / 20,
                width: controller.visibleLeftView.value ? widthDrawer : 0,
                color: ColorResource.colorPrimary,
                alignment: Alignment.center,
                child: Text(
                  "Hệ thống quản trị".toUpperCase(),
                  style: AppResource.s15b
                      .copyWith(fontSize: 20, color: ColorResource.white),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: controller.listItem
                        .mapIndexed((index, element) => Obx(
                              () => Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: ColorResource.grey.withOpacity(0.3),
                                  ),
                                  CustomButton(
                                    onTab: () => controller.pickFeature(index),
                                    width: double.infinity,
                                    height: 50,
                                    background: element.isChoose.value
                                        ? ColorResource.colorPrimary
                                        : ColorResource.transparent,
                                    child: Text(
                                      element.title ?? '',
                                      style: AppResource.s15b.copyWith(
                                          color: element.isChoose.value
                                              ? ColorResource.white
                                              : ColorResource.black),
                                    ),
                                  ),
                                  // Container(width: double.infinity,height: 1,color: ColorResource.grey,)
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainView() {
    Widget view;
    switch (controller.indexView.value) {
      case 0:
        view = ListPointPage();
        // view = ListUserPage();
        break;
      case 1:
        view = ListRepositoryPage();
        break;
      case 2:
        view = ListSemesterPage();
        break;
      case 3:
        view = ListDepartmentPage();
        break;
      case 4:
        view = ListSubjectPage();
        break;
      case 5:
        view = ListClassPage();
        break;
      case 6:
        view = ListFileFolderPage();
        break;
      case 7:
        view = ListQuizPage();
        break;
      case 8:
        view = ListRolePage();
        break;
      case 9:
        view = ListRepositoryPage();
        break;
      default:
        view = Container();
        break;
    }
    return Container(
      child: view,
      padding: const EdgeInsets.all(12),
    );
  }

  Widget userView() {
    return Obx(
      () => Container(
        width: 250,
        height: Get.height / 20,
        decoration: const BoxDecoration(color: ColorResource.colorPrimary),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(
            //     onPressed: () => controller.controlAniMate(),
            //     icon: const Icon(Icons.drag_handle)),
            CustomButton(
              onTab: () => controller.visiblePopup.value =
                  !controller.visiblePopup.value,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorResource.white),
                    child: controller.user.value.avatar != null
                        ? RenderImage.imageNetwork(
                            Utils.concatUrl(controller.user.value.avatar ?? ''))
                        : Utils.space(0, 0),
                  ),
                  Utils.space(16, 0),
                  Text(
                    controller.user.value.name ?? 'Chưa có tên',
                    style:
                        AppResource.s15b.copyWith(color: ColorResource.white),
                  ),
                  Utils.space(8, 0),
                  const Icon(
                    Icons.arrow_drop_down_sharp,
                    color: ColorResource.white,
                  ),
                  Utils.space(16, 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
