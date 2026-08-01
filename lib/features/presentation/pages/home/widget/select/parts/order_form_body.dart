import 'package:flutter/material.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';

import 'labeled_input_field.dart';
import 'order_info_banner.dart';
import 'payment_type_field.dart';
import 'phone_input_section.dart';
import 'submit_order_button.dart';

/// The scrollable form content of [SelectedDate]: info banner, name/phone/
/// address/note fields, payment type picker and the submit button.
class OrderFormBody extends StatelessWidget {
  final AppLocalizations t;
  final Color cardBg;
  final Color textColor;
  final Color borderColor;
  final Color lockedBg;
  final Color lockedTextColor;
  final Widget lockIcon;

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController noteController;

  final bool nameLocked;
  final bool phoneLocked;

  final String? selectedPaymentType;
  final VoidCallback onTapPaymentType;
  final VoidCallback onTapAddress;
  final VoidCallback onSubmit;

  const OrderFormBody({
    super.key,
    required this.t,
    required this.cardBg,
    required this.textColor,
    required this.borderColor,
    required this.lockedBg,
    required this.lockedTextColor,
    required this.lockIcon,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.noteController,
    required this.nameLocked,
    required this.phoneLocked,
    required this.selectedPaymentType,
    required this.onTapPaymentType,
    required this.onTapAddress,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final hintColor = AppColor.descriptionText(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderInfoBanner(cardBg: cardBg, text: t.orderInfoBanner),
        const SizedBox(height: 20),

        LabeledInputField(
          label: t.fullNameLabel,
          textColor: nameLocked ? lockedTextColor : textColor,
          controller: nameController,
          inputBg: nameLocked ? lockedBg : cardBg,
          borderColor: borderColor,
          hintColor: hintColor,
          hint: t.nameHint,
          readOnly: nameLocked,
          suffix: nameLocked ? lockIcon : null,
        ),
        const SizedBox(height: 16),

        PhoneInputSection(
          label: t.phoneLabel,
          textColor: phoneLocked ? lockedTextColor : textColor,
          controller: phoneController,
          inputBg: phoneLocked ? lockedBg : cardBg,
          cardBg: cardBg,
          borderColor: borderColor,
          hintColor: hintColor,
          readOnly: phoneLocked,
          suffix: phoneLocked ? lockIcon : null,
        ),
        const SizedBox(height: 16),

        LabeledInputField(
          label: t.addressLabel,
          textColor: textColor,
          controller: addressController,
          inputBg: cardBg,
          borderColor: borderColor,
          hintColor: hintColor,
          hint: t.addressPlaceholder,
          keyboardType: TextInputType.streetAddress,
          readOnly: true,
          onTap: onTapAddress,
          suffix: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        const SizedBox(height: 16),

        LabeledInputField(
          label: t.noteLabel,
          textColor: textColor,
          controller: noteController,
          inputBg: cardBg,
          borderColor: borderColor,
          hintColor: hintColor,
          hint: t.noteOptionalHint,
        ),
        const SizedBox(height: 16),

        Text(
          t.paymentTypeLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        PaymentTypeField(
          cardBg: cardBg,
          textColor: textColor,
          selected: selectedPaymentType,
          hint: t.paymentTypeHint,
          onTap: onTapPaymentType,
        ),
        const SizedBox(height: 24),

        SubmitOrderButton(
          label: t.submitOrderButton,
          successMessage: t.orderCreatedSuccess,
          onSubmit: onSubmit,
        ),
      ],
    );
  }
}
