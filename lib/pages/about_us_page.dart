import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/text_styles.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutUs),
      ),
      body: const AnimCard(
        color: ColorsConst.primaryColor,
        num: '',
        numEng: '',
        content: '',
      ),
    );
  }
}

class AnimCard extends StatefulWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;

  const AnimCard(
      {super.key,
      required this.color,
      required this.num,
      required this.numEng,
      required this.content});

  @override
  State<AnimCard> createState() => _AnimCardState();
}

class _AnimCardState extends State<AnimCard> {
  var padding = 150.0.r;
  var bottomPadding = 0.0.r;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPadding(
          padding: EdgeInsets.only(top: padding, bottom: bottomPadding),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          child: CardItem(
            color: widget.color,
            num: widget.num,
            numEng: widget.numEng,
            content: widget.content,
            onTap: () {
              padding = padding == 0 ? 150.0.r : 0.0.r;
              bottomPadding = bottomPadding == 0 ? 150.0.r : 0.0.r;
              setState(() {});
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.only(right: 20.r, left: 20.r, top: 200.r),
            height: 180.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2), blurRadius: 30.r),
              ],
              color: Colors.grey.shade200.withOpacity(1.0),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30.r)),
            ),
            child: Center(
              child: Icon(
                Icons.favorite_rounded,
                color: ColorsConst.primaryColor.withOpacity(1.0),
                size: 70,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CardItem extends StatefulWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;
  final void Function()? onTap;

  const CardItem(
      {super.key,
      required this.color,
      required this.num,
      required this.numEng,
      required this.content,
      this.onTap});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.r),
        height: 220.h,
        width: width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: ColorsConst.primaryColor.withOpacity(.2),
                  blurRadius: 25.r)
            ],
            color: widget.color.withOpacity(1.0),
            borderRadius: BorderRadius.circular(30.r)),
        child: Padding(
          padding: EdgeInsets.all(15.0.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tap to view more',
                  style: hellix20w600(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0.r),
                  child: Text(
                    "Home cooks are our heroes—it's as simple as that."
                    " Daily Recipe is a community built by and for kitchen experts:"
                    " The cooks who will dedicate the weekend to a perfect beef"
                    " bourguignon but love the simplicity of a slow-cooker rendition, too."
                    " The bakers who labor over a showstopping 9-layer cake but will"
                    " just as happily doctor boxed brownies for a decadent weeknight dessert."
                    " The entertainers who just want a solid snack spread,"
                    " without tons of dirty dishes at the end of the night."
                    " Most importantly, Daily Recipe connects home cooks with"
                    " their greatest sources of inspiration, other home cooks."
                    " We\'re the world\'s leading digital food brand,"
                    " and that inspires us to do everything possible"
                    " to keep our community connected. Sixty-million"
                    " home cooks deserve no less.",
                    style:
                        hellix16white().copyWith(fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
