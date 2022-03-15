import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GridMenuItem extends StatelessWidget {
  final String iconSrc;
  final String label;
  final VoidCallback onTap;
  final String badgeText;

  const GridMenuItem({
    Key? key,
    required this.iconSrc,
    required this.label,
    required this.onTap,
    required this.badgeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Badge(
          badgeColor: Theme.of(context).primaryColor,
          shape: BadgeShape.circle,
          position: const BadgePosition(
            top: -4,
            end: -16,
          ),
          badgeContent: Text(
            badgeText,
            style: Theme.of(context)
                .textTheme
                .bodySmall,
          ),
          showBadge: badgeText.isNotEmpty,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: label,
                    child: SvgPicture.asset(
                      iconSrc,
                      height: 36,
                      width: 36,
                    ),
                  ),
                ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
