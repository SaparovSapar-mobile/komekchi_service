// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kerwenli_yol/helpers/functions/send.dart';
// import 'package:kerwenli_yol/l10n/app_localizations.dart';
// import 'package:kerwenli_yol/models/contact_us.dart';
// import 'package:kerwenli_yol/pages/contact_us_page/parts/contact_us_top_part.dart';
// import 'package:kerwenli_yol/pages/parts/open_social_list_tile.dart';
// import 'package:kerwenli_yol/providers/api/contact_us.dart';
// import 'package:kerwenli_yol/styles/text_styles.dart';

// class ContactUsPhones extends ConsumerWidget {
//   const ContactUsPhones({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final AppLocalizations lang = AppLocalizations.of(context)!;

//     // ========= Text Styles =======
//     final TextStyle textStyle = AppTextStyles.semiBold14;

//     final AsyncValue<ContactUsModel?> resultApi = ref.watch(
//       fetchContactUsProvider,
//     );

//     return resultApi.when(
//       data: (data) {
//         if (data == null) {
//           return const SizedBox.shrink();
//         }

//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ContactUsTopPart(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(lang.contacts, style: textStyle),
//                 SizedBox(height: 10),
//                 ...data.phones.map(
//                   (e) => OpenSocialListTile(
//                     icon: 'call.png',
//                     text: e.toString(),
//                     onTap: () async {
//                       await launchPhone(e.toString());
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//       error: (_, _) => ContactUsTopPart(),
//       loading: () => ContactUsTopPart(),
//     );
//   }
// }
