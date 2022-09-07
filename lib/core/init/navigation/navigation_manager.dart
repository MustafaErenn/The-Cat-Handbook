import 'package:cat_breeds_app/core/extension/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../product/constants/enums/navigation_routes.dart';

class NavigationManager {
  static NavigationManager? _instance;
  static NavigationManager get instance {
    _instance ??= NavigationManager._init();
    return _instance!;
  }

  NavigationManager._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final removeOldRoutes = (Route<dynamic> route) => false;

  navigateToPage(NavigationRoutesEnums route, {Object? object}) {
    print(route.getRoute());
    return navigatorKey.currentState
        ?.pushNamed(route.getRoute(), arguments: object);
  }

  navigateToPageClear(NavigationRoutesEnums route, {Object? object}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        route.getRoute(), removeOldRoutes,
        arguments: object);
  }

  navigatorPop({bool? value}) {
    return navigatorKey.currentState?.pop(value);
  }
}
