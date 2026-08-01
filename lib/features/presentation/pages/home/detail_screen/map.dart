// Vyzyvay pervый bottomsheet:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/address_type.dart';
import 'package:komekchi_service/features/domain/usecases/address_usecase.dart';
import 'package:komekchi_service/features/presentation/bloc/address/address_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/address/address_type_cubit.dart';
import 'package:komekchi_service/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../map_screen.dart';
import '../widget/address_type_display.dart';

void showSalgyBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const _SalgyBottomSheet(),
  );
}

// ============ ПЕРВЫЙ BOTTOMSHEET ============
class _SalgyBottomSheet extends StatefulWidget {
  const _SalgyBottomSheet();

  @override
  State<_SalgyBottomSheet> createState() => _SalgyBottomSheetState();
}

class _SalgyBottomSheetState extends State<_SalgyBottomSheet> {
  late final AddressCubit _addressCubit = sl<AddressCubit>();
  bool _isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    _checkLoginAndFetch();
  }

  // Addresses require auth — check for a saved token *before* hitting the
  // API instead of surfacing a raw "Not Acceptable"-style backend error to
  // a guest/logged-out user.
  Future<void> _checkLoginAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getString('auth_token') != null;
    if (!mounted) return;
    setState(() => _isLoggedIn = loggedIn);
    if (loggedIn) _addressCubit.fetchAddresses();
  }

  @override
  void dispose() {
    _addressCubit.close();
    super.dispose();
  }

  void _openAddEdit(BuildContext rootContext, {AddressItem? existing}) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 300), () {
      showSalgyAtiandyrBottomSheet(
        rootContext,
        initialText: existing?.address ?? '',
        editUuid: existing?.uuid,
        initialType: existing == null
            ? null
            : AddressTypeItem(
                uuid: existing.addressTypeUuid,
                name: existing.addressTypeName,
              ),
        onLocationAdded: (_) {
          Future.delayed(const Duration(milliseconds: 300), () {
            showSalgyBottomSheet(rootContext);
          });
        },
      );
    });
  }

  Future<void> _delete(AddressItem item) async {
    final t = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.deleteAddressTitle),
        content: Text(item.address),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.no),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(t.yes),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final result = await sl<DeleteAddressUsecase>().call(item.uuid);
    if (!mounted) return;
    result.fold(
      (failure) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failure.message))),
      (_) => _addressCubit.fetchAddresses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = AppColor.cardBg(context);
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    final t = AppLocalizations.of(context)!;

    if (!_isLoggedIn) {
      return Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Icon(
              Icons.person_off_outlined,
              size: 40,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              t.notLoggedInTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              t.notLoggedInAddressesSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  rootContext.push('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  t.loginButton,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.addressSheetTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),

          // Saved addresses
          BlocBuilder<AddressCubit, AddressState>(
            bloc: _addressCubit,
            builder: (context, state) {
              if (state is AddressLoading || state is AddressInitial) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is AddressError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final items = (state as AddressSuccess).items;

              if (items.isEmpty) {
                return Container(
                  margin: const EdgeInsets.only(left: 2),
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 6),
                  decoration: BoxDecoration(
                    color: AppColor.pageBg(context),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      t.noAddresses,
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ),
                );
              }

              return Column(
                children: items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context, item),
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColor.bgPageDark
                                        : const Color(0xFFF6F8FD),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    addressTypeIcon(item.addressTypeName),
                                    color: AppColor.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        addressTypeLabel(
                                          t,
                                          item.addressTypeName,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        item.address,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              _openAddEdit(rootContext, existing: item),
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 18,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _delete(item),
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),

          // Täze salgy goşmak
          GestureDetector(
            onTap: () => _openAddEdit(rootContext),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColor.pageBg(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColor.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    t.addNewAddress,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ============ VTOROY BOTTOMSHEET ============
void showSalgyAtiandyrBottomSheet(
  BuildContext context, {
  required ValueChanged<String> onLocationAdded,
  String initialText = '',
  String? editUuid,
  AddressTypeItem? initialType,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _SalgyAtiandyrBottomSheet(
      onLocationAdded: onLocationAdded,
      initialText: initialText, // ← передай
      editUuid: editUuid,
      initialType: initialType,
    ),
  );
}

class _SalgyAtiandyrBottomSheet extends StatefulWidget {
  final ValueChanged<String> onLocationAdded;
  final String initialText;
  final String? editUuid;
  final AddressTypeItem? initialType;
  const _SalgyAtiandyrBottomSheet({
    required this.onLocationAdded,
    required this.initialText,
    this.editUuid,
    this.initialType,
  });

  @override
  State<_SalgyAtiandyrBottomSheet> createState() =>
      _SalgyAtiandyrBottomSheetState();
}

class _SalgyAtiandyrBottomSheetState extends State<_SalgyAtiandyrBottomSheet> {
  late final TextEditingController _controller;
  String _selectedLocation = '';

  late final AddressTypeCubit _typeCubit = sl<AddressTypeCubit>();
  AddressTypeItem? _selectedType;
  bool _isSubmitting = false;
  late final FocusNode _addressFocusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialText,
    ); // ← инициализируй тут
    _selectedLocation = widget.initialText;
    _selectedType = widget.initialType;
    _typeCubit.fetchAddressTypes();

    // The field starts pre-filled with map coordinates (or the previous
    // value when editing) — select it all on focus so typing a real name
    // replaces it in one go instead of requiring a manual clear first.
    _addressFocusNode = FocusNode();
    _addressFocusNode.addListener(() {
      if (_addressFocusNode.hasFocus) {
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _addressFocusNode.dispose();
    _typeCubit.close();
    super.dispose();
  }

  Future<void> _submit() async {
    final type = _selectedType;
    if (_selectedLocation.isEmpty || type == null || _isSubmitting) return;

    setState(() => _isSubmitting = true);

    final result = widget.editUuid == null
        ? await sl<CreateAddressUsecase>().call(
            CreateAddressParams(
              address: _selectedLocation,
              addressTypeUuid: type.uuid,
            ),
          )
        : await sl<UpdateAddressUsecase>().call(
            UpdateAddressParams(
              uuid: widget.editUuid!,
              address: _selectedLocation,
              addressTypeUuid: type.uuid,
            ),
          );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    result.fold(
      (failure) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failure.message))),
      (_) {
        widget.onLocationAdded(_selectedLocation);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.editUuid != null;
    final t = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
       final cardBg = AppColor.cardBg(context);
       final bg = AppColor.pageBg(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isEdit ? t.editAddressTitle : t.newAddressTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),

            // Text field
            TextField(
              controller: _controller,
              focusNode: _addressFocusNode,
              onChanged: (val) => setState(() => _selectedLocation = val),
              decoration: InputDecoration(
                hintText: t.addressHint,
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: bg,
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                        onPressed: () {
                          _controller.clear();
                          setState(() => _selectedLocation = '');
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(color:bg),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:  BorderSide(color: bg),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Yerinizi girizin — otkryvaet map
            GestureDetector(
              onTap: () {
                // Capture the root Navigator *before* popping this sheet —
                // by the time onLocationSelected fires later, this widget's
                // own `context` is already unmounted (the sheet was closed),
                // so reusing it would crash showSalgyAtiandyrBottomSheet.
                final rootNavigator = Navigator.of(
                  context,
                  rootNavigator: true,
                );
                Navigator.pop(context);
                // Otkryvay map screen
                rootNavigator.push(
                  MaterialPageRoute(
                    builder: (_) => MapScreen(
                      onLocationSelected: (locationName) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          showSalgyAtiandyrBottomSheet(
                            rootNavigator.context,
                            onLocationAdded: widget.onLocationAdded,
                            initialText: locationName, // ← передаём текст сюда
                            editUuid: widget.editUuid,
                            initialType: _selectedType,
                          );
                        });
                      },
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child:  Icon(
                      Icons.add,
                      color:isDark ? Colors.white :  AppColor.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.salgymTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        t.salgymEnterLocation,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey.shade500,
                    size: 18,
                  ),
                ],
              ),
            ),

            // Salgy görnüşi (address type)
            const SizedBox(height: 16),
            Text(
              t.addressType,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            BlocBuilder<AddressTypeCubit, AddressTypeState>(
              bloc: _typeCubit,
              builder: (context, state) {
                if (state is AddressTypeLoading ||
                    state is AddressTypeInitial) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                if (state is AddressTypeError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  );
                }

                final types = (state as AddressTypeSuccess).items;

                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: types.map((type) {
                    final isSelected = _selectedType?.uuid == type.uuid;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedType = type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColor.primary :bg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primary
                                : bg,
                          ),
                        ),
                        child: Text(
                          addressTypeLabel(t, type.name),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColor.titleText(context),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            // Tassyklamak button (esli vveden tekst i vybran tip)
            if (_selectedLocation.isNotEmpty && _selectedType != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          isEdit ? t.edit : t.add,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ============ MAP SCREEN ============
