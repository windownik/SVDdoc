
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svd_doc/screens/loading.dart';
import 'package:svd_doc/screens/login/login_main.dart';
import 'package:svd_doc/sign_up/sign_up_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


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
        '/': (context) => const Loading(),
        '/login': (context) => const LoginScreen(),
        '/sign_up': (context) => const SignUpFirst(),
      },
    );
  }
}