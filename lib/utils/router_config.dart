import 'package:go_router/go_router.dart';
import 'package:historycollection/Constants/router_constraint.dart';

/// Goroute Set
/// paht
/// name
/// builder

final router = GoRouter(
  initialLocation: "/chats",
  routes: [
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
  ],
);
