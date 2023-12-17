import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/services/api_account_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import 'edit_location_dialog_for_cart.dart';

class RenterInfoForCart extends StatelessWidget {
  const RenterInfoForCart({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    Future<Account> fetchAccount() async {
      final ApiAccountRepository apiAccountRepository = ApiAccountRepository();
      try {
        final account = await apiAccountRepository.getAccount(context);
        return account;
      } catch (e) {
        throw Exception(e);
      }
    }

    void showEditLocation(BuildContext context, Account account, String text) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) => EditLocationDialogForCart(
          account: account,
          text: text,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder(
        future: fetchAccount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final account = snapshot.data!;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.fullName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Số điện thoại: ${account.phoneNumber}",
                          style: const TextStyle(
                            fontFamily: 'Lato',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorPalette.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          showEditLocation(context, account, text);
                        },
                        child: const Text(
                          "Thay đổi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
