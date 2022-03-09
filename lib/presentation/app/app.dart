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
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodySmall: Constants.smallTextStyle.copyWith(color: Colors.white),
          bodyMedium: Constants.defaultTextStyle.copyWith(color: Colors.white),
          bodyLarge: Constants.largeTextStyle.copyWith(color: Colors.white),
          titleLarge: Constants.largeTitleStyle.copyWith(color: Colors.white),
          titleMedium:
              Constants.defaultTitleStyle.copyWith(color: Colors.white),
          titleSmall: Constants.smallTitleStyle.copyWith(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          toolbarTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFFFF2156),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodySmall: Constants.smallTextStyle.copyWith(color: Colors.black),
          bodyMedium: Constants.defaultTextStyle.copyWith(color: Colors.black),
          bodyLarge: Constants.largeTextStyle.copyWith(color: Colors.black),
          titleLarge: Constants.largeTitleStyle.copyWith(color: Colors.black),
          titleMedium:
          Constants.defaultTitleStyle.copyWith(color: Colors.black),
          titleSmall: Constants.smallTitleStyle.copyWith(color: Colors.black),
        ),

        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      home: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppAuthenticatedState) {
            return const HomeScreen();
          }
          if (state is AppUserDataUploadState) {
            return  UpdateUserDataScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
