import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:best_calculator/calculator/calcule_model.dart';
import 'package:best_calculator/calculator/constants.dart';
import 'package:best_calculator/homePage.dart';
import 'package:best_calculator/splashPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'currency/currency_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<CurrencyModel>(CurrencyModelAdapter());
  Hive.registerAdapter<CalculateModel>(CalculateModelAdapter());
  await Hive.openBox<bool>(settingBox);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp( MyApp(title:"Best Calculator"));
}

class MyApp extends StatelessWidget {
   MyApp({Key? key, required this.title}) : super(key: key);
String title;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}

