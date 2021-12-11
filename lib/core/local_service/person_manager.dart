import 'package:web_lms/core/role_map.dart';
import 'package:web_lms/model/user.dart';

class PersonManager {
  static PersonManager? _personManager;
  User? user;

  static PersonManager getInstance() {
    _personManager ??= PersonManager();
    return _personManager!;
  }

  bool hasRole(String key) {
    bool isRole = false;
    if (user != null) {
      user?.permission?.forEach((element) {
        if (roles[key] == element.id) {
          isRole = true;
        }
      });
    }
    return isRole;
  }
}
