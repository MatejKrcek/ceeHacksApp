class UserData {
  String name;
  String photo;
  String email;
  String type;

  UserData.fromMap(Map<dynamic, dynamic> data) {
    name = data["name"];
    photo = data["photo"];
    email = data["email"];
    type = data["type"];
  }
}
