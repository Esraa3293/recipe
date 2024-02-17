import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:recipe/firebase_options.dart';
import 'package:recipe/pages/splash_screen.dart';
import 'package:recipe/providers/ads_provider.dart';
import 'package:recipe/providers/app_auth_provider.dart';
import 'package:recipe/providers/ingredients_provider.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/providers/settings_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(e.toString());
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AdsProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => AppAuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => RecipesProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => IngredientsProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
    ),
  ], child: const MyApplication()));
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      // minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return OverlayKit(
          appPrimaryColor: ColorsConst.primaryColor,
          child: Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) => MaterialApp(
              locale: Locale(settingsProvider.languageCode),
              localizationsDelegates: const [
                AppLocalizations.delegate, // Add this line
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              theme: MyThemeData.lightTheme,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            ),
          ),
        );
      },
    );
  }
}
