import 'dart:convert';

import 'package:ceehacks/model/user_types.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Functions {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> changeUserType(String uid, UserType userType) async {
    await _functions.httpsCallable('userChangeType').call({
      'type': userType.value,
    });
  }

  Future<String> getDoctorId(String name, String surname) async {
    var resp = await _functions.httpsCallable('doctorVerify').call({
      'jmeno': name,
      'prijmeni': surname,
    });
    return resp.data.toString().trim();
  }

  Future<List<dynamic>> getDrugs(String name) async {
    var resp = await _functions.httpsCallable('drugSearch').call({
      'name': name,
    });

    return json.decode(resp.data);
  }
}
