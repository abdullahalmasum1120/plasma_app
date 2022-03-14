import 'package:flutter/material.dart';
import 'package:plasma/presentation/add_request/ui/add_request_screen.dart';
import 'package:plasma/presentation/app/assets.dart';
import 'package:plasma/presentation/find_donors/ui/find_donor.dart';
import 'package:plasma/presentation/home/ui/widgets/grid_menu_item.dart';

class GridMenu extends StatelessWidget {
  const GridMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      children: [
        GridMenuItem(
          iconSrc: Assets.addRequest,
          label: "Add Request",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return AddRequestScreen();
              },
            ));
          },
          badgeText: "",
        ),
        GridMenuItem(
          iconSrc: Assets.searchDonor,
          label: "Find Donor",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const FindDonorScreen();
              },
            ));
          },
          badgeText: "",
        ),
      ],
    );
  }
}
