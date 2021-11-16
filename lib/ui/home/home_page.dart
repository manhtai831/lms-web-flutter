import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/core/resource/string_resource.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/ui/home/home_controller.dart';
import 'package:web_lms/ui/list_department/list_department_page.dart';
import 'package:web_lms/ui/list_repo/list_repository_page.dart';
import 'package:web_lms/ui/list_user/list_user_page.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class HomePage extends GetWidget<HomeController> {
  final _controller = Get.lazyPut(() => HomeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.visiblePopup.value = false,
      child: Scaffold(
        backgroundColor: ColorResource.colorPrimary10,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leftView(),
            Container(
              height: Get.height,
              width: 1,
              color: ColorResource.grey,
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      userView(),
                      Obx(
                        () => Expanded(child: mainView()),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 30,
                    right: 20,
                    child: Obx(
                      () => Visibility(
                          visible: controller.visiblePopup.value,
                          child: Container(
                            width: 200,
                            decoration: const BoxDecoration(
                                color: ColorResource.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: ColorResource.grey, blurRadius: 5)
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
                                            color: ColorResource.colorPrimary),
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
                                  child: Text(
                                    'Đăng xuất',
                                    style: AppResource.s15b,
                                  ),
                                ),
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
    );
  }

  Widget leftView() {
    return Container(
      width: 250,
      color: ColorResource.white,
      height: Get.height,
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            color: ColorResource.colorPrimary,
            alignment: Alignment.center,
            child: Text(
              "LMS",
              style: AppResource.s15b
                  .copyWith(fontSize: 32, color: ColorResource.white),
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
          )
        ],
      ),
    );
  }

  Widget mainView() {
    Widget view;
    if (controller.indexView.value == 0) {
      view = ListUserPage();
    } else if (controller.indexView.value == 1) {
      view = ListRepositoryPage();
    } else if (controller.indexView.value == 2) {
      view = ListSemesterPage();
    } else if (controller.indexView.value == 3) {
      view = ListDepartmentPage();
    } else if (controller.indexView.value == 4) {
      view = ListDepartmentPage();
    } else
      view = Container();
    return Container(
      child: view,
      // height: Get.height,
      padding: const EdgeInsets.all(12),
    );
  }

  Widget userView() {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(color: ColorResource.colorPrimary),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                            Utils.concatUrl(StringResource.avatar))
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
