// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kerwenli_yol/helpers/functions/theme.dart';
// import 'package:kerwenli_yol/helpers/functions/translations.dart';
// import 'package:kerwenli_yol/models/contact_us.dart';
// import 'package:kerwenli_yol/pages/parts/open_location_list_tile.dart';
// import 'package:kerwenli_yol/pages/parts/show_image.dart';
// import 'package:kerwenli_yol/providers/api/contact_us.dart';
// import 'package:kerwenli_yol/styles/colors/dark_colors.dart';
// import 'package:kerwenli_yol/styles/colors/light_colors.dart';
// import 'package:kerwenli_yol/styles/text_styles.dart';

// class ContactUsAddress extends ConsumerWidget {
//   const ContactUsAddress({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // ========= Colors =======
//     final bool isLight = isLightTheme(context, ref);
//     final Color innerBgColor = isLight
//         ? LightColors.bgBlogLight
//         : DarkColors.bgBlogDark;

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

//         final String address = translateText(
//           ref,
//           data.addressTm,
//           data.addressRu,
//           data.addressEn,
//           data.addressEn,
//         );

//         return Container(
//           width: double.infinity,
//           margin: EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: innerBgColor,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Maps salgymyz', style: textStyle),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 width: double.maxFinite,
//                 height: 150,
//                 child: ShowImage(
//                   image: 'assets/examples/cropped_map.png',
//                   borderRadius: 10,
//                 ),
//               ),
//               OpenLocationListTile(text: address),
//             ],
//           ),
//         );
//       },
//       error: (_, _) => const SizedBox.shrink(),
//       loading: () => const SizedBox.shrink(),
//     );
//   }
// }
