class UserData {
  String type;

  UserData.fromMap(Map<dynamic, dynamic> data) {
    type = data["type"];
  }
}
