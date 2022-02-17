import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:plasma/data/models/blood_request.dart';
import 'package:plasma/data/models/featured_image.dart';
import 'package:plasma/data/models/my_user.dart';

///all collections of Firestore
class Collections {
  static const String users = "users";
  static const String bloodRequests = "requests";
  static const String featuresImages = "featuresImages";
}

abstract class IFirestoreDB {
  ///users collection operations
  Future<MyUser> createUser({required MyUser myUser});

  Future<MyUser> getUser({required String uid});

  Future<MyUser> updateUserData({
    required String uid,
    required String fieldName,
    required String data,
  });

  Stream<List<MyUser>> usersStream();

  Stream<MyUser> userStream({required String uid});

  ///requests collections operations

  Future<BloodRequest> createRequest({required BloodRequest bloodRequest});

  Future<BloodRequest> getRequest({required String id});

  Future<BloodRequest> updateRequest({
    required String id,
    required String fieldName,
    required String data,
  });

  Stream<List<BloodRequest>> requestsStream();

  Stream<BloodRequest> requestStream({required String id});

  Future<bool> deleteRequest({required String id});

  ///features featureImage collections operation

  Future<FeatureImage> createFeatureImage({required FeatureImage featureImage});

  Stream<List<FeatureImage>> featureImageStream();

  Future<bool> deleteFeatureImage({required String id});

  ///uploading files into fireStorage

  UploadTask uploadFile({
    required Reference reference,
    required File file,
  });
}
