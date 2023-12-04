import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/provider/checkout_provider.dart';
import 'package:iclean_mobile_app/services/api_checkout_repo.dart';
import 'package:iclean_mobile_app/services/api_location_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/checkout/checkout_cart/checkout_cart_screen.dart';

class ListLocationContentForCart extends StatelessWidget {
  const ListLocationContentForCart({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    Future<List<Address>> fetchLocations() async {
      final ApiLocationRepository repository = ApiLocationRepository();
      try {
        final locations = await repository.getLocation(context);
        return locations;
      } catch (e) {
        return <Address>[];
      }
    }

    void updateCart(int id, bool isUsePoint, bool isAutoAssign) {
      final ApiCheckoutRepository repository = ApiCheckoutRepository();
      repository.updateCart(id, isUsePoint, isAutoAssign, context).then((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CheckoutCartScreen()),
        );
      }).catchError((error) {
        // ignore: avoid_print
        print('Failed to choose location: $error');
      });
    }

    var checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
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
          return Column(
            children: [
              for (int i = 0; i < locations.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: () {
                            updateCart(
                              locations[i].id!,
                              checkoutProvider.usePoint,
                              checkoutProvider.autoAssign,
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                (locations[i].description == text)
                                    ? Icons.circle_rounded
                                    : Icons.circle_outlined,
                                color: Colors.deepPurple.shade300,
                                size: 16,
                              ),
                              const SizedBox(width: 16),
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
                                    Text(
                                      locations[i].description,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (i != locations.length - 1)
                        const Divider(
                          thickness: 0.5,
                          color: ColorPalette.greyColor,
                        ),
                    ],
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
