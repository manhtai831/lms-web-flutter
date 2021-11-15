import 'package:web_lms/model/user.dart';

class PersonManager {
  static PersonManager? _personManager;
  User? user;

  static PersonManager getInstance() {
    _personManager ??= PersonManager();
    return _personManager!;
  }
}
