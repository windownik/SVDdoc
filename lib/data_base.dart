import 'package:hive/hive.dart';

class UserDataBase {
  final userBox = Hive.box('user');

  void writeUserId(int userId) {
    userBox.put('userId', userId);
  }

  void writeName(String name) {
    userBox.put('name', name);
  }

  void writeSurName(String surname) {
    userBox.put('surname', surname);
  }

  void writePhone(int phone) {
    userBox.put('phone', phone);
  }

  void writeProfession(String profession) {
    userBox.put('profession', profession);
  }

  void writeCompanyName(String companyName) {
    userBox.put('companyName', companyName);
  }

  void writeCompanyId(String companyId) {
    userBox.put('companyId', companyId);
  }

  User getUser() {
    int userId = userBox.get('userId') ?? 0;
    int companyId = userBox.get('companyId') ?? 0;
    int phone = userBox.get('phone') ?? 0;
    String name = userBox.get('name') ?? '';
    String surname = userBox.get('surname') ?? '';
    String profession = userBox.get('profession') ?? '';
    String companyName = userBox.get('companyName') ?? '';
    return User(
        userId: userId,
        phone: phone,
        name: name,
        surname: surname,
        companyId: companyId,
        profession: profession,
        companyName: companyName);
  }
}

class User {
  int userId = 0, companyId = 0, phone = 0;
  String name = '', surname = '', profession = '', companyName = '';

  User({
    required this.userId,
    required this.phone,
    required this.name,
    required this.surname,
    required this.companyId,
    required this.profession,
    required this.companyName,
  });
}
