import 'package:cat_breeds_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/init/navigation/navigation_manager.dart';
import '../../../components/cat_breed_card/cat_breed_card_view.dart';
import '../../../constants/application/application_string_constants.dart';
import '../../../constants/enums/navigation_routes.dart';
import '../model/home_page_model.dart';
import '../viewmodel/home_page_view_model.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      builder: (context, child) {
        return BaseView<HomePageViewModel>(
          onModelReady: (model) {},
          onPageBuilder: (_, value) {
            return SafeArea(
              child: Scaffold(
                appBar: buildHomePageAppBar(context),
                body: Center(
                  child: (context.watch<HomePageViewModel>().isLoading)
                      ? const CircularProgressIndicator()
                      : buildCatList(
                          context,
                          context
                                  .read<HomePageViewModel>()
                                  .textFieldData
                                  .isNotEmpty
                              ? context.watch<HomePageViewModel>().findedBreeds
                              : context.watch<HomePageViewModel>().breeds,
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  AppBar buildHomePageAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        ApplicationStringConstants.instance.homePageAppBarTitle,
        style: context.textTheme.headline4?.copyWith(color: Colors.black),
      ),
      actions: [
        Padding(
          padding: context.paddingNormalHorizontal,
          child: IconButton(
            onPressed: () async {
              final result = await NavigationManager.instance
                  .navigateToPage(NavigationRoutesEnums.favorite);
              if (result) {
                context.read<HomePageViewModel>().getFavorites();
              }
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 40,
            ),
          ),
        )
      ],
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
                      context.read<HomePageViewModel>().getFavorites();
                    }
                  },
                  child: CatBreedView(
                    model: breeds?[index],
                    isFavorite: context
                            .watch<HomePageViewModel>()
                            .favoriteList[breeds?[index].id ?? ""] ??
                        false,
                    favoriteButtonValue: (isFavorite) {
                      if (isFavorite) {
                        context
                            .read<HomePageViewModel>()
                            .addToFavoriteList(breeds?[index].id ?? "");
                      } else {
                        context
                            .read<HomePageViewModel>()
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
          context.read<HomePageViewModel>().searchBreed(value);
          context.read<HomePageViewModel>().textFieldData = (value);
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
