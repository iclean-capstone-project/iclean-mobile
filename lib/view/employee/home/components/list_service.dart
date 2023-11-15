import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/service.dart';
import 'package:iclean_mobile_app/services/api_service_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/booking_service/service_details_screen.dart';

class ListService extends StatelessWidget {
  const ListService({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Service>> fetchServices() async {
      final ApiServiceRepository apiServiceRepository = ApiServiceRepository();
      try {
        final services = await apiServiceRepository.getService();
        return services;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <Service>[];
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder<List<Service>>(
        future: fetchServices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Service> services = snapshot.data ?? [];
            return GridView.count(
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
                            child: Image.network(
                              services[i].icon,
                              width: 40,
                              height: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Flexible(
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
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
            );
          }
        },
      ),
    );
  }
}
