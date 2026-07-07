// import 'package:flutter/widgets.dart';
// import 'package:kerwenli_yol/helpers/functions/send.dart';
// import 'package:kerwenli_yol/helpers/functions/theme.dart';
// import 'package:kerwenli_yol/l10n/app_localizations.dart';
// import 'package:kerwenli_yol/models/contact_us.dart';
// import 'package:kerwenli_yol/pages/parts/open_social_list_tile.dart';
// import 'package:kerwenli_yol/styles/colors/dark_colors.dart';
// import 'package:kerwenli_yol/styles/colors/light_colors.dart';
// import 'package:kerwenli_yol/styles/text_styles.dart';

// import '../../../../../../../core/utils/theme/app_text_style.dart';

// class ContactUsEmails extends StatefulWidget {
//   // final ContactUsModel? data; // 👈 данные передаём снаружи

//   const ContactUsEmails({super.key});

//   @override
//   State<ContactUsEmails> createState() => _ContactUsEmailsState();
// }

// class _ContactUsEmailsState extends State<ContactUsEmails> {
//   @override
//   Widget build(BuildContext context) {

//     final TextStyle textStyle = AppTextStyle.semiBold14;

//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: innerBgColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text("Biz bilen Habarlaşmak", style: textStyle),
//           const SizedBox(height: 10),
//           ...widget.data!.emails.map(
//             (e) => OpenSocialListTile(
//               icon: 'mail.png',
//               text: e,
//               onTap: () async {
//                 await sendEmail(e);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
