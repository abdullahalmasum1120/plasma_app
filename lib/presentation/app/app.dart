import 'package:flutter/material.dart';
import 'package:plasma/core/constants.dart';
import 'package:plasma/presentation/home/ui/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        primaryColor: const Color(0xFFFF2156),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodySmall: Constants.smallTextStyle,
          bodyMedium: Constants.mediumTextStyle,
          bodyLarge: Constants.largeTextStyle,
          titleLarge: Constants.largeTitleStyle,
          titleMedium: Constants.mediumTitleStyle,
          titleSmall: Constants.smallTitleStyle,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
