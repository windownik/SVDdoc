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

  void updateAccess () async {
    String refresh = db.getRefresh();
    var url = Uri.http(urlAddress, "/access_token", {"refresh_token": refresh});
    var res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    access = jsonDecode(res.body)["access_token"];
    db.writeAccess(access);
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
    print([name, surname, phone, email, password, status]);
    var url = Uri.http(urlAddress, "/user", params);
    var res = await http.post(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> resSales = jsonDecode(res.body);
    return resSales;
  }
}
