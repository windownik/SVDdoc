import 'package:svd_doc/logic/data_base.dart';
import 'package:svd_doc/logic/api.dart';
import 'package:svd_doc/screens/auth_registration/sign_up_second/sign_up_second_inherit.dart';

Future<int> createUserLogic(context) async {
  String email = SignUpSecondInherited.of(context)?.email ?? '0';
  if (email.isEmpty) {
    email = '0';
  }
  String password = SignUpSecondInherited.of(context)?.password ?? '0';

  UserDataBase db = UserDataBase();
  db.writeEmail(email);
  User user = db.getUser();
  ApiSVD api = ApiSVD();
  try {
    var resp = await api.userCreate(user.email,
        name: user.name,
        surname: user.surname,
        phone: user.phone,
        password: password,
        status: user.status);
    db.writeAccess(resp['access_token']);
    db.writeRefresh(resp['refresh_token']);
  }
  catch (e){
    if (e == 'Connection failed') {
      return 1101;
    }
    // throw Exception('1101');
  }
  return 200;
}
