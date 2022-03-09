import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:plasma/core/blocs/upload_bloc.dart';
import 'package:plasma/data/repositories/auth_repo.dart';
import 'package:plasma/data/repositories/firebase_db_repo.dart';
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
    return BlocProvider(
      create: (context) => UserCubit(uid),
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
            Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return Hero(
                        tag: "profile_image",
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 3.0,
                            ),
                          ),
                          child: (state.myUser.image != null)
                              ? ClipRRect(
                                  child: Image.network(
                                    state.myUser.image!,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(75),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(75),
                                  child: SvgPicture.asset(
                                    "assets/icons/profile_avatar.svg",
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: AuthRepo().currentUser!.uid == uid,
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

                                  context.read<UploadBloc>().add(
                                        UploadEvent(
                                            storageReference: reference,
                                            file: file,
                                            onComplete: (url) {
                                              AuthRepo()
                                                  .currentUser
                                                  ?.updatePhotoURL(url);
                                            },
                                            documentReference: FirebaseFirestore
                                                .instance
                                                .collection(Collections.users)
                                                .doc(uid),
                                            fieldName: "image"),
                                      );
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
                    const SizedBox(
                      width: 4.0,
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
              visible: AuthRepo().currentUser!.uid != uid,
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
                            Text("Call Now"),
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
                        onPressed: null,
                        child: Row(
                          children: const [
                            Icon(Icons.screen_share_outlined),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text("Send Message"),
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
                              (state.myUser.donated ?? 0).toString(),
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
                              (state.myUser.requested ?? 0).toString(),
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
                            if (AuthRepo().currentUser!.uid == uid) {
                              FirebaseDBRepo().updateUserData(
                                  uid: uid,
                                  fieldName: "isAvailable",
                                  data: isOpen);
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
              onTap: () {},
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
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> _selectImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return File(file.path);
    }
    return null;
  }
}
