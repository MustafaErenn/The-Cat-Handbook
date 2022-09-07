import '../../product/constants/enums/navigation_routes.dart';

extension NavigationEnumsExtension on NavigationRoutesEnums {
  String getRoute() {
    if (name == NavigationRoutesEnums.main) {
      return "/";
    }
    return "/$name";
  }
}
