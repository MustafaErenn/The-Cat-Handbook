import 'package:cat_breeds_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/init/navigation/navigation_manager.dart';
import '../../../components/cat_breed_card/cat_breed_card_view.dart';
import '../../../constants/application/application_string_constants.dart';
import '../../../constants/enums/navigation_routes.dart';
import '../../home/model/home_page_model.dart';
import '../viewmodel/favorites_page_view_model.dart';

class FavoritesPageView extends StatefulWidget {
  const FavoritesPageView({Key? key}) : super(key: key);
  @override
  State<FavoritesPageView> createState() => _FavoritesPageViewState();
}

class _FavoritesPageViewState extends State<FavoritesPageView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ChangeNotifierProvider(
        create: (context) => FavoritesPageViewModel(),
        builder: (context, child) {
          return BaseView<FavoritesPageViewModel>(
            onModelReady: (model) {},
            onPageBuilder: (_, value) {
              return SafeArea(
                child: Scaffold(
                  appBar: buildHomePageAppBar(context),
                  body: Center(
                    child: (context.watch<FavoritesPageViewModel>().isLoading)
                        ? const CircularProgressIndicator()
                        : buildCatList(
                            context,
                            context
                                    .read<FavoritesPageViewModel>()
                                    .textFieldData
                                    .isNotEmpty
                                ? context
                                    .watch<FavoritesPageViewModel>()
                                    .findedBreeds
                                : context
                                    .watch<FavoritesPageViewModel>()
                                    .breeds,
                          ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  AppBar buildHomePageAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        ApplicationStringConstants.instance.favoritesAppBarTitle,
      ),
      leading: Padding(
        padding: context.paddingLowHorizontal,
        child: IconButton(
          onPressed: () {
            NavigationManager.instance.navigatorPop(
              value:
                  context.read<FavoritesPageViewModel>().isFavoriteListChanged,
            );
          },
          icon: const Icon(
            Icons.chevron_left_outlined,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      actions: const [],
    );
  }

  Widget buildCatList(BuildContext context, List<BreedModel>? breeds) {
    return Column(
      children: [
        buildSearchBreedTextField(context),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: breeds?.length ?? 0,
            itemBuilder: (_, index) {
              return Padding(
                padding: context.paddingNormal,
                child: InkWell(
                  onTap: () async {
                    final result = await NavigationManager.instance
                        .navigateToPage(NavigationRoutesEnums.detail,
                            object: breeds?[index]);

                    if (result) {
                      context
                          .read<FavoritesPageViewModel>()
                          .isFavoriteListChanged = result;
                      context
                          .read<FavoritesPageViewModel>()
                          .getFavoritesFromCache();
                    }
                  },
                  child: CatBreedView(
                    model: breeds?[index],
                    isFavorite: true,
                    favoriteButtonValue: (isFavorite) {
                      if (!isFavorite) {
                        context
                            .read<FavoritesPageViewModel>()
                            .removeFromFavoriteList(breeds?[index].id ?? "");
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Padding buildSearchBreedTextField(BuildContext context) {
    return Padding(
      padding: context.paddingMediumHorizontal + context.paddingLowVertical,
      child: TextField(
        onChanged: (value) {
          context.read<FavoritesPageViewModel>().searchBreed(value);
          context.read<FavoritesPageViewModel>().textFieldData = (value);
        },
        decoration: const InputDecoration(
          labelText: "Search",
          hintText: "Search",
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
