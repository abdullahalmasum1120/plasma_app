import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:plasma/core/blocs/upload_bloc.dart';
import 'package:plasma/domain/interfaces/i_firestore_db.dart';
import 'package:plasma/presentation/profile/logic/user_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  final String uid;

  const Profile({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(uid),
        ),
        BlocProvider(
          create: (context) => UploadBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text("Profile"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const SizedBox(
              height: 48.0,
            ),
            //TODO: solve UI problem updating
            Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 3.0,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: (state.myUser.image != null)
                              ? ClipRRect(
                                  child: Image.network(
                                    state.myUser.image!,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(75),
                                )
                              : SvgPicture.asset(
                                  "assets/icons/profile_avatar.svg",
                                ),
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: FirebaseAuth.instance.currentUser!.uid == uid,
                    child: Positioned(
                      bottom: 5,
                      right: 5,
                      child: BlocBuilder<UploadBloc, UploadState>(
                        builder: (context, state) {
                          if (state is UploadingState) {
                            return const SizedBox();
                          }
                          return Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                File? file = await _selectImageFromGallery();
                                if (file != null) {
                                  Reference reference = FirebaseStorage.instance
                                      .ref("profileImagesOfUser")
                                      .child(uid)
                                      .child(
                                          "profileImage.${path.extension(file.path)}");

                                  context.read<UploadBloc>().add(UploadEvent(
                                      storageReference: reference,
                                      file: file,
                                      documentReference: FirebaseFirestore
                                          .instance
                                          .collection(Collections.users)
                                          .doc(uid),
                                      fieldName: "image"));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Image not Selected")));
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Text(
                  state.myUser.username ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(overflow: TextOverflow.ellipsis),
                  textAlign: TextAlign.center,
                );
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      "${state.myUser.thana}, ${state.myUser.city}",
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 32.0,
            ),
            Visibility(
              visible: FirebaseAuth.instance.currentUser!.uid != uid,
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          primary: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          launch("tel:${state.myUser.phone}");
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.call_outlined),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Call Now",
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () async {
                          // showDialog(
                          //     barrierDismissible: false,
                          //     context: context,
                          //     builder: (context) {
                          //       return const Loading();
                          //     });
                          // String id = const Uuid().v1();
                          //
                          // ReceivedRequest receivedRequest = ReceivedRequest(
                          //   time: DateFormat('kk:mm').format(DateTime.now()),
                          //   date:
                          //       DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          //   uid: FirebaseAuth.instance.currentUser!.uid,
                          //   status: "unread",
                          //   docId: id,
                          // );
                          // Map<String, dynamic> sentRequest = {
                          //   "uid": uid,
                          //   "status": "unread",
                          //   "docId": id,
                          // };
                          // try {
                          //   uploadRequests(sentRequest,
                          //       receivedRequest.toJson(), state.myUser, id);
                          //   Navigator.pop(context);
                          //   showDialog(
                          //       barrierDismissible: false,
                          //       context: context,
                          //       builder: (context) {
                          //         return const SuccessfulDialog();
                          //       });
                          // } on FirebaseException catch (e) {
                          //   Navigator.pop(context);
                          //   Get.snackbar("Warning!", e.code);
                          // }
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.screen_share_outlined),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Request",
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 3,
                  child: Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .03),
                    child: Column(
                      children: [
                        BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            return Text(
                              state.myUser.bloodGroup ?? "",
                            );
                          },
                        ),
                        const Text(
                          "blood Type",
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .03),
                    child: Column(
                      children: [
                        BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            return Text(
                              state.myUser.donated.toString(),
                            );
                          },
                        ),
                        const Text(
                          "Donated",
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .03),
                    child: Column(
                      children: [
                        BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            return Text(
                              state.myUser.requested.toString(),
                            );
                          },
                        ),
                        const Text(
                          "Requested",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Card(
              elevation: 3,
              child: Container(
                height: 48.0,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timelapse_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Expanded(
                      child: Text(
                        "Available for Donate",
                      ),
                    ),
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        return FlutterSwitch(
                          width: 56,
                          activeColor: Theme.of(context).primaryColor,
                          value: state.myUser.isAvailable ?? false,
                          onToggle: (isOpen) async {
                            if (FirebaseAuth.instance.currentUser!.uid == uid) {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(uid)
                                  .update({"isAvailable": isOpen});
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            GestureDetector(
              onTap: () {
                //TODO: implement to invite to download app
              },
              child: Card(
                elevation: 3,
                child: Container(
                  height: 48.0,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Expanded(
                        child: Text(
                          "Invite a friend (Coming Soon)",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Card(
              elevation: 3,
              child: Container(
                height: 48.0,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const Expanded(
                      child: Text(
                        "Get help (Coming soon)",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Card(
              elevation: 3,
              child: Container(
                height: 48.0,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            title: Row(
                              children: const [
                                Icon(
                                  Icons.warning,
                                  color: Colors.amber,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text("Warning!"),
                              ],
                            ),
                            content: const Text("Do you want to Sign out?"),
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Sign out",
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Cancel",
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Expanded(
                        child: Text("Sign out"),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void uploadRequests(
  //   Map<String, dynamic> sentRequest,
  //   Map<String, dynamic> receivedRequest,
  //   MyUser myUser,
  //   String id,
  // ) async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(uid)
  //       .collection("receivedRequests")
  //       .doc(id)
  //       .set(receivedRequest);
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("sentRequests")
  //       .doc(id)
  //       .set(sentRequest);
  //
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .update({"requested": myUser.requested! + 1});
  // }

  Future<File?> _selectImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return File(file.path);
    }
    return null;
  }
}
