import 'dart:async';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:plasma/core/constants.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';

part 'upload_event.dart';

part 'upload_state.dart';

class UploadBloc extends Bloc<UploadInitialEvent, UploadState> {
  late final StreamSubscription _streamSubscription;
  final FirebaseDBRepo _firebaseDBRepo = FirebaseDBRepo();

  UploadBloc() : super(UploadInitialState()) {
    on<UploadEvent>((event, emit) {
      UploadTask _uploadTask = _firebaseDBRepo.uploadFile(
        file: event.file,
        reference: event.storageReference,
      );
      _uploadTask.whenComplete(() async {
        String url = await event.storageReference.getDownloadURL();
        event.documentReference?.update({event.fieldName!: url});
        add(UploadedEvent(downloadUrl: url));
      });
      _streamSubscription = _uploadTask.snapshotEvents.listen((taskSnapshot) {
        double progress =
            (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes) * 100;
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            displayOnForeground: true,
            category: NotificationCategory.Progress,
            notificationLayout: NotificationLayout.ProgressBar,
            color: Colors.blue,
            id: 10,
            locked: !(progress >= 100),
            channelKey: Constants.progressChannelKey,
            title: progress >= 100 ? "File uploaded" : "Uploading file",
            progress: progress.toInt(),
          ),
        );
        add(UploadingEvent(progress));
      });
      on<UploadingEvent>((event, emit) {
        emit(UploadingState(event.progress.ceilToDouble()));
      });
      on<UploadedEvent>((event, emit) {
        emit(UploadedState(downloadUrl: event.downloadUrl));
      });
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
