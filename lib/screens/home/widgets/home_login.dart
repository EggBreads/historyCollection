import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:historycollection/Constants/gaps.dart';
import 'package:historycollection/Constants/router_constraint.dart';
import 'package:historycollection/Constants/sizes.dart';
import 'package:historycollection/screens/widgets/login_btn_widget.dart';
import 'package:historycollection/utils/firebase_options.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginSignButtons extends StatefulWidget {
  const LoginSignButtons({super.key});

  @override
  State<LoginSignButtons> createState() => _LoginSignButtonsState();
}

class _LoginSignButtonsState extends State<LoginSignButtons> {
  late FirebaseApp _firebaseApp;
  late GoogleSignInAccount? _googleUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // GoogleSignInAccount? _currentUser;

  _accountSignIn() async {
    String userCredential = (await _initFirebaseApp()).toString();

    UserCredential? getUserInfo = await _signInWithGoogle();

    // print(userCredential);
    // print(getUserInfo);

    setState(() {
      // if (getUserInfo.toString().isNotEmpty) {
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (context) => const MapSample()
      //           // fullscreenDialog: true,
      //           ));
      // }
      if (getUserInfo.toString().isNotEmpty) {
        context.pushNamed(
          RouterPathAndNameConstraint.homeRouteNAME,
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HomeMainScreen(),
        //   ),
        // );
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    // Trigger the authentication flow
    _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await _googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return null;
  }

  _initFirebaseApp() async {
    _firebaseApp = await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      options: DefaultFirebaseOptions.android,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initFirebaseApp();
    _googleSignIn.onCurrentUserChanged.listen(
      (GoogleSignInAccount? account) {
        setState(() {
          _googleUser = account;
        });
        // print(_currentUser);
        // if (_currentUser != null) {
        //   _handleGetContact(_currentUser!);
        // }
      },
    );
    _googleSignIn.signInSilently();
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
