import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/ads_provider.dart';
import 'package:recipe/utils/colors.dart';

class AdsWidget extends StatefulWidget {
  const AdsWidget({super.key});

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  void init() async {
    await Provider.of<AdsProvider>(context, listen: false).getAds();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<AdsProvider>(context, listen: false).disposeCarousel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsProvider>(
        builder: (context, adsProvider, child) => adsProvider.adsList == null
            ? const Center(child: CircularProgressIndicator())
            : (adsProvider.adsList?.isEmpty ?? false)
                ? const Text(
                    "No Data Found!",
                    style: TextStyle(
                        color: ColorsConst.primaryColor,
                        fontWeight: FontWeight.bold),
                  )
                : Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CarouselSlider(
                            carouselController: adsProvider.carouselController,
                            options: CarouselOptions(
                              height: 200.0,
                              autoPlay: true,
                              viewportFraction: .75,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              enlargeCenterPage: true,
                              enlargeFactor: .3,
                              onPageChanged: (index, _) =>
                                  adsProvider.onPageChanged(index),
                            ),
                            items: adsProvider.adsList!.map((ad) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: ad.image ?? "",
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text(
                                          ad.title ?? "",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    adsProvider.onArrowBackTapped(),
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                              IconButton(
                                onPressed: () =>
                                    adsProvider.onArrowForwardTapped(),
                                icon: const Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ],
                      ),
                      DotsIndicator(
                        dotsCount: adsProvider.adsList!.length,
                        position: adsProvider.sliderIndex,
                        onTap: (position) => adsProvider.onDotTapped(position),
                        decorator: DotsDecorator(
                          activeColor: ColorsConst.primaryColor,
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ],
                  ));
  }
}
