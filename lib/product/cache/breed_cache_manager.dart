import 'dart:convert';
import 'dart:developer';

import '../../core/init/cache/locale_manager.dart';
import '../constants/enums/shared_keys_enums.dart';
import '../view/home/model/home_page_model.dart';

class BreedCacheManager {
  late final LocaleManager _localeManager;

  BreedCacheManager(this._localeManager);

  Future<void> saveBreed(BreedModel? breed) async {
    List<BreedModel>? currentList = getBreeds();

    currentList ??= <BreedModel>[];

    if (breed == null) return;

    if (currentList.contains(breed)) return;
    currentList.add(breed);

    final newBreedList = currentList.map((e) => jsonEncode(e.toJson())).toList();

    await _localeManager.setStringItems(SharedKeys.breeds, newBreedList);
  }

  List<BreedModel>? getBreeds() {
    // Compute
    final itemsString = _localeManager.getStringItems(SharedKeys.breeds);
    if (itemsString?.isNotEmpty ?? false) {
      return itemsString!.map((e) {
        final json = jsonDecode(e);

        if (json is Map<String, dynamic>) {
          return BreedModel.fromJson(json);
        }
        return BreedModel();
      }).toList();
    }
    return null;
  }

  Future<void> removeBreed(BreedModel? model) async {
    if (model == null) return;

    List<BreedModel>? currentList = getBreeds();

    if (currentList == null) return;

    currentList.removeWhere((element) => element.id == model.id);

    final newBreedModelList = currentList.map((e) => jsonEncode(e.toJson())).toList();

    await _localeManager.setStringItems(SharedKeys.breeds, newBreedModelList);
  }

  Future<void> removeBreedWithId(String? id) async {
    if (id == null) return;

    List<BreedModel>? currentList = getBreeds();

    if (currentList == null) return;

    currentList.removeWhere((element) => element.id == id);

    final newBreedModelList = currentList.map((e) => jsonEncode(e.toJson())).toList();

    await _localeManager.setStringItems(SharedKeys.breeds, newBreedModelList);
  }

  bool checkBreedExits(BreedModel? model) {
    if (model == null) {
      return false;
    }

    List<BreedModel>? currentList = getBreeds();
    inspect(currentList);
    if (currentList == null) return false;

    for (var element in currentList) {
      if (element.id == model.id) {
        return true;
      }
    }
    return false;
  }
}
