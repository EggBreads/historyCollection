import 'package:flutter/material.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/home/widgets/home_theme.dart';
import 'package:historycollection/screens/login/widgets/home_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Sizes.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: HomeTheme(),
              ),
              SizedBox(
                height: Sizes.size30,
              ),
              Flexible(
                flex: 1,
                child: LoginSignButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
