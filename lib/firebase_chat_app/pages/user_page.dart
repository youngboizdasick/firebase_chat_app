import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_chat_app/firebase_chat_app/auth_providers/auth_provider.dart';
import 'package:firebase_chat_app/firebase_chat_app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            BootstrapIcons.chevron_left,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _handleLogout(),
            child: Row(
              children: [
                Icon(BootstrapIcons.box_arrow_right),
                SizedBox(width: AppConstants.spacing / 2),
                Text(
                  'Logout',
                  style: TextStyle(fontSize: AppConstants.normalFontSize),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _handleLogout() async {
    authProvider.handleSignOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );
  }
}
