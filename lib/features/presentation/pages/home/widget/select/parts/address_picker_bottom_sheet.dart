import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/usecases/address_usecase.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/address_type_display.dart';
import 'package:komekchi_service/injector.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';

/// Opens a bottom sheet listing the user's saved addresses (Öý/Iş/Başga) so
/// they can pick one for the order form, instead of typing it by hand.
/// Returns the picked [AddressItem], or null if dismissed without a pick.
Future<AddressItem?> showAddressPickerSheet(
  BuildContext context, {
  String? selectedUuid,
}) {
  return showModalBottomSheet<AddressItem>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _AddressPickerSheet(selectedUuid: selectedUuid),
  );
}

class _AddressPickerSheet extends StatefulWidget {
  final String? selectedUuid;
  const _AddressPickerSheet({this.selectedUuid});

  @override
  State<_AddressPickerSheet> createState() => _AddressPickerSheetState();
}

class _AddressPickerSheetState extends State<_AddressPickerSheet> {
  late String? _selectedUuid = widget.selectedUuid;
  bool _loading = true;
  String? _error;
  List<AddressItem> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await sl<GetAddressesUsecase>().call();
    if (!mounted) return;
    result.fold(
      (failure) => setState(() {
        _loading = false;
        _error = failure.message;
      }),
      (items) => setState(() {
        _loading = false;
        _items = items;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final descColor = AppColor.descriptionText(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 58,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            t.addressLabel,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Flexible(child: _buildContent(t, textColor, descColor)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildContent(AppLocalizations t, Color textColor, Color descColor) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(_error!, style: const TextStyle(color: Colors.red)),
        ),
      );
    }
    if (_items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(t.noAddresses, style: TextStyle(color: descColor)),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.push('/salgylarym');
              },
              child: Text(t.addNewAddress),
            ),
          ],
        ),
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radioBg = isDark ? AppColor.bgPageDark : Colors.white;
    final radioBorder = isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _items.map((item) {
          final isSelected = _selectedUuid == item.uuid;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedUuid = item.uuid);
              Future.delayed(const Duration(milliseconds: 150), () {
                if (mounted) Navigator.pop(context, item);
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Icon(
                    addressTypeIcon(item.addressTypeName),
                    color: AppColor.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addressTypeLabel(t, item.addressTypeName),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: descColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColor.primary : radioBorder,
                        width: isSelected ? 6 : 1.5,
                      ),
                      color: radioBg,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
