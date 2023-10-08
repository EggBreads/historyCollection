import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/home/view_models/auth_view_model.dart';
import 'package:historycollection/screens/widgets/login_btn_widget.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginSignButtons extends ConsumerStatefulWidget {
  const LoginSignButtons({super.key});

  @override
  ConsumerState<LoginSignButtons> createState() => _LoginSignButtonsState();
}

class _LoginSignButtonsState extends ConsumerState<LoginSignButtons> {
  _accountSignIn() async {
    final auth = ref.watch(authProvider.notifier);

    await auth.signUpWithGoogle();

    if (auth.isLoggined) {
      if (mounted) {
        context.go("/map");
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gaps.v20,
        GestureDetector(
          onTap: _accountSignIn,
          child: LoginBtn(
            loginBtnText: 'Google Login',
            loginIcon: FaIcon(
              FontAwesomeIcons.google,
              size: Sizes.size16,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: const [
        //     Text(
        //       'Google Login',
        //       style: TextStyle(
        //         fontSize: 35,
        //         fontWeight: FontWeight.w600,
        //         color: Colors.white,
        //       ),
        //     ),
        //     SizedBox(
        //       width: 50,
        //     ),
        //     Icon(Icons.login_rounded),
        //   ],
        // ),
      ],
    );
  }
}
