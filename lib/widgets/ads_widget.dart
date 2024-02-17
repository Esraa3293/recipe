import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/ads_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/text_styles.dart';

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
    Provider.of<AdsProvider>(context, listen: false).initCarousel();
    super.initState();
  }

  // @override
  // void dispose() {
  //   Provider.of<AdsProvider>(context, listen: false).disposeCarousel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsProvider>(
        builder: (context, adsProvider, child) => adsProvider.adsList == null
            ? const Center(child: CircularProgressIndicator())
            : (adsProvider.adsList?.isEmpty ?? false)
                ? Text(
                    "No Data Found!",
                    style: hellixw700(),
                  )
                : Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CarouselSlider(
                            carouselController: adsProvider.carouselController,
                            options: CarouselOptions(
                              height: 200.0.h,
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
                                                horizontal: 5.0)
                                            .r,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: ad.imageUrl ?? "",
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(8.0).r,
                                        padding: const EdgeInsets.all(5.0).r,
                                        decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: Text(
                                          ad.title ?? "",
                                          style: hellix16white(),
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
                                onPressed: () async =>
                                    await adsProvider.onArrowBackTapped(),
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                              IconButton(
                                onPressed: () async =>
                                    await adsProvider.onArrowForwardTapped(),
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
                          activeSize: Size(18.0.w, 9.0.h),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0.r)),
                        ),
                      ),
                    ],
                  ));
  }
}
