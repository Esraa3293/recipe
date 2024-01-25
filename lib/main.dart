import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';
import 'package:recipe/firebase_options.dart';
import 'package:recipe/pages/splash_screen.dart';
import 'package:recipe/providers/ads_provider.dart';
import 'package:recipe/providers/app_auth_provider.dart';
import 'package:recipe/providers/favorites_provider.dart';
import 'package:recipe/providers/ingredients_provider.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var preference = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(preference);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // if (PreferencesService.prefs != null) {
    //   print("Preferences init successfully");
    // }
  } catch (e) {
    print("Error in Preferences init $e");
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
      create: (_) => FavoritesProvider(),
    )
  ], child: const MyApplication()));
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlayKit(
      appPrimaryColor: ColorsConst.primaryColor,
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Hellix',
            colorScheme: ColorScheme.fromSeed(
                seedColor: ColorsConst.primaryColor,
                primary: ColorsConst.primaryColor),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: const TextStyle(color: Colors.grey),
              prefixIconColor: Colors.grey,
              suffixIconColor: Colors.grey,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey)),
            )),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
