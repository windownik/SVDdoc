import 'dart:convert';
import 'package:http/http.dart' as http;

import 'data_base.dart';


class ApiSVD{
  String urlAddress = '185.51.247.27:10020';
  UserDataBase db = UserDataBase();
  String access = '0';

  ApiSVD() {
    access = db.getAccess();
  }

  Future<bool> updateAccess () async {
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

  Future<Map<String, dynamic>> userCreate(String email, {
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
    Map<String, dynamic> response = jsonDecode(res.body);
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
}
