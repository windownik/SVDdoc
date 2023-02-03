
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:svd_doc/screens/admin/admin_main_screen/admin_main_screen.dart';
import 'package:svd_doc/screens/auth_registration/login/login_screen.dart';
import 'package:svd_doc/screens/auth_registration/login_start/login_main.dart';
import 'package:svd_doc/screens/auth_registration/sign_up/sign_up_main.dart';
import 'package:svd_doc/screens/auth_registration/sign_up_second/sign_up_second_main.dart';
import 'package:svd_doc/screens/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exchanger',
      initialRoute: '/',
      routes: {
        //Auth routes
        '/': (context) => const Loading(),
        '/login': (context) => const LoginScreen(),
        '/login_with_password': (context) => const LoginWithPassword(),
        '/sign_up': (context) => const SignUpFirst(),
        '/sign_up_next': (context) => const SignUpSecond(),
        // Admins routes
        '/admin_start': (context) => const AdminMainScreen(),
        // '/new_user_admin': (context) => const NewUsersAdminScreen(),
      },
    );
  }
}