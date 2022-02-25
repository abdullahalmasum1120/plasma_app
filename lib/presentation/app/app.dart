import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/core/constants.dart';
import 'package:plasma/presentation/app/blocs/app_bloc.dart';
import 'package:plasma/presentation/auth/ui/auth_screen.dart';
import 'package:plasma/presentation/home/ui/home_screen.dart';
import 'package:plasma/presentation/update_user_data/ui/update_user_info.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFFF2156),
        scaffoldBackgroundColor: const Color(0xFF000000),
        textTheme: TextTheme(
          bodySmall: Constants.smallTextStyle.copyWith(color: Colors.white),
          bodyMedium: Constants.defaultTextStyle.copyWith(color: Colors.white),
          bodyLarge: Constants.largeTextStyle.copyWith(color: Colors.white),
          titleLarge: Constants.largeTitleStyle.copyWith(color: Colors.white),
          titleMedium:
              Constants.defaultTitleStyle.copyWith(color: Colors.white),
          titleSmall: Constants.smallTitleStyle.copyWith(color: Colors.white),
        ),
      ),
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFFFF2156),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodySmall: Constants.smallTextStyle,
          bodyMedium: Constants.defaultTextStyle,
          bodyLarge: Constants.largeTextStyle,
          titleLarge: Constants.largeTitleStyle,
          titleMedium: Constants.defaultTitleStyle,
          titleSmall: Constants.smallTitleStyle,
        ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.white,
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
      home: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppAuthenticatedState) {
            return const HomeScreen();
          }
          if (state is AppUserDataUploadState) {
            return const UpdateUserDataScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
