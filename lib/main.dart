import 'package:flutter/material.dart';
import 'package:plant_vaidya/providers/app_state_provider.dart';
import 'package:plant_vaidya/screens/home_screen.dart';
import 'package:plant_vaidya/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppStateProvider(apiKey: "AIzaSyBlP7EP-GawU8-9EHulo1Shnh3zJaH4UcA"),
      child: MaterialApp(
        title: 'Plant Vaidya',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme, // Optional: if you have a dark theme
        themeMode: ThemeMode.system, // Optional: or ThemeMode.light / ThemeMode.dark
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
