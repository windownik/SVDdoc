import 'dart:convert';
import 'package:http/http.dart' as http;

import 'data_base.dart';

class ApiSVD {
  String urlAddress = '185.51.247.27:10020';
  UserDataBase db = UserDataBase();
  String access = '0';

  ApiSVD() {
    access = db.getAccess();
  }

  Future<bool> updateAccess() async {
    String refresh = db.getRefresh();
    var url = Uri.http(urlAddress, "/access_token", {"refresh_token": refresh});
    var res = await http.get(url);
    if (res.statusCode != 200) {
      return false;
    }
    access = jsonDecode(res.body)["access_token"];
    db.writeAccess(access);
    return true;
  }

  Future<Map<String, dynamic>> userCreate(
    String email, {
    required String name,
    required String surname,
    required int phone,
    required String password,
    required String status,
  }) async {
    Map<String, dynamic> params = {
      "name": name,
      "surname": surname,
      "phone": phone.toString(),
      "email": email,
      "password": password,
      "status": status,
    };
    var url = Uri.http(urlAddress, "/user", params);
    var res = await http.post(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> resSales = jsonDecode(res.body);
    return resSales;
  }

  Future<User> userGet() async {
    Map<String, dynamic> params = {
      "access_token": access,
    };
    var url = Uri.http(urlAddress, "/user", params);
    var res = await http.get(url);
    if (res.statusCode == 401) {
      bool status = await updateAccess();
      if (!status) {
        return db.getUser();
      }
      res = await http.get(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(utf8.decode(res.bodyBytes));
    db.writeUserId(response['user_id']);
    db.writeName(response['name']);
    db.writeSurName(response['surname']);
    db.writePhone(response['phone']);
    db.writeEmail(response['email']);
    db.writeStatus(response['status']);
    db.writeCompanyId(response['company_id']);
    db.writeCompanyName(response['company_name']);
    db.writeProfession(response['position_name']);
    return db.getUser();
  }

  Future<bool> logIn(String phone, String password) async {
    Map<String, dynamic> params = {
      "phone": phone.substring(1, phone.length),
      "password": password,
    };
    var url = Uri.http(urlAddress, "/login", params);
    var res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    access = response['access_token'];
    db.writeUserId(response['user_id']);
    db.writeAccess(response['access_token']);
    db.writeRefresh(response['refresh_token']);
    return true;
  }

  Future<List<User>> getUsers() async {
    Map<String, dynamic> params = {
      "access_token": access,
    };
    var url = Uri.http(urlAddress, "/get_users", params);
    var res = await http.get(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.get(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    var users = response['users'];
    db.writeStringNewUsers(res.body);
    List<User> newUsers = [];
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
          createDate: i['create_date']));
    }
    return newUsers;
  }

  Future<List<Company>> getCompanyList() async {
    var url = Uri.http(urlAddress, "/company_all");
    var res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    var companyS = response['company'];
    db.writeStringNewUsers(res.body);
    List<Company> companyList = [];
    for (var i in companyS) {
      companyList.add(Company(
        companyId: i['id'],
        companyTypeId: i['company_type_id'],
        name: i['company_name'],
        typeName: i['company_type_name'],
      ));
    }
    return companyList;
  }

  Future<bool> updateProfession (int userId, int positionId, int companyId, ) async {
    Map<String, dynamic> params = {
      "position_id": positionId.toString(),
      "company_id": companyId.toString(),
      "user_id": userId.toString(),
      "access_token": access,
    };
    var url = Uri.http(urlAddress, "/user_info", params);
    var res = await http.put(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.put(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    print(1);
    return true;
  }

  Future<bool> createCompany (String name, int companyTypeId) async {
    Map<String, dynamic> params = {
      "name": name,
      "company_type_id": companyTypeId.toString(),
      "access_token": access,
    };
    var url = Uri.http(urlAddress, "/company", params);
    var res = await http.post(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.post(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    return true;
  }

  Future<bool> updateCompany (String name, int companyId) async {
    Map<String, dynamic> params = {
      "new_name": name,
      "company_id": companyId.toString(),
      "access_token": access,
    };
    var url = Uri.http(urlAddress, "/company", params);
    var res = await http.put(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.put(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    return true;
  }

  Future<List<User>> usersInCompany (int companyId) async {
    Map<String, dynamic> params = {
      "company_id": companyId.toString(),
      "access_token": access,
    };
    var url = Uri.http(urlAddress, "/users_in_company", params);
    var res = await http.get(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.get(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    var users = response['all_users'];
    List<User> allUsers = [];
    for (var i in users) {
      allUsers.add(User(
          userId: i['user_id'],
          name: i['name'],
          surname: i['surname'],
          phone: i['phone'],
          companyId: companyId,
          email: i['email'],
          status: i['status'],
          profession: i['position'],
          companyName: response['company_name'],
          activeDate: i['active_date'],
          createDate: i['create_date']));
    }
    return allUsers;
  }
}
