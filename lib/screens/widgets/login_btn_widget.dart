import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historycollection/Constants/sizes.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({
    super.key,
    required this.loginBtnText,
    required this.loginIcon,
  });

  final String loginBtnText;
  final FaIcon loginIcon;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.all(Sizes.size16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size11),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              offset: const Offset(Sizes.size3, Sizes.size3),
            )
          ],
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: Sizes.size3,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: loginIcon,
            ),
            Text(
              loginBtnText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
