import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hard_flix/provider/google_sign_in.dart';
import 'package:hard_flix/views/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: GetMaterialApp(
          title: 'Hard Flix',
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        ),
      );
}
