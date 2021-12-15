import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/ui/list_file_folder/add_a_type/add_a_type_page.dart';
import 'package:web_lms/ui/list_file_folder/add_group_type/add_group_type_page.dart';
import 'package:web_lms/ui/list_file_folder/list_file_folder_controller.dart';

import 'add_file_system/add_file_system_page.dart';
import 'detail_file_upload/file_student_page.dart';
import 'detail_type/detail_type_page.dart';

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
        child: controller.visibleView[5]
            ? Column(
                children: [
                  Text(
                    'File hệ thống',
                    style: AppResource.s15b.copyWith(fontSize: 18),
                  ),
                  Utils.space(0, 12),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: ColorResource.colorPrimary,
                  ),
                  Utils.space(0, 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          child: CustomButton(
                            background: ColorResource.grey,
                            width: 180,
                            title: 'Xóa file',
                            onTab: () => controller.deleteType_FileSys(),
                          ),
                        ),
                        Utils.space(12, 12),
                        CustomButton(
                          width: 200,
                          title: 'Thêm file',
                          onTab: () => controller.addType_FileSys(isOnly: true),
                        ),
                      ],
                    ),
                  ),
                  Utils.space(0, 12),
                  Expanded(
                    child: tabGroupCategory(controller.listFileSystem,
                        isFile: true),
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    controller: controller.tabController1,
                    indicatorColor: ColorResource.colorPrimary,
                    unselectedLabelColor: ColorResource.grey,
                    labelStyle: AppResource.s15b
                        .copyWith(color: ColorResource.colorPrimary),
                    labelColor: ColorResource.white,
                    indicator:
                        const BoxDecoration(color: ColorResource.colorPrimary),
                    tabs: const [
                      Tab(text: 'Nhóm danh mục'),
                      Tab(text: 'File hệ thống'),
                    ],
                  ),
                  Utils.space(0, 12),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: ColorResource.colorPrimary,
                  ),
                  Utils.space(0, 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: PersonManager.getInstance()
                              .hasRole(KeyRole.xoa_nhom_danh_muc),
                          child: CustomButton(
                            background: ColorResource.grey,
                            width: 180,
                            title: controller.deleteFile_GroupType.value,
                            onTab: () => controller.deleteType_FileSys(),
                          ),
                        ),
                        Utils.space(12, 12),
                        Visibility(
                          visible: PersonManager.getInstance()
                              .hasRole(KeyRole.them_nhom_danh_muc),
                          child: CustomButton(
                            width: 200,
                            title: controller.addFile_GroupType.value,
                            onTab: () => controller.addType_FileSys(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Utils.space(0, 12),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController1,
                      children: [
                        tabGroupCategory(controller.listGroupType),
                        tabGroupCategory(controller.listFileSystem,
                            isFile: true),
                      ],
                    ),
                  )
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: PersonManager.getInstance()
                        .hasRole(KeyRole.xoa_danh_muc),
                    child: CustomButton(
                      background: ColorResource.grey,
                      width: 150,
                      title: 'Xóa danh mục',
                      onTab: () => controller.deleteFileFolder(),
                    ),
                  ),
                  Utils.space(12, 12),
                  Visibility(
                    visible: PersonManager.getInstance()
                        .hasRole(KeyRole.them_danh_muc),
                    child: CustomButton(
                      width: 170,
                      title: 'Thêm danh mục',
                      onTab: () => controller.addFileFolder(),
                    ),
                  ),
                ],
              ),
            ),
            Utils.space(0, 12),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: controller.listType
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
                                    vertical: 0, horizontal: 0),
                                background: element.isChoose.value
                                    ? ColorResource.colorPrimary
                                    : ColorResource.white,
                                onTab: () => controller.pickView3(element),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 12),
                                        child: Text(
                                          element.name ?? '',
                                          style: AppResource.s15r.copyWith(
                                              color: element.isChoose.value
                                                  ? ColorResource.white
                                                  : ColorResource.black),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Visibility(
                                        visible: element.isChoose.value,
                                        child: InkWell(
                                          onTap: () => Get.dialog(
                                              AddATypePage(),
                                              barrierDismissible: false,
                                              arguments: [
                                                controller.idClass,
                                                controller.idGroupType,
                                                element,
                                                controller.idSubjectForQuiz,
                                                controller.idType
                                              ]),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Icon(Icons.update),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Visibility(
                                        visible: element.isChoose.value,
                                        child: InkWell(
                                          onTap: () => Get.dialog(
                                              DetailTypePage(),
                                              barrierDismissible: false,
                                              arguments: [
                                                controller.idClass,
                                                controller.idGroupType,
                                                element
                                              ]),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Icon(Icons.details),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                background: ColorResource.grey,
                width: 120,
                title: 'Xóa file',
                onTab: () => controller.deleteFile(),
              ),
            ),
            Utils.space(0, 12),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: controller.listFileStudent
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
                                    vertical: 0, horizontal: 0),
                                background: element.isChoose.value
                                    ? ColorResource.colorPrimary
                                    : ColorResource.white,
                                onTab: () => controller.pickView4(element),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 12),
                                        child: Text(
                                          element.name ?? '',
                                          style: AppResource.s15r.copyWith(
                                              color: element.isChoose.value
                                                  ? ColorResource.white
                                                  : ColorResource.black),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Visibility(
                                        visible: element.isChoose.value,
                                        child: InkWell(
                                          onTap: () => Get.dialog(
                                              DetailFileStudentPage(),
                                              barrierDismissible: false,
                                              arguments: [
                                                controller.idClass,
                                                controller.idType,
                                                element
                                              ]),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Icon(Icons.details),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Visibility(
                                        visible: element.isChoose.value,
                                        child: InkWell(
                                          onTap: () => Utils.launchInBrowser(
                                              Utils.concatUrl(
                                                  element.link ?? '')),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Icon(Icons.forward),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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

  Widget tabGroupCategory(List listClass, {bool? isFile}) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: listClass
              .mapIndexed(
                (index, element) => Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: ColorResource.grey.withOpacity(0.3),
                    ),
                    CustomButton(
                      padding: EdgeInsets.all(
                          (isFile ?? false || element.isChoose.value) ? 0 : 16),
                      background: element.isChoose.value
                          ? ColorResource.colorPrimary
                          : ColorResource.white,
                      onTab: () => controller.pickView2(element),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                element.name ?? '',
                                style: AppResource.s15r.copyWith(
                                    color: element.isChoose.value
                                        ? ColorResource.white
                                        : ColorResource.black),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: element.isChoose.value,
                            child: Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (controller.tabController1!.length > 0) {
                                    if (controller.tabController1!.index == 0 &&
                                        PersonManager.getInstance().hasRole(
                                            KeyRole.cap_nhat_nhom_danh_muc)) {
                                      Get.dialog(AddGroupTypePage(),
                                          arguments: [
                                            controller.idClass,
                                            element
                                          ],
                                          barrierDismissible: false);
                                    }
                                    if (controller.tabController1!.index == 1) {
                                      Get.dialog(AddFileSystemPage(),
                                          barrierDismissible: false,
                                          arguments: [
                                            controller.idClass,
                                            element
                                          ]);
                                    }
                                  } else {
                                    Get.dialog(AddFileSystemPage(),
                                        barrierDismissible: false,
                                        arguments: [
                                          controller.idSubject,
                                          element
                                        ]);
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Icon(
                                    Icons.update,
                                    color: element.isChoose.value
                                        ? ColorResource.white
                                        : ColorResource.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isFile ?? false,
                            child: Expanded(
                              child: InkWell(
                                onTap: () => Utils.launchInBrowser(
                                    Utils.concatUrl(element.linkFile)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Icon(
                                    Icons.forward,
                                    color: element.isChoose.value
                                        ? ColorResource.white
                                        : ColorResource.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
