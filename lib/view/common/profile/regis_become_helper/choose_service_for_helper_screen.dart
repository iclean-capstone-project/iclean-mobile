import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/service.dart';
import 'package:iclean_mobile_app/services/api_account_repo.dart';
import 'package:iclean_mobile_app/services/api_service_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/nav_bar_bottom/renter_screen.dart';
import 'package:iclean_mobile_app/widgets/checkout_success_dialog.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';

class ChooseServiceForHelperScreen extends StatefulWidget {
  const ChooseServiceForHelperScreen({
    super.key,
    required this.image1,
    required this.image2,
    required this.email,
  });

  final String email;
  final File image1, image2;

  @override
  State<ChooseServiceForHelperScreen> createState() =>
      _ChooseServiceForHelperScreenState();
}

class _ChooseServiceForHelperScreenState
    extends State<ChooseServiceForHelperScreen> {
  late List<Map<String, dynamic>> servicesMap = [];
  List<int> selectedServiceIds = [];

  Future<List<Service>> fetchServices() async {
    final ApiServiceRepository apiServiceRepository = ApiServiceRepository();
    try {
      final services = await apiServiceRepository.getService(context);
      return services;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return <Service>[];
    }
  }

  Future<List<Map<String, dynamic>>> getServicesMap() async {
    List<Map<String, dynamic>> servicesMap = [];

    // Fetch services
    List<Service> services = await fetchServices();

    // Create a list of boolean values with default value false
    List<bool> boolList = List.filled(services.length, false);

    // Map services and bool list to servicesMap
    servicesMap = List.generate(
      services.length,
      (index) => {
        'id': services[index].id,
        'name': services[index].name,
        'isChecked': boolList[index],
      },
    );
    return servicesMap;
  }

  void regisHelper(
      String email, File frontIdCard, File backIdCard, String service) {
    final ApiAccountRepository repository = ApiAccountRepository();
    repository
        .helperRegistration(email, frontIdCard, backIdCard, service)
        .then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) => CheckoutSuccessDialog(
          title: "Gửi yêu cầu thành công",
          description:
              "Hệ thống sẽ gửi cho bạn thông báo qua email bạn vừa đăng ký!",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const RenterScreens(selectedIndex: 4)));
          },
        ),
      );
    }).catchError((error) {
      // ignore: avoid_print
      print('Failed to choose location: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    getServicesMap().then((result) {
      setState(() {
        servicesMap = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Hãy chọn những dịch vụ mà bạn muốn làm việc!',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              Column(
                children: servicesMap.map((favorite) {
                  return CheckboxListTile(
                    activeColor: ColorPalette.mainColor,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: favorite["isChecked"],
                    title: Text(
                      favorite["name"],
                      style: const TextStyle(
                        fontFamily: 'Lato',
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        favorite["isChecked"] = val;
                        if (val!) {
                          selectedServiceIds.add(favorite["id"]);
                        } else {
                          selectedServiceIds.remove(favorite["id"]);
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Wrap(
                children: servicesMap.map((favorite) {
                  if (favorite["isChecked"] == true) {
                    return Card(
                      elevation: 3,
                      color: ColorPalette.mainColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              favorite["name"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Lato',
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  favorite["isChecked"] =
                                      !favorite["isChecked"];
                                });
                              },
                              child: const Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }).toList(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        text: "Đăng ký",
        onTap: () {
          String selectedIds = selectedServiceIds.join("&service=");
          print("Selected Service IDs: $selectedIds");
          regisHelper(widget.email, widget.image1, widget.image2, selectedIds);
        },
      ),
    );
  }
}
