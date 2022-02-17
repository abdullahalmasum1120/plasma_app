import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plasma/data/models/my_user.dart';

class DonorListItem extends StatelessWidget {
  final MyUser user;

  const DonorListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: (user.image != null)
                  ? Image.network(
                      user.image!,
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    )
                  : const Icon(
                      Icons.account_box,
                      size: 80,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.username??"",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                        ),
                        Expanded(
                          child: Text(
                            user.city??"",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 60,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 10),
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 50,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/drop_fill.svg",
                      height: 60,
                      width: 60,
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 26,
                    child: Text(
                      user.bloodGroup??"",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}