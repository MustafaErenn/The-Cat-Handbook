class ApplicationStringConstants {
  static ApplicationStringConstants? _instance;
  static ApplicationStringConstants get instance {
    _instance ??= ApplicationStringConstants._init();
    return _instance!;
  }

  ApplicationStringConstants._init();

  String get homePageAppBarTitle => "Cat Breeds";
  String get favoritesAppBarTitle => "Favorites";
  String get defaultImagePath => "https://github.githubassets.com/images/modules/logos_page/Octocat.png";
}
