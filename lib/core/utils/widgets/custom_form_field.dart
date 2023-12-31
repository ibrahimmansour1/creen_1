// import 'dart:developer';
// import 'package:flutter/material.dart' hide NavigationDrawer;
// import 'package:flutter/services.dart';
// import 'package:yalladelivery/core/themes/screen_utitlity.dart';
// import 'package:yalladelivery/core/themes/themes.dart';

// class CustomFormField extends StatelessWidget {
//   final double? width, height, radius;
//   final bool? enabled, numbersOnly;
//   final String? labelText, hintText;
//   final int? minLines, maxLines, maxLength;
//   final Color? color;
//   final TextEditingController? controller;
//   final void Function(String)? onChanged;
//   final Widget? suffixIcon;
//   CustomFormField(
//       {Key? key,
//       this.width,
//       this.enabled,
//       this.labelText,
//       this.onChanged,
//       this.height,
//       this.maxLength,
//       this.maxLines,
//       this.color,
//       this.radius,
//       this.numbersOnly,
//       this.hintText,
//       this.controller,
//       this.suffixIcon,
//       this.minLines})
//       : super(key: key);
//   final List<String> acceptedNumbers = [
//     '78',
//     '75',
//     '77',
//     '79',
//     '12',
//     '11',
//     '15',
//     '10',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.all(
//           Radius.circular(radius ?? 5),
//         ),
//       ),
//       child: TextFormField(
//         enabled: enabled,
//         controller: controller,
//         keyboardType: numbersOnly == true ? TextInputType.number : null,
//         inputFormatters: numbersOnly == true
//             ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
//             : null,
//         onChanged: onChanged,
//         validator: (v) {
//           if (v!.isEmpty) {
//             return 'يرجي ملئ الحقل وعدم تركه فارغ';
//           }
//           if (v.length < 4) {
//             return 'يرجي ادخال بيانات حقيقيه كامله';
//           }
//           if (numbersOnly == true) {
//             bool phoneNumberAccepted = false;
//             if (v.startsWith('0')) {
//               v = v.substring(1, v.length);
//             }
//             for (String char in acceptedNumbers) {
//               phoneNumberAccepted = v.startsWith(char);
//               if (phoneNumberAccepted) {
//                 break;
//               }
//             }
//             log(
//               phoneNumberAccepted.toString(),
//             );
//             log(v);
//             if (phoneNumberAccepted == false) {
//               return 'رقم هاتف غير صالح';
//             }
//             if (v.length < 10) {
//               return 'رقم هاتف قصير';
//             }
//           }
//           return null;
//         },
//         textAlign: TextAlign.right,
//         cursorColor: MainStyle.primaryColor,
//         decoration: InputDecoration(
//             counterText: '',
//             contentPadding: const EdgeInsets.all(4),
//             labelStyle: MainTheme.subTextStyle2.copyWith(
//               fontSize: 10,
//             ),
//             suffixIcon: suffixIcon,
//             border: InputBorder.none,
//             labelText: labelText,
//             hintText: hintText,
//             hintStyle: const TextStyle(color: Colors.grey,fontSize: 12)),
//         minLines: minLines,
//         maxLines: maxLines,
//         maxLength: maxLength,
//       ),
//     );
//   }
// }
