import 'package:web_lms/core/dialog_confirm.dart';
import 'package:web_lms/core/dropdown/dropdown_custom.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/model/base_item.dart';
import 'package:web_lms/ui/add_file_folder/add_file_folder_page.dart';
import 'package:web_lms/ui/list_file_folder/list_file_folder_controller.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class ListFileFolderPage extends GetWidget<ListFileFolderController> {
  final _controller = Get.lazyPut(() => ListFileFolderController());

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: ColorResource.grey,
              blurRadius: 3,
            )
          ], color: ColorResource.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Danh mục',
                style: AppResource.s15b
                    .copyWith(fontSize: 23, color: ColorResource.colorPrimary),
              ),
              Flexible(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
        ),
        Utils.space(0, 16),
        Expanded(
          child: Obx(
            () => Row(
              children: [
                view1(),
                Visibility(
                    visible: controller.visibleView[1],
                    child: Utils.space(16, 0)),
                Visibility(
                  visible: controller.visibleView[1],
                  child: view2(),
                ),
                Visibility(
                    visible: controller.visibleView[2],
                    child: Utils.space(16, 0)),
                Visibility(
                  visible: controller.visibleView[2],
                  child: view3(),
                ),
                Visibility(
                    visible: controller.visibleView[3],
                    child: Utils.space(16, 0)),
                Visibility(
                  visible: controller.visibleView[3],
                  child: view4(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget view1() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: ColorResource.grey,
            blurRadius: 3,
          )
        ], color: ColorResource.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              controller: controller.tabController,
              indicatorColor: ColorResource.colorPrimary,
              unselectedLabelColor: ColorResource.grey,
              labelStyle:
                  AppResource.s15b.copyWith(color: ColorResource.colorPrimary),
              labelColor: ColorResource.white,
              indicator: BoxDecoration(color: ColorResource.colorPrimary),
              tabs: const [
                Tab(text: 'Lớp học'),
                Tab(text: 'Môn học'),
              ],
            ),
            Utils.space(0, 12),
            Container(
              width: double.infinity,
              height: 2,
              color: ColorResource.colorPrimary,
            ),
            Utils.space(0, 12),
            Expanded(
              child:
                  TabBarView(controller: controller.tabController, children: [
                tabClass(controller.listClass),
                tabClass(controller.listSubject),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget view2() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: ColorResource.grey,
            blurRadius: 3,
          )
        ], color: ColorResource.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nhóm danh mục',
              style: AppResource.s15b.copyWith(fontSize: 18),
            ),
            Utils.space(0, 12),
            Container(
              width: double.infinity,
              height: 2,
              color: ColorResource.colorPrimary,
            ),
            Utils.space(0, 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  background: ColorResource.grey,
                  width: 180,
                  title: 'Xóa nhóm danh mục',
                  // onTab: () => controller.addGroup(),
                ),
                Utils.space(12, 12),
                CustomButton(
                  width: 200,
                  title: 'Thêm nhóm danh mục',
                  // onTab: () => controller.addGroup(),
                ),
              ],
            ),
            Utils.space(0, 12),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: controller.listFileFolder
                        .mapIndexed(
                          (index, element) => Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: ColorResource.grey.withOpacity(0.3),
                              ),
                              CustomButton(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                // background: element.isChoose.value
                                //     ? ColorResource.colorPrimary
                                //     : ColorResource.white,
                                // onTab: () => controller.showRole(element),
                                child: Text(
                                  element.name ?? '',
                                  // style: AppResource.s15r.copyWith(
                                  //     color: element.isChoose.value
                                  //         ? ColorResource.white
                                  //         : ColorResource.black),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget view3() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: ColorResource.grey,
            blurRadius: 3,
          )
        ], color: ColorResource.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Danh mục',
              style: AppResource.s15b.copyWith(fontSize: 18),
            ),
            Utils.space(0, 12),
            Container(
              width: double.infinity,
              height: 2,
              color: ColorResource.colorPrimary,
            ),
            Utils.space(0, 12),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                width: 200,
                title: 'Thêm nhóm danh mục',
                // onTab: () => controller.addGroup(),
              ),
            ),
            Utils.space(0, 12),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: controller.listFileFolder
                        .mapIndexed(
                          (index, element) => Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: ColorResource.grey.withOpacity(0.3),
                              ),
                              CustomButton(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                // background: element.isChoose.value
                                //     ? ColorResource.colorPrimary
                                //     : ColorResource.white,
                                // onTab: () => controller.showRole(element),
                                child: Text(
                                  element.name ?? '',
                                  // style: AppResource.s15r.copyWith(
                                  //     color: element.isChoose.value
                                  //         ? ColorResource.white
                                  //         : ColorResource.black),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget view4() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: ColorResource.grey,
            blurRadius: 3,
          )
        ], color: ColorResource.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'File',
              style: AppResource.s15b.copyWith(fontSize: 18),
            ),
            Utils.space(0, 12),
            Container(
              width: double.infinity,
              height: 2,
              color: ColorResource.colorPrimary,
            ),
            Utils.space(0, 12),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                width: 200,
                title: 'Thêm nhóm danh mục',
                // onTab: () => controller.addGroup(),
              ),
            ),
            Utils.space(0, 12),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: controller.listFileFolder
                        .mapIndexed(
                          (index, element) => Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: ColorResource.grey.withOpacity(0.3),
                              ),
                              CustomButton(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                // background: element.isChoose.value
                                //     ? ColorResource.colorPrimary
                                //     : ColorResource.white,
                                // onTab: () => controller.showRole(element),
                                child: Text(
                                  element.name ?? '',
                                  // style: AppResource.s15r.copyWith(
                                  //     color: element.isChoose.value
                                  //         ? ColorResource.white
                                  //         : ColorResource.black),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabClass(List list) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: list
              .mapIndexed(
                (index, element) => Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: ColorResource.grey.withOpacity(0.3),
                    ),
                    CustomButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      background: element.isChoose.value
                          ? ColorResource.colorPrimary
                          : ColorResource.white,
                      onTab: () => controller.pickView1(element),
                      child: Text(
                        element.name ?? '',
                        style: AppResource.s15r.copyWith(
                            color: element.isChoose.value
                                ? ColorResource.white
                                : ColorResource.black),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
