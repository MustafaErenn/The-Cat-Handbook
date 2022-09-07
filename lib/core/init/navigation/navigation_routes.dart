import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../product/constants/enums/navigation_routes.dart';
import '../../../product/view/detail/view/detail_page_view.dart';
import '../../../product/view/favorites/view/favorites_page_view.dart';
import '../../../product/view/home/model/home_page_model.dart';
import '../../../product/view/home/view/home_page_view.dart';
import '../../components/not_found_page/not_found_page_view.dart';

mixin NavigationRoutes<T extends MyApp> on Widget {
  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    if (routeSettings.name?.isEmpty ?? true) {
      return _navigateToNormal(const NotFoundPageView());
    }

    final routes = routeSettings.name == "/"
        ? NavigationRoutesEnums.main
        : NavigationRoutesEnums.values.byName(routeSettings.name!.substring(1));
    switch (routes) {
      case NavigationRoutesEnums.main:
        return _navigateToNormal(const HomePageView());
      case NavigationRoutesEnums.detail:
        return _navigateToNormal(
            DetailPageView(model: routeSettings.arguments as BreedModel));
      case NavigationRoutesEnums.favorite:
        return _navigateToNormal(const FavoritesPageView());
    }
  }

  MaterialPageRoute _navigateToNormal(Widget child,
      {bool? isFullScreenDialog}) {
    return MaterialPageRoute(
      fullscreenDialog: isFullScreenDialog ?? false,
      builder: (context) {
        return child;
      },
    );
  }
}
