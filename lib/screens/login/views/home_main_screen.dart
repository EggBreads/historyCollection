import 'package:flutter/material.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/home/widgets/home_login.dart';
import 'package:historycollection/screens/home/widgets/home_theme.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
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
