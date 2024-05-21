import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_chat_app/firebase_chat_app/auth_providers/auth_provider.dart';
import 'package:firebase_chat_app/firebase_chat_app/constants/app_constants.dart';
import 'package:firebase_chat_app/firebase_chat_app/pages/splash_page.dart';
import 'package:firebase_chat_app/firebase_chat_app/pages/user_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_chat_app/pages/home_page.dart';
import 'firebase_chat_app/pages/login_page.dart';
import 'firebase_chat_app/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            googleSignIn: GoogleSignIn(),
            firebaseAuth: FirebaseAuth.instance,
            firebaseFirestore: firebaseFirestore,
            prefs: prefs,
          ),
        )
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        home: const SplashPage(),
        theme: themeData(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/HomePage':(context) => const HomePage(),
          '/LoginPage':(context) => const LoginPage(),
          '/UserPage':(context) => const UserPage(),
        },
      ),
    );
  }
}
