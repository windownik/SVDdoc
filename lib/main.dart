
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:svd_doc/firebase_options.dart';
import 'package:svd_doc/screens/admin/admin_main_screen/admin_main_screen.dart';
import 'package:svd_doc/screens/auth_registration/login/login_screen.dart';
import 'package:svd_doc/screens/auth_registration/login_start/login_main.dart';
import 'package:svd_doc/screens/auth_registration/sign_up/sign_up_main.dart';
import 'package:svd_doc/screens/auth_registration/sign_up_second/sign_up_second_main.dart';
import 'package:svd_doc/screens/loading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling qqqq a background message: ${message.messageId}");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print([549599, message.notification?.title, message.notification?.body]);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
<<<<<<< HEAD
=======
  print('authorizationStatus: ${settings.authorizationStatus}');
  print('token: ${await messaging.getToken()}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
>>>>>>> main

  await Hive.initFlutter();
  await Hive.openBox('user');
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