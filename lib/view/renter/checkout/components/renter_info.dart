import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/account.dart';
import 'package:iclean_mobile_app/services/api_account_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import 'edit_location_dialog.dart';

class RenterInfo extends StatelessWidget {
  const RenterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Account> fetchAccount() async {
      final ApiAccountRepository apiAccountRepository = ApiAccountRepository();
      try {
        final account = await apiAccountRepository.getAccount();
        return account;
      } catch (e) {
        throw Exception(e);
      }
    }

    void showEditLocation(BuildContext context, Account account) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.36,
          maxChildSize: 0.36,
          minChildSize: 0.36,
          expand: true,
          builder: (context, scrollController) {
            return SingleChildScrollView(
                controller: scrollController,
                child: EditLocationDialog(account: account));
          }),
    );
  }

    return FutureBuilder(
      future: fetchAccount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final account = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
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
                          showEditLocation(context, account);
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
                  "Địa chỉ: ${account.defaultAddress}",
                  style: const TextStyle(
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          );
        }
        return const Divider();
      },
    );
  }
}
