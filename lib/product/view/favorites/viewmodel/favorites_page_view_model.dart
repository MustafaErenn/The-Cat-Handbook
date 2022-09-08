// import 'package:flutter/material.dart';

// import '../../../../core/init/cache/locale_manager.dart';
// import '../../../cache/breed_cache_manager.dart';
// import '../../home/model/home_page_model.dart';

// class FavoritesPageViewModel extends ChangeNotifier {
//   Map<String, bool> favoriteList = {};

//   BreedCacheManager breedCacheManager =
//       BreedCacheManager(LocaleManager.instance);

//   bool isRemovedFromFavoriteStatus = false;

//   // bool isChangeFavoriteStatusInDetail = false;

//   // void changeisChangeFavoriteStatusInDetail() {
//   //   isChangeFavoriteStatusInDetail = !isChangeFavoriteStatusInDetail;
//   //   notifyListeners();
//   // }

//   void changeisRemovedFromFavoriteStatus() {
//     isRemovedFromFavoriteStatus = !isRemovedFromFavoriteStatus;
//     notifyListeners();
//   }

//   void getFavorites({bool isChanged = false}) {
//     favoriteList.clear();

//     final favorites = breedCacheManager.getBreeds();
//     if (favorites == null) {
//       notifyListeners();
//       return;
//     }
//     if (isChanged) {
//       breeds?.clear();
//     }
//     for (var favoriteElement in favorites) {
//       favoriteList[favoriteElement.id ?? ""] = true;
//       breeds?.add(favoriteElement);
//     }
//     notifyListeners();
//   }

//   void addToFavoriteList(String id) {
//     favoriteList[id] = true;
//     notifyListeners();
//   }

//   void removeFromFavoriteList(String id) {
//     favoriteList[id] = false;
//     if (breeds == null) {
//       return;
//     }
//     breeds!.removeWhere(
//       (element) => element.id == id,
//     );

//     changeisRemovedFromFavoriteStatus();

//     notifyListeners();
//   }

//   String textFieldData = "";

//   List<BreedModel>? breeds = [];
//   List<BreedModel> findedBreeds = [];
//   bool isLoading = false;

//   void init() async {
//     getFavoritesFromCache();
//     getFavorites();
//   }

//   void getFavoritesFromCache() {
//     breeds = breedCacheManager.getBreeds();
//     notifyListeners();
//   }

//   FavoritesPageViewModel() {
//     init();
//   }

//   void changeLoading() {
//     isLoading = !isLoading;
//     notifyListeners();
//   }

//   void searchBreed(String query) {
//     findedBreeds.clear();
//     if (query.isEmpty && breeds == null) {
//       return;
//     }
//     for (var breed in breeds!) {
//       if (breed.name?.toLowerCase().contains(query.toLowerCase()) ?? false) {
//         findedBreeds.add(breed);
//       }
//     }

//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

import '../../../../core/init/cache/locale_manager.dart';
import '../../../cache/breed_cache_manager.dart';
import '../../home/model/home_page_model.dart';

class FavoritesPageViewModel extends ChangeNotifier {
  BreedCacheManager breedCacheManager =
      BreedCacheManager(LocaleManager.instance);

  bool isFavoriteListChanged = false;

  void removeFromFavoriteList(String id) {
    if (breeds == null) {
      return;
    }
    breeds!.removeWhere(
      (element) => element.id == id,
    );

    breedCacheManager.removeBreedWithId(id);
    isFavoriteListChanged = true;
    notifyListeners();
  }

  String textFieldData = "";

  List<BreedModel>? breeds = [];
  List<BreedModel> findedBreeds = [];
  bool isLoading = false;

  void init() async {
    getFavoritesFromCache();
  }

  void getFavoritesFromCache() {
    breeds = breedCacheManager.getBreeds();
    notifyListeners();
  }

  FavoritesPageViewModel() {
    init();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void searchBreed(String query) {
    findedBreeds.clear();
    if (query.isEmpty && breeds == null) {
      return;
    }
    if ((breeds ?? []).isEmpty) {
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
