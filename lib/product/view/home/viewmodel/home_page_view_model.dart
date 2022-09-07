import 'package:flutter/material.dart';

import '../../../../core/init/cache/locale_manager.dart';
import '../../../cache/breed_cache_manager.dart';
import '../model/home_page_model.dart';
import '../service/home_page_service.dart';

class HomePageViewModel extends ChangeNotifier {
  Map<String, bool> favoriteList = {};

  BreedCacheManager breedCacheManager =
      BreedCacheManager(LocaleManager.instance);

  String textFieldData = "";

  void getFavorites() {
    favoriteList.clear();
    final favorites = breedCacheManager.getBreeds();
    if (favorites == null) {
      notifyListeners();
      return;
    }
    for (var favoriteElement in favorites) {
      favoriteList[favoriteElement.id ?? ""] = true;
    }
    notifyListeners();
  }

  void addToFavoriteList(String id) {
    favoriteList[id] = true;
    notifyListeners();
  }

  void removeFromFavoriteList(String id) {
    favoriteList[id] = false;
    notifyListeners();
  }

  List<BreedModel>? breeds = [];
  List<BreedModel> findedBreeds = [];
  bool isLoading = false;

  void init() async {
    await fetchDatas();
    getFavorites();
  }

  HomePageViewModel() {
    init();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  final HomePageService _service = HomePageService();

  Future<void> fetchDatas() async {
    changeLoading();
    breeds = await _service.getBreeds();
    changeLoading();
  }

  void searchBreed(String query) {
    findedBreeds.clear();
    if (query.isEmpty && breeds == null) {
      return;
    }
    for (var breed in breeds!) {
      if (breed.name?.toLowerCase().contains(query.toLowerCase()) ?? false) {
        findedBreeds.add(breed);
      }
    }

    notifyListeners();
  }
}
