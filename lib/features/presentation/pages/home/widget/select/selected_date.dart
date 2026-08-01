import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/usecases/address_usecase.dart';
import 'package:komekchi_service/features/presentation/bloc/order/create_order_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/address_type_display.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/select/parts/address_picker_bottom_sheet.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/select/parts/order_form_body.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/select/parts/order_form_scaffold.dart';
import 'package:komekchi_service/injector.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../tolegbottomsheet.dart';

class SelectedDate extends StatefulWidget {
  final String? subcategoryUuid;
  final int quantity;
  final String? orderDate;
  final String? orderTime;

  const SelectedDate({
    super.key,
    this.subcategoryUuid,
    this.quantity = 1,
    this.orderDate,
    this.orderTime,
  });

  @override
  State<SelectedDate> createState() => _SelectedDateState();
}

class _SelectedDateState extends State<SelectedDate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String? _selectedToleg;

  // Set once a field is auto-filled from the user's saved profile —
  // locks that field so it can't be edited afterward. Only applies to
  // fields that actually had data to fill in.
  bool _nameLocked = false;
  bool _phoneLocked = false;
  // The address field is a picker, not free text — it shows the address
  // *type* label (Öý/Iş/Başga) while this holds the actually picked address,
  // whose real text is what gets sent to the backend on submit.
  AddressItem? _selectedAddress;

  @override
  void initState() {
    super.initState();
    _prefillFromProfile();
  }

  Future<void> _openAddressPicker(BuildContext context) async {
    final t = AppLocalizations.of(context)!;
    final picked = await showAddressPickerSheet(
      context,
      selectedUuid: _selectedAddress?.uuid,
    );
    if (picked == null || !mounted) return;
    setState(() {
      _selectedAddress = picked;
      _addressController.text = addressTypeLabel(t, picked.addressTypeName);
    });
  }

  // Ulanyjy eýýäm giren bolsa, onuň ady/telefony/salgysyny özi bilen
  // dolduryp goýýarys — täzeden eli bilen ýazmaly bolmasyn. Doldurylan
  // meýdanlar indi üýtgedip bolmaýar (diňe hakykatdan doly bolan meýdanlar).
  Future<void> _prefillFromProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('name');
    final phone = prefs.getString('phone');

    if (name != null && name.isNotEmpty) _nameController.text = name;
    if (phone != null && phone.isNotEmpty) {
      _phoneController.text = phone.replaceFirst('+993', '');
    }

    final result = await sl<GetAddressesUsecase>().call();
    if (!mounted) return;

    AddressItem? chosenAddress;
    result.fold((_) {}, (items) {
      if (items.isEmpty) return;
      final homeMatches = items.where(
        (a) => a.addressTypeName == 'home_address',
      );
      chosenAddress = homeMatches.isNotEmpty ? homeMatches.first : items.first;
    });

    if (chosenAddress != null) {
      final t = AppLocalizations.of(context)!;
      _addressController.text = addressTypeLabel(
        t,
        chosenAddress!.addressTypeName,
      );
      _selectedAddress = chosenAddress;
    }

    setState(() {
      _nameLocked = name != null && name.isNotEmpty;
      _phoneLocked = phone != null && phone.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final subcategoryUuid = widget.subcategoryUuid;
    final orderDate = widget.orderDate;
    final orderTime = widget.orderTime;

    if (subcategoryUuid == null || orderDate == null || orderTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.serviceTimeNotSelected)));
      return;
    }

    if (_selectedAddress == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.addressPlaceholder)));
      return;
    }

    context.read<CreateOrderCubit>().createOrder(
      subcategoryUuid: subcategoryUuid,
      address: _selectedAddress!.address,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      orderDate: orderDate,
      orderTime: orderTime,
      quantity: widget.quantity,
    );
  }

  void _showTolegBottomSheet(BuildContext context) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return TolegBottomSheet(
          selected: _selectedToleg,
          onSelected: (val) {
            setState(() => _selectedToleg = val);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.cardBg(context);
    final cardBg = AppColor.pageBg(context);
    final textColor = AppColor.titleText(context);
    final borderColor = AppColor.border(context);
    final lockedBg = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final lockedTextColor = isDark ? Colors.grey.shade500 : Colors.grey.shade600;

    return OrderFormScaffold(
      title: t.enterOrderDataTitle,
      bg: bg,
      textColor: textColor,
      isDark: isDark,
      child: OrderFormBody(
        t: t,
        cardBg: cardBg,
        textColor: textColor,
        borderColor: borderColor,
        lockedBg: lockedBg,
        lockedTextColor: lockedTextColor,
        lockIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(Icons.lock_outline, size: 16, color: lockedTextColor),
        ),
        nameController: _nameController,
        phoneController: _phoneController,
        addressController: _addressController,
        noteController: _noteController,
        nameLocked: _nameLocked,
        phoneLocked: _phoneLocked,
        selectedPaymentType: _selectedToleg,
        onTapPaymentType: () => _showTolegBottomSheet(context),
        onTapAddress: () => _openAddressPicker(context),
        onSubmit: () => _submit(context),
      ),
    );
  }
}
