import 'package:cat_breeds_app/core/extension/context_extension.dart';
import 'package:cat_breeds_app/product/view/favorites/viewmodel/favorites_page_view_model.dart';
import 'package:cat_breeds_app/product/view/home/viewmodel/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/init/cache/locale_manager.dart';
import 'core/init/navigation/navigation_manager.dart';
import 'core/init/navigation/navigation_routes.dart';
import 'product/view/detail/viewmodel/detail_page_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.preferencesInit();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageViewModel>(
            create: (_) => HomePageViewModel()),
        ChangeNotifierProvider<DetailPageViewModel>(
            create: (_) => DetailPageViewModel(null)),
        ChangeNotifierProvider<FavoritesPageViewModel>(
            create: (_) => FavoritesPageViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget with NavigationRoutes {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationManager.instance.navigatorKey,
      onGenerateRoute: onGenerateRoute,
      title: 'Material App',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          elevation: 0,
          titleTextStyle:
              context.textTheme.headline4?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
