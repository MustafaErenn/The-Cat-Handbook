import 'package:cat_breeds_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/divider_with_text/divider_with_text.dart';
import '../../../../core/components/image_network_progress/network_image_with_progress_bar.dart';
import '../../../../core/init/navigation/navigation_manager.dart';
import '../../../constants/application/application_string_constants.dart';
import '../../home/model/home_page_model.dart';
import '../viewmodel/detail_page_view_model.dart';

class DetailPageView extends StatefulWidget {
  final BreedModel? model;
  const DetailPageView({Key? key, required this.model}) : super(key: key);
  @override
  State<DetailPageView> createState() => _DetailPageViewState();
}

class _DetailPageViewState extends State<DetailPageView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailPageViewModel(widget.model),
      builder: (context, child) {
        return WillPopScope(
            onWillPop: () async {
              NavigationManager.instance.navigatorPop(
                  value:
                      Provider.of<DetailPageViewModel>(context, listen: false)
                          .isChangeFavoriteStatus);
              return false;
            },
            child: Scaffold(
              appBar: buildDetailPageAppBar(
                  context, context.watch<DetailPageViewModel>().isFavorite),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  NetworkImageWithProgressBar(
                    imagePath: widget.model?.image?.url ??
                        ApplicationStringConstants.instance.defaultImagePath,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: context.paddingMedium,
                      child: buildBreedInfoColumn(context),
                    ),
                  ),
                ]),
              ),
            ));
      },
    );
  }

  Column buildBreedInfoColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildInfoCardScrollView(context, widget.model),
        const DividerWithText(text: "Description"),
        buildDescriptionText(context, widget.model),
        _buildSizedBoxForVerticalSpace(),
        const DividerWithText(text: "Stats"),
        _buildSizedBoxForVerticalSpace(),
        buildRatingWithStar(
            context, "Adaptability", widget.model?.adaptability),
        buildRatingWithStar(
            context, "Child Friendly", widget.model?.childFriendly),
        buildRatingWithStar(context, "Dog Friendly", widget.model?.dogFriendly),
        buildRatingWithStar(context, "Energy Level", widget.model?.energyLevel),
        buildRatingWithStar(
            context, "Health Issues", widget.model?.healthIssues),
        buildRatingWithStar(
            context, "Stranger Friendly", widget.model?.strangerFriendly),
      ],
    );
  }

  Row buildRatingWithStar(BuildContext context, String label, int? star) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRatingLabel(context, label),
        ratingStars(double.parse(star.toString())),
      ],
    );
  }

  Widget ratingStars(double? value) {
    return RatingStars(
      value: value ?? 0.0,
      starBuilder: (index, color) => Icon(
        Icons.star,
        color: color,
      ),
      starCount: 5,
      starSize: 30,
      maxValue: 5,
      starSpacing: 1,
      maxValueVisibility: false,
      valueLabelVisibility: false,
      starColor: Colors.yellow,
    );
  }

  SingleChildScrollView buildInfoCardScrollView(
      BuildContext context, BreedModel? model) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildBreedInfoCard(context, "Origin", model?.origin ?? ""),
          buildBreedInfoCard(context, "Life Span", model?.lifeSpan ?? ""),
          buildBreedInfoCard(context, "Weight", model?.weight?.metric ?? ""),
        ],
      ),
    );
  }

  SizedBox buildBreedInfoCard(
      BuildContext context, String label, String value) {
    return SizedBox(
      width: context.width * 0.4,
      child: Card(
        color: Colors.limeAccent,
        child: labeledText(context, label, value),
      ),
    );
  }

  SizedBox _buildSizedBoxForVerticalSpace() {
    return const SizedBox(
      height: 10,
    );
  }

  Text buildDescriptionText(BuildContext context, BreedModel? model) {
    return Text(
      model?.description ?? "",
      style: context.textTheme.headline6,
    );
  }

  Text _buildLabelText(BuildContext context, String value) {
    return Text(
      value,
      style: context.textTheme.headline6?.copyWith(color: Colors.black),
    );
  }

  Widget _buildDataText(BuildContext context, String value) {
    return Text(
      value,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    );
  }

  Widget _buildRatingLabel(BuildContext context, String value) {
    return Text(
      value,
      style: context.textTheme.titleMedium
          ?.copyWith(fontWeight: FontWeight.w400, color: Colors.white),
    );
  }

  Widget labeledText(BuildContext context, String label, String value) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          _buildLabelText(context, label),
          _buildSizedBoxForVerticalSpace(),
          _buildDataText(context, value),
        ],
      ),
    );
  }

  AppBar buildDetailPageAppBar(BuildContext context, bool isFavorite) {
    return AppBar(
      title: Text(widget.model?.name ?? ""),
      leading: Padding(
        padding: context.paddingLowHorizontal,
        child: IconButton(
          onPressed: () {
            NavigationManager.instance.navigatorPop(
                value:
                    context.read<DetailPageViewModel>().isChangeFavoriteStatus);
          },
          icon: const Icon(
            Icons.chevron_left_outlined,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: context.paddingLowHorizontal,
          child: IconButton(
            onPressed: () {
              favoriteButton(context);
            },
            icon: Icon(
              isFavorite
                  ? Icons.favorite_outlined
                  : Icons.favorite_border_outlined,
              color: Colors.red,
              size: 40,
            ),
          ),
        )
      ],
    );
  }

  Future<void> favoriteButton(BuildContext context) async {
    context.read<DetailPageViewModel>().changeIsChangeFavoriteStatus();
    if (context.read<DetailPageViewModel>().isFavorite) {
      context.read<DetailPageViewModel>().changeFavoriteValue();
      await context
          .read<DetailPageViewModel>()
          .breedCacheManager
          .removeBreed(widget.model);
    } else {
      context.read<DetailPageViewModel>().changeFavoriteValue();
      await context
          .read<DetailPageViewModel>()
          .breedCacheManager
          .saveBreed(widget.model);
    }
  }
}
