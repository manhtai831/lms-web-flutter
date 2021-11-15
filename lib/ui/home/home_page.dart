import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/local_service/person_manager.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/ui/home/home_controller.dart';
import 'package:collection/collection.dart';
import 'package:web_lms/ui/list_user/list_user_page.dart';

class HomePage extends GetWidget<HomeController> {
  final _controller = Get.lazyPut(() => HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              children: [
                userView(),
                Obx(
                  () => Expanded(child: mainView()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget leftView() {
    return Container(
      width: 250,
      color: ColorResource.white,
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
          Column(
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
          )
        ],
      ),
    );
  }

  Widget mainView() {
    Widget view;
    if (controller.indexView.value == 0) {
      view = ListUserPage();
    } else
      view = Container();
    return Container(
      child: view,
      // height: Get.height,
      padding: const EdgeInsets.all(12),
    );
  }

  Widget userView() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(color: ColorResource.colorPrimary),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorResource.white),
                ),
                Utils.space(16, 0),
                Text(
                  PersonManager.getInstance().user?.name ?? 'Khách',
                  style: AppResource.s15b.copyWith(color: ColorResource.white),
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
    );
  }
}
