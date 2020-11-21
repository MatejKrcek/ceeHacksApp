enum UserType {
  Doctor,
  Pacient,
}

extension ExperienceExtension on UserType {
  String get value {
    switch (this) {
      case UserType.Doctor:
        return "doctor";
      case UserType.Pacient:
        return "patient";
      default:
        return null;
    }
  }
}

class UserTypeHelper {
  static UserType fromString(String value) {
    switch (value) {
      case "doctor":
        return UserType.Doctor;
      case "patient":
        return UserType.Pacient;
      default:
        return null;
    }
  }
}
