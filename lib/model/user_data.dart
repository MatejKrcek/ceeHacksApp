import 'package:ceehacks/model/user_types.dart';

class UserData {
  UserType type;

  UserData.fromMap(Map<dynamic, dynamic> data) {
    type = UserTypeHelper.fromString(data["type"]);
  }
}
