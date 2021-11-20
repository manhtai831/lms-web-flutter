import 'dart:collection';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/status.dart';
import 'package:web_lms/core/utils.dart';

import 'network/rest_client.dart';
import 'network/network_utils.dart';

class BaseController extends GetxController {
  RefreshController? smartController;
  Rx<Status> status = Status.loading.obs;
  int pageIndex = 1;
  bool isRefreshing = false;
  bool endPoint = false;
  final int pageSize = 10;
  late RestClient client;
  late Map<String, dynamic> map;

  @override
  Future<void> onInit() async {
    super.onInit();
    smartController ??= RefreshController(initialRefresh: false);
    await initialData();
  }

  refreshData() async {
    isRefreshing = true;
    pageIndex = 1;

    endPoint = false;
    await getData();
    refreshed();
  }

  loadMoreData() async {
    if (endPoint) {
      isRefreshing = false;
      pageIndex++;
      await getData();
      smartController!.loadComplete();
    } else {
      smartController!.loadNoData();
    }
  }

  initialData() async {
    setStatus(Status.loading);
    await getData();
  }

  getDataSuccessFromAPI() {}

  getJsonObjectRequest() {}

  getParameters() {
    map = HashMap<String, dynamic>();
  }

  getData() async {
    // bool check = await NetworkUtils.hasConnection();

    if (true) {
      client = await NetworkUtils.getClientInstance();
      await getDataSuccessFromAPI();
      try {} catch (onError) {
        catchError(onError);
      }
    } else {
      setStatus(Status.fail);
    }
  }

  catchError(Object onError) async {
    switch (onError.runtimeType) {
      case DioError:
        final res = (onError as DioError).response;
        try {
          if (res?.statusCode != null) {
            log('---->>>>>>>>>>>>>>>>>>>>>>>' + res!.statusCode.toString());
          }
          // Utils.showToast('${res!.statusCode}\n${res.statusMessage}');
        } catch (e) {}

        if (res?.statusCode == 401) {
          ///refresh token
        } else if (res?.statusCode == 500) {
          setStatus(Status.success);
          Utils.snackBar(message: 'Đã có lỗi xảy ra');
        } else if (res?.statusCode == 403) {
          setStatus(Status.success);
        } else {
          Utils.snackBar(message: 'Time out connection');
          setStatus(Status.fail);
        }
        break;
      default:
    }
  }

  Future<void> handleDelay(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  void setStatus(Status s) {
    status.value = s;
  }

  void setEndPoint(bool condition) {
    endPoint = condition;
  }

  void refreshed() {
    if (smartController != null) {
      smartController!.resetNoData();
      smartController!.refreshCompleted();
    }
  }

  @override
  void onClose() {
    if (smartController != null) smartController = null;
    super.onClose();
  }

  bool checkError(BaseResponse? response) {
    if (response != null) {
      if (response.error?.code == 0) {
        return true;
      } else {
        Utils.snackBar(title: response.error?.message ?? '');
        return false;
      }
    } else {
      Utils.snackBar(title: 'Đã có lỗi xảy ra');
      return false;
    }
  }
}
