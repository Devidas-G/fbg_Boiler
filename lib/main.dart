import 'package:background_fetch/background_fetch.dart';
import 'package:fbg/core/providers/config_pr.dart';
import 'package:fbg/core/providers/location_pr.dart';
import 'package:fbg/core/services/config_s.dart';
import 'package:fbg/locator.dart';
import 'package:fbg/ui/routing/router.dart';
import 'package:fbg/ui/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setuplocators();

  /// Register BackgroundGeolocation headless-task.
  bg.BackgroundGeolocation.registerHeadlessTask(
      backgroundGeolocationHeadlessTask);

  /// Register BackgroundFetch headless-task.
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LocationProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ConfigModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle:
              GoogleFonts.oswald(fontSize: 30, fontStyle: FontStyle.italic),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···
          titleLarge:
              GoogleFonts.oswald(fontSize: 30, fontStyle: FontStyle.italic),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ).apply(bodyColor: Colors.black, displayColor: Colors.black),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, onPrimary: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
