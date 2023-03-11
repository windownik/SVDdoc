import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  Future<bool> updatePush(String push) async {
    var url = Uri.http(urlAddress, "/update_push", {"access_token": access, 'push_token': push});
    var res = await http.put(url);
    if (res.statusCode != 200) {
      if (res.statusCode == 401) {
        await updateAccess();
        res = await http.get(url);
      } else {
        return false;
      }
    }
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

  Future<List<User>> getCompanyLineUsers(int companyId) async {
    Map<String, dynamic> params = {
      "access_token": access,
      "company_id": companyId.toString(),
    };
    var url = Uri.http(urlAddress, "/users_line", params);
    var res = await http.get(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.get(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    var users = response['users_line'];
    db.writeStringNewUsers(res.body);
    List<User> newUsers = [];
    for (var i in users) {
      newUsers.add(User(
          userId: i['user_id'],
          phone: i['phone'],
          name: i['name'],
          surname: i['surname'],
          companyId: companyId,
          profession: i['position'],
          companyName: '0',
          email: i['email'],
          status: i['status'],
          createDate: i['create_date']));
    }
    return newUsers;
  }

  Future<List<User>> getPreBillLineUsers(
      {required int investorId, required int techCustomerId, required int contRAgent}) async {
    Map<String, dynamic> params = {
      "investor_id": investorId.toString(),
      "tech_customer_id": techCustomerId.toString(),
      "contr_agent": contRAgent.toString(),
    };
    var url = Uri.http(urlAddress, "/get_bill_line", params);
    var res = await http.get(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.get(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    var users = response['users_line'];
    db.writeStringNewUsers(res.body);
    List<User> newUsers = [];
    for (var i in users) {
      newUsers.add(User(
          userId: i['user_id'],
          phone: i['phone'],
          name: i['name'],
          surname: i['surname'],
          companyId: i['company_id'],
          profession: i['position'],
          companyName: '0',
          email: i['email'],
          status: i['status'],
          createDate: i['create_date']));
    }
    return newUsers;
  }

  Future<void> updateCompanyLineUsers(int companyId, String usersLine) async {
    Map<String, dynamic> params = {
      "access_token": access,
      'users_line': usersLine,
      "company_id": companyId.toString(),
    };

    var url = Uri.http(urlAddress, "/users_line", params);
    var res = await http.put(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.put(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }

  }

  Future<void> createCompanyLineUsers(int companyId, String usersLine) async {
    Map<String, dynamic> params = {
      "access_token": access,
      'users_line': usersLine,
      "company_id": companyId.toString(),
    };
    var url = Uri.http(urlAddress, "/users_line", params);
    var res = await http.post(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.post(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
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
        countObject: i['count_object'],
      ));
    }
    return companyList;
  }

  Future<List<Company>> getCompanyListType(int companyTypeId) async {
    Map<String, dynamic> params = {
      "company_type_id": companyTypeId.toString(),
      "access_token": access,
    };

    var url = Uri.http(urlAddress, "/company_by_type", params);
    var res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    var companyS = response['company_list'];
    db.writeStringNewUsers(res.body);
    List<Company> companyList = [];
    for (var i in companyS) {
      companyList.add(Company(
        companyId: i['id'],
        companyTypeId: i['company_type_id'],
        name: i['company_name'],
        typeName: i['company_type_name'],
        countObject: i['count_object'],
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
    return true;
  }

  Future<bool> deleteUserFromUsersLine (int userId) async {
    Map<String, dynamic> params = {
      "user_id": userId.toString(),
      "access_token": access,
    };
    var url = Uri.http(urlAddress, "/user_info", params);
    var res = await http.delete(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.delete(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
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

  Future<List<CompanyObject>> objectsInCompany (int companyId) async {
    Map<String, dynamic> params = {
      "company_id": companyId.toString(),
      "access_token": access,
    };
    var url = Uri.http(urlAddress, "/object", params);
    var res = await http.get(url);
    if (res.statusCode == 401) {
      await updateAccess();
      res = await http.get(url);
    }
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    var objects = response['objects'];
    List<CompanyObject> allObjects = [];
    for (var i in objects) {
      allObjects.add(CompanyObject(
          name: i['name'],
          objectId: i['object_id'],
          creatorId: i['creator_id'],
          companyId: i['company_id'],
          status: i['status'],
          createDate: i['create_date'],
          lustUpdate: i['lust_update']
      )
      );
    }
    return allObjects;
  }
  Future<void> getFile (int fileId) async {
    Map<String, dynamic> params = {
      "file_id": fileId.toString()
    };
    var url = Uri.http(urlAddress, "/file_download", params);
    var res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
  }
  Future<void> sendFileObject (int objectId, int companyId, String filePath) async {
    Map<String, dynamic> params = {
      "object_id": objectId.toString(),
      'company_id': companyId.toString(),
      'access_token': access
    };
    var url = Uri.http(urlAddress, "/spending_const", params);
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath(
          'file', filePath,
          contentType: MediaType('application', 'x-tar')));
    var res = await request.send();

    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
  }

  Future<DbFile> sendFile (String filePath) async {
    Map<String, dynamic> params = {
      'access_token': access
    };
    var url = Uri.http(urlAddress, "/file_upload", params);
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath(
          'file', filePath,
          contentType: MediaType('application', 'x-tar')));

    var res = await request.send();

    if (res.statusCode == 401) {
      updateAccess();
      res = await request.send();
    }

    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    var result = await http.Response.fromStream(res);

    Map<String, dynamic> response = jsonDecode(result.body);

    DbFile file = DbFile();
    file.fromCreateJson(response);
    return file;
  }

  Future<List<SpendingConst>> getSpendingConst (int objectId) async {
    Map<String, dynamic> params = {
      "object_id": objectId.toString(),
    };
    var url = Uri.http(urlAddress, "/spending_const", params);
    var res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    var allSpendingJson = response['spending_const'];
    List<SpendingConst> allSpendingConst = [];
    for (var resp in allSpendingJson) {
      SpendingConst spendingConst = SpendingConst();
      spendingConst.fromJSON(resp);
      allSpendingConst.add(spendingConst);
    }
    return allSpendingConst;
  }

  Future<int> createObject (String name, int companyId) async {
    User user = await userGet();

    Map<String, dynamic> params = {
      "name": name,
      'company_id': companyId.toString(),
      'creator_id': user.userId.toString(),
      'access_token': access
    };

    var url = Uri.http(urlAddress, "/object", params);
    var res = await http.post(url);

    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    return response['object_id'];
  }

  Future<int> createBill ({
    required String numberId,
    required int companyId,
    required int objectId,
    required int contRAgentId,
    required int techCustomerId,
    required String comment,
    required String usersIdLine,
    required String filesIdLine,
    required String spendingOrdersList,
  }) async {
    User user = await userGet();

    Map<String, dynamic> params = {
      "number_str_id": numberId,
      'company_id': companyId.toString(),
      'contr_agent_id': contRAgentId.toString(),
      'tech_customer_id': techCustomerId.toString(),
      'object_id': objectId.toString(),
      'creator_id': user.userId.toString(),
      'comment': comment,
      'users_id_line': usersIdLine,
      'files_id_line': filesIdLine,
      'spending_orders_list': spendingOrdersList,
      'access_token': access
    };

    var url = Uri.http(urlAddress, "/bill", params);
    var res = await http.post(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    return response['bill_id'];
  }

  Future<BillDocument> getBill ({
    required int billId,
  }) async {
    Map<String, dynamic> params = {
      'bill_id': billId.toString(),
      'access_token': access
    };

    var url = Uri.http(urlAddress, "/bill", params);
    var res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    Map<String, dynamic> response = jsonDecode(res.body);
    User creator = User(
        userId: response['creator']['user_id'],
        phone: response['creator']['phone'],
        name: response['creator']['name'],
        surname: response['creator']['surname'],
        companyId: response['creator']['company_id'],
        profession: response['creator']['position'],
        companyName: response['creator']['company_name'],
        email: response['creator']['email'],
        status: response['creator']['status'],
        createDate: response['creator']['create_date']);

    Company investor = Company(
        companyId: response['investor']['id'],
        companyTypeId: response['investor']['company_type_id'],
        name: response['investor']['company_name'],
        typeName: response['investor']['company_type_name'],
        countObject: response['investor']['count_object']);

    Company contRAgent = Company(
        companyId: response['contr_agent']['id'],
        companyTypeId: response['contr_agent']['company_type_id'],
        name: response['contr_agent']['company_name'],
        typeName: response['contr_agent']['company_type_name'],
        countObject: response['contr_agent']['count_object']);

    Company techCustomer = Company(
        companyId: response['tech_customer']['id'],
        companyTypeId: response['tech_customer']['company_type_id'],
        name: response['tech_customer']['company_name'],
        typeName: response['tech_customer']['company_type_name'],
        countObject: response['tech_customer']['count_object']);

    List<User> usersLine = [];
    for (var one in response['users_line']) {
      User oneUser = User(
          userId: one['user_id'],
          phone: one['phone'],
          name: one['name'],
          surname: one['surname'],
          companyId: one['company_id'],
          profession: one['position'],
          companyName: one['company'],
          email: one['email'],
          status: one['status'],
          createDate: one['create_date']);
      usersLine.add(oneUser);
    }
    CompanyObject pickObject = CompanyObject(
        objectId: response['object']['object_id'],
        companyId: response['object']['company_id'],
        creatorId: response['object']['creator_id'],
        name: response['object']['name'],
        status: response['object']['status'],
        lustUpdate: response['object']['lust_update'],
        createDate: response['object']['create_date']);

    List<SpendingConst> spendLine = [];
    for (var one in response['spending_list']) {
      SpendingConst spend = SpendingConst();
      spend.getFromJSON(one);
      spendLine.add(spend);
    }

    BillDocument bill = BillDocument(
        billNumber: response['bill_number'],
        comment: response['comment'],
        investor: investor,
        contRAgent: contRAgent,
        techCustomer: techCustomer,
        spendingConstList: spendLine,
        pickObject: pickObject,
        creator: creator
    );
    bill.updateUsersLine(usersLine);
    return bill;
  }

  Future<void> sendPush (
      String title,
      String pushBody,
      String mainText,
      String pushType,
      int userId
      ) async {
    Map<String, dynamic> params = {
      "access_token": access,
      'user_id': userId.toString(),
      'title': title,
      'push_body': pushBody,
      'push_type': pushType,
      'main_text': mainText
    };

    var url = Uri.http(urlAddress, "/send_push", params);
    var res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
  }

  Future<List<ActiveMsg>> getActive () async {

    Map<String, dynamic> params = {
      'access_token': access
    };

    var url = Uri.http(urlAddress, "/active", params);
    var res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("${res.statusCode}");
    }
    List<ActiveMsg> activeList = [];
    Map<String, dynamic> response = jsonDecode(res.body);
    for (var one in response['active']) {
      ActiveMsg msg = ActiveMsg();
      msg.fromJSON(one);
      activeList.add(msg);
    }
    return activeList;
  }
}
