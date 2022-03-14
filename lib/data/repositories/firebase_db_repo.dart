import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plasma/data/models/blood_request.dart';
import 'package:plasma/data/models/featured_image.dart';
import 'package:plasma/data/models/my_user.dart';
import 'package:plasma/data/models/notification.dart';
import 'package:plasma/data/repositories/auth_repo.dart';
import 'package:plasma/domain/interfaces/i_firestore_db.dart';

class FirebaseDBRepo extends IFirestoreDB {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ///users collection operations
  @override
  Future<MyUser> createUser({required MyUser myUser}) async {
    await _firebaseFirestore
        .collection(Collections.users)
        .doc(myUser.uid)
        .set(myUser.toJson());

    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(Collections.users)
        .doc(myUser.uid)
        .get();

    return MyUser.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  Future<MyUser> getUser({required String uid}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firebaseFirestore.collection(Collections.users).doc(uid).get();

    return MyUser.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  Future<MyUser> updateUserData(
      {required String uid,
      required String fieldName,
      required Object data}) async {
    await _firebaseFirestore
        .collection(Collections.users)
        .doc(uid)
        .update({fieldName: data});

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firebaseFirestore.collection(Collections.users).doc(uid).get();

    return MyUser.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  Stream<MyUser> userStream({required String uid}) {
    return _firebaseFirestore
        .collection(Collections.users)
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) =>
            MyUser.fromJson(documentSnapshot.data() as Map<String, dynamic>));
  }

  @override
  Stream<List<MyUser>> usersStream() {
    return _firebaseFirestore
        .collection(Collections.users)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<MyUser> users = <MyUser>[];

      for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {
        users.add(MyUser.fromJson(
            queryDocumentSnapshot.data() as Map<String, dynamic>));
      }
      return users;
    });
  }

  ///requests collections operations

  @override
  Future<BloodRequest> createRequest(
      {required BloodRequest bloodRequest}) async {
    await _firebaseFirestore
        .collection(Collections.bloodRequests)
        .doc(bloodRequest.id)
        .set(bloodRequest.toJson());

    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(Collections.bloodRequests)
        .doc(bloodRequest.id)
        .get();

    return BloodRequest.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  Future<bool> deleteRequest({required String id}) async {
    //TODO: test this method
    await _firebaseFirestore
        .collection(Collections.bloodRequests)
        .doc(id)
        .delete();
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection(Collections.bloodRequests)
        .doc(id)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      return true;
    }
    return false;
  }

  @override
  Future<BloodRequest> getRequest({required String id}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(Collections.bloodRequests)
        .doc(id)
        .get();

    return BloodRequest.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  Stream<BloodRequest> requestStream({required String id}) {
    return _firebaseFirestore
        .collection(Collections.bloodRequests)
        .doc(id)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) => BloodRequest.fromJson(
            documentSnapshot.data() as Map<String, dynamic>));
  }

  @override
  Stream<List<BloodRequest>> requestsStream() {
    return _firebaseFirestore
        .collection(Collections.bloodRequests)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<BloodRequest> bloodRequests = <BloodRequest>[];

      for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {
        bloodRequests.add(BloodRequest.fromJson(
            queryDocumentSnapshot.data() as Map<String, dynamic>));
      }
      return bloodRequests;
    });
  }

  @override
  Future<BloodRequest> updateRequest(
      {required String id,
      required String fieldName,
      required String data}) async {
    await _firebaseFirestore
        .collection(Collections.bloodRequests)
        .doc(id)
        .update({fieldName: data});

    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(Collections.bloodRequests)
        .doc(id)
        .get();

    return BloodRequest.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  ///features featureImage collections operation
  @override
  Future<FeatureImage> createFeatureImage(
      {required FeatureImage featureImage}) async {
    await _firebaseFirestore
        .collection(Collections.featuresImages)
        .doc(featureImage.id)
        .set(featureImage.toJson());

    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(Collections.featuresImages)
        .doc(featureImage.id)
        .get();

    return FeatureImage.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  @override
  Future<bool> deleteFeatureImage({required String id}) async {
    //TODO: test this method
    await _firebaseFirestore
        .collection(Collections.featuresImages)
        .doc(id)
        .delete();
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection(Collections.featuresImages)
        .doc(id)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      return true;
    }
    return false;
  }

  @override
  Stream<List<FeatureImage>> featureImageStream() {
    return _firebaseFirestore
        .collection(Collections.featuresImages)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<FeatureImage> bloodRequests = <FeatureImage>[];

      for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {
        bloodRequests.add(FeatureImage.fromJson(
            queryDocumentSnapshot.data() as Map<String, dynamic>));
      }
      return bloodRequests;
    });
  }

  ///users notifications collection operations

  @override
  Future<Notification> sendNotification(
      {required Notification notification}) async {
    await _firebaseFirestore
        .collection(Collections.users)
        .doc(notification.receiverUid)
        .collection(Collections.notifications)
        .doc(notification.docId)
        .set(notification.toJson());

    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(Collections.users)
        .doc(notification.receiverUid)
        .collection(Collections.notifications)
        .doc(notification.docId)
        .get();

    return Notification.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  //
  // @override
  // Future<MyUser> getUser({required String uid}) async {
  //   DocumentSnapshot<Map<String, dynamic>> snapshot =
  //   await _firebaseFirestore.collection(Collections.users).doc(uid).get();
  //
  //   return MyUser.fromJson(snapshot.data() as Map<String, dynamic>);
  // }
  //
  // @override
  // Future<MyUser> updateUserData(
  //     {required String uid,
  //       required String fieldName,
  //       required Object data}) async {
  //   await _firebaseFirestore
  //       .collection(Collections.users)
  //       .doc(uid)
  //       .update({fieldName: data});
  //
  //   DocumentSnapshot<Map<String, dynamic>> snapshot =
  //   await _firebaseFirestore.collection(Collections.users).doc(uid).get();
  //
  //   return MyUser.fromJson(snapshot.data() as Map<String, dynamic>);
  // }
  //
  // @override
  // Stream<MyUser> userStream({required String uid}) {
  //   return _firebaseFirestore
  //       .collection(Collections.users)
  //       .doc(uid)
  //       .snapshots()
  //       .map((DocumentSnapshot documentSnapshot) =>
  //       MyUser.fromJson(documentSnapshot.data() as Map<String, dynamic>));
  // }
  //
  @override
  Stream<List<Notification>> notificationsStream() {
    return _firebaseFirestore
        .collection(Collections.users)
        .doc(AuthRepo().currentUser?.uid)
        .collection(Collections.notifications)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<Notification> notifications = <Notification>[];

      for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {
        notifications.add(Notification.fromJson(
            queryDocumentSnapshot.data() as Map<String, dynamic>));
      }
      return notifications;
    });
  }

  ///uploading files into fireStorage
  @override
  UploadTask uploadFile({
    required Reference reference,
    required File file,
  }) {
    return reference.putFile(file);
  }
}
