import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:historycollection/Constants/router_constraint.dart';
import 'package:historycollection/screens/home/repos/auth_repository.dart';
import 'package:historycollection/webrtc/providers/socket_client_provider.dart';

/// Goroute Set
/// paht
/// name
/// builder

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/map",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepository).isLoggined;
      if (!isLoggedIn) {
        if (state.matchedLocation !=
            RouterPathAndNameConstraint.loginRoutePATH) {
          return RouterPathAndNameConstraint.loginRoutePATH;
        }
      }
      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          ref.watch(joinProvider);
          return child;
        },
        routes: [
          GoRoute(
            path: RouterPathAndNameConstraint.loginRoutePATH,
            name: RouterPathAndNameConstraint.loginRouteNAME,
            builder: RouterBuilderWidgets.loginBuilder,
          ),
          GoRoute(
            name: RouterPathAndNameConstraint.homeRouteNAME,
            path: RouterPathAndNameConstraint.homeRoutePATH,
            builder: RouterBuilderWidgets.homeMainBuilder,
            // routes: [

            // ]
          ),
          GoRoute(
            path: RouterPathAndNameConstraint.settingsRoutePATH,
            name: RouterPathAndNameConstraint.settingsRouteNAME,
            builder: RouterBuilderWidgets.settingsBuilder,
          ),
          GoRoute(
            path: RouterPathAndNameConstraint.interestRoutePATH,
            name: RouterPathAndNameConstraint.interestRouteNAME,
            builder: RouterBuilderWidgets.interestBuilder,
          ),
          GoRoute(
            path: RouterPathAndNameConstraint.networkRoutePATH,
            name: RouterPathAndNameConstraint.networkRouteNAME,
            builder: RouterBuilderWidgets.networkBuilder,
          ),
          GoRoute(
            path: RouterPathAndNameConstraint.chatsRoutePATH,
            name: RouterPathAndNameConstraint.chatsRouteNAME,
            builder: RouterBuilderWidgets.chatsBuilder,
          ),
          GoRoute(
            path: RouterPathAndNameConstraint.cameraRoutePATH,
            name: RouterPathAndNameConstraint.cameraRouteNAME,
            builder: RouterBuilderWidgets.cameraBuilder,
          ),
        ],
      ),
    ],
  );
});
