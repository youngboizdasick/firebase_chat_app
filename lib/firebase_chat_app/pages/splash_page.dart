import 'package:firebase_chat_app/firebase_chat_app/auth_providers/auth_provider.dart';
import 'package:firebase_chat_app/firebase_chat_app/components/header_title.dart';
import 'package:firebase_chat_app/firebase_chat_app/constants/constants.dart';
import 'package:firebase_chat_app/firebase_chat_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();

    if (isLoggedIn) {
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => HomePage()));
      return;
    }

    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HeaderTitle(title: AppConstants.appTitle),
      ),
    );
  }
}
