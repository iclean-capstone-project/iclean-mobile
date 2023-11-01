import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/services.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/booking_service/service_details_screen.dart';

class ListService extends StatelessWidget {
  const ListService({
    super.key,
    required this.services,
  });

  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        childAspectRatio: (80 / 72),
        children: [
          for (int i = 0; i < services.length; i++)
            InkWell(
              onTap: () {
                // if (account.defaultAddress != '') {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => ServiceDetailsScreen(
                //         account: account,
                //         service: services[i],
                //       ),
                //     ),
                //   );
                // } else {
                //   showDialog(
                //     context: context,
                //     builder: (BuildContext context) => const LocationDialog(),
                //   );
                // }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceDetailsScreen(
                      service: services[i],
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorPalette.greyColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 4.0,
                      spreadRadius: .05,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: Image.asset(
                        services[i].icon,
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Flexible(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Text(
                            services[i].name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 3,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
