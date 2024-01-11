import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe/bloc_observer.dart';
import 'package:recipe/pages/splash_screen.dart';
import 'package:recipe/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var preference = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(preference);

    // if (PreferencesService.prefs != null) {
    //   print("Preferences init successfully");
    // }
  } catch (e) {
    print("Error in Preferences init $e");
  }

  runApp(const MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Hellix',
          colorScheme: ColorScheme.fromSeed(
              seedColor: ColorsConst.mainColor, primary: ColorsConst.mainColor),
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
    );
  }
}
