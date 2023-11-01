import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/services/api_location_repo.dart';

class EditLocationDialog extends StatelessWidget {
  const EditLocationDialog({
    super.key,
    required this.account,
  });

  final Account account;

  @override
  Widget build(BuildContext context) {
    // if (!isNew) {
    //   Future.delayed(const Duration(seconds: 2), () async {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (context) {
    //           return const RenterScreens();
    //         },
    //       ),
    //     );
    //   });
    // }

    return Column(
      children: [
        Text("asd"),
        Text("asd"),
      ],
    );
  }
}

class ListLocationContent extends StatelessWidget {
  const ListLocationContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<List<Address>> fetchLocations() async {
      final ApiLocationRepository apiLocationRepository =
          ApiLocationRepository();
      try {
        final locations = await apiLocationRepository.getLocation();
        return locations;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <Address>[];
      }
    }

    return FutureBuilder<List<Address>>(
      future: fetchLocations(),
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
          List<Address> locations = snapshot.data ?? [];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(height: 16),
                for (int i = 0; i < locations.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          locations[i].addressName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Lato',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(locations[i].description,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                          fontFamily: 'Lato',
                                        ),
                                        textAlign: TextAlign.justify,
                                        maxLines: null),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (i != locations.length - 1)
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
