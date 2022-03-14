import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plasma/data/repositories/auth_repo.dart';
import 'package:plasma/presentation/app/assets.dart';
import 'package:plasma/presentation/notifications/logic/notifications_cubit.dart';
import 'package:plasma/presentation/notifications/ui/notifications.dart';
import 'package:plasma/presentation/profile/ui/profile.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Dashboard"),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Notifications(),
              ),
            );
          },
          icon: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoadedState) {
                return Badge(
                  position: const BadgePosition(
                    top: -8.0,
                    end: -4.0,
                  ),
                  badgeColor: Theme.of(context).primaryColor,
                  badgeContent: Text(
                    state.notifications.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  showBadge: state.notifications.isNotEmpty,
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: 30,
                  ),
                );
              }
              return const SizedBox();
            },
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
                    uid: AuthRepo().currentUser!.uid,
                  );
                },
              ),
            );
          },
          child: Hero(
            tag: "profile_image",
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: (AuthRepo().currentUser?.photoURL != null)
                  ? CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        AuthRepo().currentUser!.photoURL!,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SvgPicture.asset(
                          Assets.profileAvatar,
                        ),
                      ),
                    ),
            ),
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
