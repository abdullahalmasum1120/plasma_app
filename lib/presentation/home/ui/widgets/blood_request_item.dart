import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plasma/data/models/blood_request.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodRequestItem extends StatelessWidget {
  final BloodRequest request;

  const BloodRequestItem({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        request.thana ?? "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hospital",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        request.hospital ?? "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    request.time ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(8, 5),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/drop_fill.svg",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 10,
                        child: Text(
                          request.bloodGroup ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      launch("tel:${request.phone ?? ""}");
                    },
                    child: Text(
                      "Call Now",
                      style: Theme.of(context).textTheme.titleSmall,
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
