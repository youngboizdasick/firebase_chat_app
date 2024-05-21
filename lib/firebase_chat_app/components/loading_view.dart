import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
        ),
        Center(
          child: SizedBox(
            height: 120.0,
            width: 160.0,
            child: Image.asset(
              './assets/loading.gif',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
