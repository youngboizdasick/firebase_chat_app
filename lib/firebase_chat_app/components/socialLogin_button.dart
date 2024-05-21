import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_providers/auth_provider.dart';
import '../constants/constants.dart';
import '../pages/home_page.dart';

class SocialLoginButton extends StatefulWidget {
  final String pathUrl;
  final String title;
  const SocialLoginButton({super.key, required this.pathUrl, required this.title});

  @override
  State<SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<SocialLoginButton> {
  bool? isPressed;
  @override
  void initState() {
    super.initState();
    isPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () async {
        bool isSuccess = await authProvider.handleSignIn();

        if (isSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
          );
        }
      },
      onTapUp: (_) => {
        setState(() {
          if (isPressed != null) {
            isPressed = !isPressed!;
          }
        })
      },
      onTapDown: (_) => {
        setState(() {
          if (isPressed != null) {
            isPressed = !isPressed!;
          }
        })
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: AnimatedContainer(
          duration: Duration(microseconds: 200),
          decoration: BoxDecoration(
            color: ColorConstants.themeColor,
            borderRadius: BorderRadius.circular(AppConstants.radius),
            boxShadow: isPressed == true
                ? []
                : [
                    BoxShadow(
                      color: ColorConstants.secondaryColor,
                      blurRadius: 12.0,
                      spreadRadius: 1.0,
                      offset: Offset(0, 0),
                    ),
                  ],
            border: isPressed == true
                ? Border.all(
                    color: ColorConstants.secondaryColor,
                    width: 0.5,
                  )
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.spacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppConstants.spacing / 2),
                  child: Image.asset(widget.pathUrl),
                ),
                Text(
                  '${widget.title} Account',
                  style: TextStyle(
                    fontSize: AppConstants.normalFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
