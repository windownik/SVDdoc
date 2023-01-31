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

  void writeCompanyId(int companyId) {
    userBox.put('companyId', companyId);
  }

  void writeEmail(String email) {
    userBox.put('email', email);
  }

  void writeStatus(String status) {
    userBox.put('status', status);
  }

  void writeAccess(String access) {
    userBox.put('access', access);
  }

  void deleteUser() {
    writeAccess('0');
    writeRefresh('0');
    writeUserId(0);
    writeName('');
    writeStatus('0');
  }

  void writeRefresh(String refresh) {
    userBox.put('refresh', refresh);
  }

  User getUser() {
    int userId = userBox.get('userId') ?? 0;
    int companyId = userBox.get('companyId') ?? 0;
    int phone = userBox.get('phone') ?? 0;
    String name = userBox.get('name') ?? '';
    String surname = userBox.get('surname') ?? '';
    String profession = userBox.get('profession') ?? '';
    String companyName = userBox.get('companyName') ?? '';
    String email = userBox.get('email') ?? '0';
    String status = userBox.get('status') ?? 'simple';
    return User(
        userId: userId,
        phone: phone,
        name: name,
        surname: surname,
        companyId: companyId,
        profession: profession,
        companyName: companyName,
        email: email,
        status: status);
  }

  String getAccess() {
    String access = userBox.get('access') ?? '0';
    return access;
  }

  String getRefresh() {
    String refresh = userBox.get('refresh') ?? '0';
    return refresh;
  }
}

class User {
  int userId = 0, companyId = 0, phone = 0;
  String name, surname, profession, companyName, email, status;

  User({
    required this.userId,
    required this.phone,
    required this.name,
    required this.surname,
    required this.companyId,
    required this.profession,
    required this.companyName,
    required this.email,
    required this.status,
  });
}
