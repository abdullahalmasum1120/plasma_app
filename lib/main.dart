import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/core/constants.dart';
import 'package:plasma/core/observer.dart';
import 'package:plasma/presentation/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: Constants.progressChannelKey,
        channelName: 'Upload notifications',
        channelDescription:
            'This Notification channel is for showing uploading progress',
        importance: NotificationImportance.Max,
        playSound: true,
        enableVibration: true,
      )
    ],
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: Observer(),
  );
}
