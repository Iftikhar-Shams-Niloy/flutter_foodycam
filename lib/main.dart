import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'presentation/pages/home_screen.dart';
import 'core/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    func,
  ) {
    runApp(const FoodClassifierApp());
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
        scaffoldBackgroundColor: colorSchemeLight.surfaceDim,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorSchemeLight.onPrimaryContainer,
          foregroundColor: colorSchemeLight.onPrimary,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: colorSchemeLight.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorSchemeLight.primaryContainer,
          ),
        ),
      ),

      darkTheme: ThemeData.dark().copyWith(
        colorScheme: colorSchemeDark,
        scaffoldBackgroundColor: colorSchemeDark.primaryFixedDim,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorSchemeDark.primaryContainer,
          foregroundColor: colorSchemeDark.onPrimary,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: colorSchemeDark.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorSchemeDark.primaryContainer,
          ),
        ),
      ),

      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
