import 'dart:convert';

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

  void writeStringNewUsers(String newUsers) {
    userBox.put('newUsers', newUsers);
  }

  void writeLastActive(String lastActive) {
    userBox.put('lastActive', lastActive);
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
    String lastActive = userBox.get('lastActive') ?? '2023-02-02T17:24:46.396038';
    return User(
        userId: userId,
        phone: phone,
        name: name,
        surname: surname,
        companyId: companyId,
        profession: profession,
        companyName: companyName,
        email: email,
        status: status,
        createDate: lastActive);
  }

  String getAccess() {
    String access = userBox.get('access') ?? '0';
    return access;
  }

  List getNewUsers() {
    String dbNewUsers = userBox.get('newUsers') ?? '0';
    if (dbNewUsers == '0') return [];
    Map<String, dynamic> response = jsonDecode(dbNewUsers);
    var users = response['users'];
    List newUsers = [];
    for (var i in users) {
      newUsers.add(User(
          userId: i['user_id'],
          phone: i['phone'],
          name: i['name'],
          surname: i['surname'],
          companyId: 0,
          profession: '0',
          companyName: '0',
          email: i['email'],
          status: i['status'],
          createDate: i['create_date']),
      );
    }
    return newUsers;
  }

  String getRefresh() {
    String refresh = userBox.get('refresh') ?? '0';
    return refresh;
  }
}

class User {
  int userId = 0, companyId = 0, phone = 0;
  String name, surname, profession, companyName, email, status, createDate, activeDate;

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
    required this.createDate,
    this.activeDate = ''
  });
}

class Company {
  int companyId = 0, companyTypeId = 0;
  String name = '', typeName = '';
  Company({
    required this.companyId,
    required this.companyTypeId,
    required this.name,
    required this.typeName
  });
}

class ListProfession {
  ListProfession._();
  static const List<Profession> professionSvd = [
    Profession(professionId: 1, name: 'Директор'),
    Profession(professionId: 2, name: 'Руководитель проекта'),
    Profession(professionId: 3, name: 'Инженер тех. надзор'),
    Profession(professionId: 4, name: 'Инженер ПТО'),
  ];
  static const List<Profession> professionRead = [
    Profession(professionId: 5, name: 'Директор'),
    Profession(professionId: 6, name: 'Технический директор'),
    Profession(professionId: 7, name: 'Финансовый директор'),
    Profession(professionId: 8, name: 'Секретарь'),
    Profession(professionId: 9, name: 'Бухгалтер'),
  ];
  static const List<Profession> professionNotification = [
    Profession(professionId: 10, name: 'Прораб'),
    Profession(professionId: 11, name: 'Мастер'),
    Profession(professionId: 12, name: 'Подрядчик'),
  ];
}

class Profession {
  final int professionId;
  final String name;
  const Profession({
    required this.professionId,
    required this.name,
  });
}