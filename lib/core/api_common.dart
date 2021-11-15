import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/user.dart';

class BaseDeleteUser extends BaseController {
  int? id;

  BaseDeleteUser({this.id});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.deleteUser(getJsonObjectRequest());
    if (checkError(baseResponse)) {
      Utils.snackBar(message: 'Đã xóa người dùng');
    }
  }

  @override
  getJsonObjectRequest() {
    // TODO: implement getJsonObjectRequest
    return User(id: id);
  }
}

class BaseResetPassword extends BaseController {
  int? id;

  BaseResetPassword({this.id});

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.resetPassword(getJsonObjectRequest());
    if (checkError(baseResponse)) {
      Utils.snackBar(message: 'Reset password thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    // TODO: implement getJsonObjectRequest
    return User(id: id);
  }
}
