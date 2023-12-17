import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:iclean_mobile_app/models/bookings.dart';
import 'package:iclean_mobile_app/models/report_type.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/services/api_report_repo.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/view/renter/history/booking_details/booking_details_screen.dart';
import 'package:iclean_mobile_app/widgets/inkwell_loading.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/select_photo_options_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({
    super.key,
    required this.id,
    required this.helperImage,
    required this.helperName,
    required this.booking,
  });

  final int id;
  final String helperImage, helperName;
  final Booking booking;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportType? selectedReportType;
  final List<File> _images = [];
  File? _image1, _image2, _image3;
  final TextEditingController _commentController = TextEditingController();

  Future<bool> isNetworkImageValid(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      // Handle any exceptions, such as network errors
      return false;
    }
  }

  Future<List<ReportType>> fetchReportType() async {
    final ApiReportRepository repository = ApiReportRepository();
    try {
      final reportType = await repository.getReportType(context);
      return reportType;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return <ReportType>[];
    }
  }

  Future<void> _submitReport(
    int id,
    int reportTypeId,
    List<File> images,
    BuildContext context,
  ) async {
    String comment = _commentController.text.trim();
    if (selectedReportType == null) {
      _showErrorDialog("Bạn chưa chọn loại báo cáo!");
    } else if (comment.isEmpty) {
      _showErrorDialog("Bạn chưa nhập nhận xét.");
    } else {
      final ApiReportRepository repository = ApiReportRepository();

      await repository
          .report(context, id, reportTypeId, comment, _image1, _image2, _image3)
          .then((_) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => BookingDetailsScreen(
                    booking: widget.booking,
                  )),
        );
      }).catchError((error) {
        // ignore: avoid_print
        print('Failed to submitReport: $error');
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Lỗi',
            style: TextStyle(
              fontFamily: 'Lato',
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _images.add(File(img!.path));
        for (int i = 0; i < _images.length && i < 3; i++) {
          switch (i) {
            case 0:
              _image1 = _images[i];
              break;
            case 1:
              _image2 = _images[i];
              break;
            case 2:
              _image3 = _images[i];
              break;
          }
        }
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      if (index == 0) {
        _image1 = null;
      }
      if (index == 1) {
        _image2 = null;
      }
      if (index == 2) {
        _image3 = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loadingState = Provider.of<LoadingStateProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(text: "Báo cáo chất lượng dịch vụ"),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              FutureBuilder<bool>(
                future: isNetworkImageValid(widget.helperImage),
                builder: (context, snapshot) {
                  if (snapshot.hasError || !(snapshot.data ?? false)) {
                    return const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/default_profile.png'),
                      radius: 40,
                    );
                  } else {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(widget.helperImage),
                      radius: 64,
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              Text(
                widget.helperName,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Loại báo cáo",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<List<ReportType>>(
                      future: fetchReportType(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error.toString()}'),
                          );
                        } else {
                          List<ReportType> reportType = snapshot.data!;
                          return Column(
                            children: [
                              DropdownButtonFormField<ReportType>(
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorPalette.greyColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorPalette.mainColor,
                                    ),
                                  ),
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                iconEnabledColor: ColorPalette.mainColor,
                                value: selectedReportType,
                                onChanged: (ReportType? newValue) {
                                  setState(() {
                                    selectedReportType = newValue;
                                  });
                                },
                                hint: const Text(
                                  'Chọn loại báo cáo bạn muốn!',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                  ),
                                ),
                                items: reportType.map((reportTypeItem) {
                                  return DropdownMenuItem<ReportType>(
                                    value: reportTypeItem,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                        reportTypeItem.reportName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Lato',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        }
                      }),
                  const SizedBox(height: 16),
                  const Text(
                    "Ảnh minh họa",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        children: [
                          ..._images.asMap().entries.map((entry) {
                            final index = entry.key;
                            final image = entry.value;
                            return Stack(
                              children: [
                                SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width) / 5,
                                  height:
                                      (MediaQuery.of(context).size.width) / 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      image,
                                      width: 96,
                                      height: 96,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      color: ColorPalette.greyColor,
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                          //if (_images.length <= 2)
                          if (_images.isEmpty)
                            GestureDetector(
                              onTap: () {
                                _showSelectPhotoOptions(context);
                              },
                              child: Container(
                                width: (MediaQuery.of(context).size.width) / 5,
                                height: (MediaQuery.of(context).size.width) / 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: ColorPalette.mainColor,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 40,
                                  color: ColorPalette.mainColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Chi tiết báo cáo",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _commentController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Báo cáo của bạn...',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: ColorPalette.mainColor,
                        ),
                      ),
                    ),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: loadingState.isLoading
                        ? const InkWellLoading()
                        : MainColorInkWellFullSize(
                            onTap: () async {
                              loadingState.setLoading(true);
                              try {
                                await _submitReport(
                                  widget.booking.id,
                                  selectedReportType!.reportTypeId,
                                  _images,
                                  context,
                                );
                              } finally {
                                loadingState.setLoading(false);
                              }
                            },
                            text: "Gửi báo cáo",
                          ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom * 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
