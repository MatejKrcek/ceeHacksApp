import 'package:ceehacks/model/user_types.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Functions {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> changeUserType(String uid, UserType userType) async {
    await _functions.httpsCallable('userChangeType').call({
      'type': userType.value,
    });
  }
}
