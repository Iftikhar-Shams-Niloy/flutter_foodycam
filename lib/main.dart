import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'presentation/pages/home_screen.dart';
import 'core/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    func,
  ) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) {
      runApp(const FoodClassifierApp());
    });
  });
}

class FoodClassifierApp extends StatelessWidget {
  const FoodClassifierApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Classifier',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: colorSchemeLight,
        scaffoldBackgroundColor: colorSchemeLight.primaryFixedDim,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorSchemeLight.primary,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: colorSchemeLight.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorSchemeLight.primaryContainer,
            iconColor: colorSchemeLight.primary,
            foregroundColor: colorSchemeLight.primary,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodySmall: TextStyle(color: colorSchemeLight.primary),
          bodyMedium: TextStyle(color: colorSchemeLight.primary),
          bodyLarge: TextStyle(color: colorSchemeLight.primary),
        ),
      ),

      darkTheme: ThemeData.dark().copyWith(
        colorScheme: colorSchemeDark,
        scaffoldBackgroundColor: colorSchemeDark.primaryContainer,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorSchemeDark.inversePrimary,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: colorSchemeDark.primary,
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorSchemeDark.primary,
            iconColor: colorSchemeDark.onPrimary,
            foregroundColor: colorSchemeDark.onPrimary,
          ),
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodySmall: TextStyle(color: colorSchemeDark.onPrimary),
          bodyMedium: TextStyle(color: colorSchemeDark.onPrimary),
          bodyLarge: TextStyle(color: colorSchemeDark.onPrimary),
        ),
      ),

      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
