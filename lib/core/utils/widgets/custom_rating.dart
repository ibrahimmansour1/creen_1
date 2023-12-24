// import 'package:flutter/material.dart' hide NavigationDrawer;
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:yalladelivery/core/utils/widgets/text_button.dart';
// import 'package:yalladelivery/features/localization/manager/app_localization.dart';
// import 'custom_form_field.dart';

// class CustomRating extends ConsumerWidget {
//   final void Function() function;
//   const CustomRating({Key? key, required this.function}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//     return Form(
//       key: _formKey,
//       child: AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         title: Center(
//           child: RatingBar.builder(
//             initialRating: 3,
//             minRating: 1,
//             direction: Axis.horizontal,
//             allowHalfRating: true,
//             itemSize: 30,
//             itemCount: 5,
//             itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//             itemBuilder: (context, _) => const Icon(
//               Icons.star,
//               color: Colors.amber,
//             ),
//             onRatingUpdate: (rating) {
//               // print(rating);
//               // rateOrder.rate = rating;
//             },
//           ),
//         ),
//         actions: <Widget>[
//           Card(
//             elevation: 5,
//             margin: const EdgeInsets.all(20),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//             child: CustomFormField(
//               hintText: localization.text('add_reply'),
//               minLines: 5,
//               onChanged: (v) {
//                 // rateOrder.description = v.trim();
//               },
//             ),
//           ),
//           Center(
//             child: CustomTextButton(
//               title: localization.text('send'),
//               function: () {
//                 if (_formKey.currentState!.validate()) {
//                   function();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
