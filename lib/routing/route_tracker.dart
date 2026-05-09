import 'package:flutter/material.dart';

class RouteTracker extends NavigatorObserver {
  static String? previousRoute;
  static String? currentRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    RouteTracker.previousRoute = previousRoute?.settings.name;
    RouteTracker.currentRoute = route.settings.name;
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    RouteTracker.previousRoute = route.settings.name;
    RouteTracker.currentRoute = previousRoute?.settings.name;
    super.didPop(route, previousRoute);
  }
}
