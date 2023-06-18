import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historycollection/utils/databse.dart';
import 'package:historycollection/utils/router_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs().init();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      themeMode: ThemeMode.system,
      theme: FlexThemeData.light(
        scheme: FlexScheme.gold,
        primaryContainer: Colors.blueAccent,
        secondary: Colors.blue.shade800,
        tertiary: Colors.deepOrangeAccent.shade700,
        fontFamily: GoogleFonts.roboto().fontFamily,
        // swapColors: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.indigo,
        primaryContainer: Colors.orange.shade300,
        secondary: Colors.amberAccent.shade400,
        tertiary: Colors.lightGreen,
        fontFamily: GoogleFonts.roboto().fontFamily,
        // swapColors: true,
      ),
      // theme: ThemeData(
      //   scaffoldBackgroundColor: Colors.lightBlue.shade100,
      //   primaryColor: Colors.yellow.shade100,
      //   highlightColor: Colors.orange.shade300,
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Colors.indigo.shade100,
      //     foregroundColor: Colors.black45,
      //     elevation: 1,
      //     titleTextStyle: const TextStyle(
      //       fontSize: Sizes.size20,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      // ),
      // home: const HomeMain(),
    );
  }
}
