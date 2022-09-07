import 'package:flutter/material.dart';

import '../../../../core/init/cache/locale_manager.dart';
import '../../../cache/breed_cache_manager.dart';
import '../../home/model/home_page_model.dart';

class DetailPageViewModel extends ChangeNotifier {
  final BreedCacheManager breedCacheManager =
      BreedCacheManager(LocaleManager.instance);
  bool isFavorite = false;

  bool isChangeFavoriteStatus = false;

  void changeIsChangeFavoriteStatus() {
    isChangeFavoriteStatus = !isChangeFavoriteStatus;
    notifyListeners();
  }

  void changeFavoriteValue() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  DetailPageViewModel(BreedModel? model) {
    init(model);
  }

  void init(BreedModel? model) async {
    final result = breedCacheManager.checkBreedExits(model);
    isFavorite = result;
    notifyListeners();
  }
}
