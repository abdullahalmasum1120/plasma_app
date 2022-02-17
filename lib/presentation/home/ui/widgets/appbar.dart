import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasma/presentation/profile/ui/profile.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Dashboard",
      ),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Notifications(),
            //   ),
            // );
          },
          icon: Badge(
            badgeColor: Theme.of(context).primaryColor,
            badgeContent: const Text(
              "10",
            ),
            showBadge: true,
            child: const Icon(
              Icons.notifications_outlined,
              size: 30,
            ),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Profile(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                  );
                },
              ),
            );
          },
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.transparent,
            child: (FirebaseAuth.instance.currentUser!.photoURL == null)
                ? const Icon(
                    Icons.account_circle_outlined,
                    size: 30,
                  )
                : null,
            backgroundImage:
                (FirebaseAuth.instance.currentUser!.photoURL != null)
                    ? NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL.toString())
                    : null,
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
