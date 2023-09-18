// import 'package:flutter/material.dart';
// import 'package:iclean_mobile_app/models/account.dart';

// import 'package:intl/intl.dart';

// import 'update_textfield.dart';

// class UpdateProfileScreen extends StatefulWidget {
//   final Account account;
//   const UpdateProfileScreen({Key? key, required this.account})
//       : super(key: key);

//   @override
//   State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
// }

// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//   late final dynamic fullnameController;
//   late final dynamic emailController;
//   late final dynamic phoneController;

//   DateTime? _selectedDate;
//   bool initDateTime = false;
//   String? _selectedGender;

//   @override
//   void initState() {
//     super.initState();
//     fullnameController = TextEditingController(text: widget.account.fullname);
//     emailController = TextEditingController(text: widget.account.email);
//     phoneController = TextEditingController(text: widget.account.phone);
//   }

//   @override
//   void dispose() {
//     fullnameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     super.dispose();
//   }

//   String? validateFullname(String? value) {
//     if (value!.isEmpty) {
//       return 'Please enter full name.';
//     }
//     if (!RegExp(r'^[A-Z][a-zA-Z]*((\s)?([A-Z][a-zA-Z]*))*$').hasMatch(value)) {
//       return 'Please enter valid name.';
//     }
//     return null;
//   }

//   String? validatePhone(String? value) {
//     if (value!.isEmpty) {
//       return 'Please enter a phone number.';
//     }
//     if (!RegExp(r'^[+]?[0-9]{10,13}$').hasMatch(value)) {
//       return 'Please enter only digits and length >= 10.';
//     }
//     return null;
//   }

//   String? validateEmail(String? value) {
//     if (value!.isEmpty) {
//       return 'Please enter email';
//     } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
//         .hasMatch(value)) {
//       return 'Email is invalid';
//     }
//     return null;
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.dark().copyWith(
//             colorScheme: ColorScheme.dark(
//               primary: Colors.deepPurple.shade300,
//               onPrimary: Colors.white,
//               surface: Colors.deepPurple.shade300,
//               onSurface: Colors.black,
//             ),
//             textTheme: const TextTheme(
//               bodyText1: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//               button: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             dialogBackgroundColor: Colors.white,
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   String? validateDropdown(String? value) {
//     if (value?.isEmpty ?? true) {
//       return 'Please select a value';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, top: 15),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Icon(Icons.arrow_back),
//                     ),
//                     const SizedBox(width: 15),
//                     const Text(
//                       'Update Profile',
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontFamily: 'Lato',
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15),
//               Column(
//                 children: [
//                   CircleAvatar(
//                     backgroundImage:
//                         NetworkImage(widget.account.profilePicture),
//                     radius: 50,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     widget.account.fullname,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Lato',
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 child: UpdateTextField(
//                   controller: fullnameController,
//                   labelText: 'Fullname',
//                   hintText: 'Enter your full name',
//                   text: widget.account.fullname,
//                   obscureText: false,
//                   validator: (value) => validateFullname(value),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 child: TextFormField(
//                   controller: TextEditingController(
//                       text: _selectedDate == null
//                           ? DateFormat('dd/MM/yyyy')
//                               .format(widget.account.dateOfBirth)
//                           : DateFormat('dd/MM/yyyy').format(_selectedDate!)),
//                   obscureText: false,
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey.shade400),
//                     ),
//                     fillColor: Colors.grey.shade200,
//                     filled: true,
//                     hintText: 'Enter your birthday',
//                     contentPadding: const EdgeInsets.only(left: 20),
//                     labelText: 'Day Of Birth',
//                     labelStyle: TextStyle(
//                       color: Colors.grey[500],
//                       fontFamily: 'Lato',
//                     ),
//                     hintStyle: TextStyle(
//                       color: Colors.grey[500],
//                       fontFamily: 'Lato',
//                     ),
//                     suffixIcon: GestureDetector(
//                       onTap: () {
//                         _selectDate(context);
//                         setState(() {
//                           initDateTime = true;
//                         });
//                       },
//                       child: const Padding(
//                         padding: EdgeInsets.only(right: 10),
//                         child: Icon(Icons.edit_calendar),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 child: UpdateTextField(
//                   controller: phoneController,
//                   labelText: 'Phone',
//                   hintText: 'Enter your phone',
//                   text: widget.account.phone,
//                   obscureText: false,
//                   validator: (value) => validatePhone(value),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 child: UpdateTextField(
//                   controller: emailController,
//                   labelText: 'Email',
//                   hintText: 'Enter your email',
//                   text: widget.account.email,
//                   obscureText: false,
//                   validator: (value) => validateEmail(value),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey.shade400),
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     labelText: 'Gender',
//                     hintText: 'Select your gender',
//                     labelStyle: TextStyle(
//                       color: Colors.grey[500],
//                       fontFamily: 'Lato',
//                     ),
//                     hintStyle: TextStyle(
//                       color: Colors.grey[500],
//                       fontFamily: 'Lato',
//                     ),
//                     contentPadding: const EdgeInsets.only(left: 20),
//                   ),
//                   icon: const Padding(
//                     padding: EdgeInsets.only(right: 15),
//                     child: Icon(Icons.arrow_drop_down),
//                   ),
//                   value: widget.account.gender,
//                   onChanged: (String? value) {
//                     _selectedGender = value;
//                   },
//                   items: <String>['Male', 'Female'].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   validator: (value) => validateDropdown(value as String?),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 95,
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         child: Column(
//           children: [
//             Divider(
//               thickness: 0.5,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     width: MediaQuery.of(context).size.width / 2.3,
//                     height: MediaQuery.of(context).size.height / 14,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       border: Border.all(
//                           color: Colors.deepPurple.shade300, width: 2),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(
//                             color: Colors.deepPurple.shade300,
//                             fontFamily: 'Lato',
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 1),
//                       ),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     width: MediaQuery.of(context).size.width / 2.3,
//                     height: MediaQuery.of(context).size.height / 14,
//                     decoration: BoxDecoration(
//                       color: Colors.deepPurple.shade300,
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "Save",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'Lato',
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 1),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
