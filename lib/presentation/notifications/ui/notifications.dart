import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plasma/presentation/notifications/logic/notifications_cubit.dart';

class Notifications extends StatelessWidget {
  const Notifications({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        elevation: 0,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoadedState) {
            return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // onTap: () {
                    //   FirebaseFirestore.instance
                    //       .collection("users")
                    //       .doc(FirebaseAuth.instance.currentUser!.uid)
                    //       .collection("receivedRequests")
                    //       .doc(state.notifications[index].docId)
                    //       .update({"status": "read"});
                    //
                    //   Navigator.push(context, MaterialPageRoute(builder: (
                    //       context) {
                    //     return Profile(uid: state.notifications[index].uid!);
                    //   }));
                    // },
                    child: ListTile(
                      title: Text(state.notifications[index].title ?? ""),
                      subtitle: Text(state.notifications[index].body ?? ""),
                    ),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
