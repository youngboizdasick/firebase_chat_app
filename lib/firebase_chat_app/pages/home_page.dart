import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_chat_app/firebase_chat_app/auth_providers/auth_provider.dart';
import 'package:firebase_chat_app/firebase_chat_app/constants/constants.dart';
import 'package:firebase_chat_app/firebase_chat_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleSignIn googleSignIn = GoogleSignIn();
  late String currentUserId;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();

    authProvider = context.read<AuthProvider>();
    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currentUserId = authProvider.getUserFirebaseId()!;
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    }
  }

  TextEditingController? searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(left: AppConstants.spacing),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            fillColor: ColorConstants.secondaryColor.withOpacity(0.2),
            suffixIcon: Icon(
              BootstrapIcons.search,
              color: ColorConstants.primaryColor,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.spacing),
          child: IconButton(
            onPressed: () => _onPressedNavigateUserPage(),
            icon: Icon(
              BootstrapIcons.person_circle,
              size: 32,
            ),
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(AppConstants.spacing),
        child: Divider(),
      ),
    );
  }

  _onPressedNavigateUserPage() {
    Navigator.pushNamed(context, '/UserPage');
  }
}
