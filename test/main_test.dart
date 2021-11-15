import 'package:flutter_test/flutter_test.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/core/network/rest_client.dart';
import 'package:web_lms/model/user.dart';

void main() {
  test('TEST API', () async {
    var response = await RestClient(await NetworkUtils.getDioClientToken())
        .login(User(userName: 'admin', password: '123@123a'));
  });
}
