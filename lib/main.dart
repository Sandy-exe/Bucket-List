import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bucket_list/screens/homePage.dart';
// import 'package:firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    print("shit");
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBdRZoqyW80jeyEktK--QXgpHYCkWwh8BI",
            appId: "1:882653867771:web:49776a8b206b5a3bc90a5e",
            messagingSenderId: "882653867771",
            projectId: "to-do-app-b3a5a"));
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBdRZoqyW80jeyEktK--QXgpHYCkWwh8BI",
            appId: "1:882653867771:web:49776a8b206b5a3bc90a5e",
            messagingSenderId: "882653867771",
            projectId: "to-do-app-b3a5a"));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Todo-list",
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}
