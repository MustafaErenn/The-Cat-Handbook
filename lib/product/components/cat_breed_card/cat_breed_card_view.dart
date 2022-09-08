import 'package:cat_breeds_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/components/image_network_progress/network_image_with_progress_bar.dart';
import '../../../core/components/prefix_icon_text/text_with_prefix_icon.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../../cache/breed_cache_manager.dart';
import '../../constants/application/application_string_constants.dart';
import '../../view/home/model/home_page_model.dart';

class CatBreedView extends StatelessWidget {
  final Function(bool) favoriteButtonValue;

  final BreedModel? model;
  bool isFavorite;
  CatBreedView({
    super.key,
    required this.favoriteButtonValue,
    required this.isFavorite,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black12,
          ),
          child: Padding(
            padding: context.paddingNormal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NetworkImageWithProgressBar(
                    imagePath: model?.image?.url ??
                        ApplicationStringConstants.instance.defaultImagePath),
                buildBreedNameTitle(context),
                const SizedBox(
                  height: 10,
                ),
                buildBreedOriginAndLifeSpan(),
              ],
            ),
          ),
        ),
        buildFavoriteButton(),
      ],
    );
  }

  Positioned buildFavoriteButton() {
    BreedCacheManager breedCacheManager =
        BreedCacheManager(LocaleManager.instance);

    return Positioned(
      top: -10,
      right: 0,
      child: IconButton(
        onPressed: () {
          if (isFavorite) {
            breedCacheManager.removeBreedWithId(model?.id);
          } else {
            breedCacheManager.saveBreed(model);
          }
          isFavorite = !isFavorite;
          favoriteButtonValue(isFavorite);
        },
        icon: Icon(
          isFavorite
              ? Icons.favorite_outlined
              : Icons.favorite_outline_outlined,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }

  Row buildBreedOriginAndLifeSpan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextWithPrefixIcon(
            icon: Icons.location_on_outlined, value: model?.origin ?? ""),
        TextWithPrefixIcon(icon: Icons.favorite, value: model?.lifeSpan ?? ""),
      ],
    );
  }

  Text buildBreedNameTitle(BuildContext context) {
    return Text(
      model?.name ?? "",
      style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
    );
  }
}
