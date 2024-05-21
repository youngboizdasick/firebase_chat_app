import 'package:firebase_chat_app/firebase_chat_app/auth_providers/auth_provider.dart';
import 'package:firebase_chat_app/firebase_chat_app/components/header_title.dart';
import 'package:firebase_chat_app/firebase_chat_app/components/socialLogin_button.dart';
import 'package:firebase_chat_app/firebase_chat_app/constants/constants.dart';
import 'package:firebase_chat_app/firebase_chat_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../components/loading_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);

        switch (authProvider.status) {
          case Status.authenticateError:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorConstants.secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Login Failed',
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            );
            break;
          default:
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConstants.spacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeaderTitle(title: AppConstants.loginTitle),
                  SizedBox(height: AppConstants.spacing),
                  _buildContinueWith(),
                  SizedBox(height: AppConstants.spacing),
                  _buildListSocialLogin(authProvider),
                ],
              ),
            ),
          ),
          authProvider.status == Status.authenticating
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.secondaryColor.withOpacity(0.5),
                  ),
                  child: LoadingView(),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  _buildContinueWith() {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.spacing / 2),
          child: Text(
            'Continue with',
            style: TextStyle(
                color: ColorConstants.primaryColor, fontSize: AppConstants.spacing, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  _buildListSocialLogin(AuthProvider authProvider) {
    List<String> socialImages = [
      './assets/google.png',
      './assets/facebook.png',
      './assets/twitter.png',
      './assets/apple.png',
    ];
    List<String> socialName = [
      'Google',
      'Facebook',
      'Twitter',
      'Apple',
    ];
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: socialImages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: AppConstants.spacing / 2),
          child: SocialLoginButton(
            pathUrl: socialImages[index],
            title: socialName[index],
          ),
        );
      },
    );
  }
}
