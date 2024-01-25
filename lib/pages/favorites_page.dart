import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/favorite.model.dart';
import 'package:recipe/providers/favorites_provider.dart';

import '../utils/colors.dart';
import '../utils/numbers.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Favorite favorite = Favorite();
  bool isFavorite = false;

  void init() async {
    await Provider.of<FavoritesProvider>(context, listen: false).getFavorites();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Favorites",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) => favoritesProvider
                    .favorites ==
                null
            ? const Center(child: CircularProgressIndicator())
            : (favoritesProvider.favorites?.isEmpty ?? false)
                ? const Center(
                    child: Text(
                      "No Data Found!",
                      style: TextStyle(
                          color: ColorsConst.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Numbers.appHorizontalPadding),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorsConst.containerBgColor),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      height: 45,
                                      child: Image.network(
                                        favoritesProvider
                                                .favorites![index].imagePath ??
                                            "",
                                        fit: BoxFit.cover,
                                        height: double.maxFinite,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favoritesProvider.favorites![index]
                                                    .mealType ??
                                                "",
                                            style: const TextStyle(
                                              color: ColorsConst.titleColor,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            favoritesProvider
                                                    .favorites![index].title ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              RatingBar.builder(
                                                initialRating: 3,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                updateOnDrag: true,
                                                unratedColor:
                                                    ColorsConst.grayColor,
                                                itemCount: 5,
                                                itemSize: 15,
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color:
                                                      ColorsConst.primaryColor,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                favoritesProvider
                                                        .favorites![index]
                                                        .nutFacts ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: ColorsConst
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time,
                                                size: 20,
                                                color: ColorsConst.grayColor,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                favoritesProvider
                                                        .favorites![index]
                                                        .prepTime ??
                                                    "",
                                                style: const TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.normal,
                                                  color: ColorsConst.grayColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 17,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.room_service_outlined,
                                                    size: 20,
                                                    color:
                                                        ColorsConst.grayColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${favoritesProvider.favorites![index].serving}",
                                                    style: const TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color:
                                                          ColorsConst.grayColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    favoritesProvider.addUsersToFavorites(
                                        favorite.docId ?? "",
                                        favoritesProvider.favorites![index]
                                                .favoriteUsersIds
                                                ?.contains(FirebaseAuth.instance
                                                    .currentUser?.uid) ??
                                            false);
                                    isFavorite = true;
                                  },
                                  child: (isFavorite
                                      ? const Icon(
                                          Icons.favorite_border_rounded,
                                          size: 30,
                                          color: ColorsConst.grayColor,
                                        )
                                      : const Icon(
                                          Icons.favorite_rounded,
                                          size: 30,
                                          color: ColorsConst.primaryColor,
                                        )),
                                ),
                              )
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.transparent,
                        ),
                    itemCount: favoritesProvider.favorites!.length),
      ),
    );
  }
}
