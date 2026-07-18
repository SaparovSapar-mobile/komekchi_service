// Vyzyvay pervый bottomsheet:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/address_type.dart';
import 'package:komekchi_service/features/domain/usecases/address_usecase.dart';
import 'package:komekchi_service/features/presentation/bloc/address/address_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/address/address_type_cubit.dart';
import 'package:komekchi_service/injector.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../map_screen.dart';

String _addressTypeLabel(String name) {
  switch (name) {
    case 'home_address':
      return 'Öý';
    case 'work_address':
      return 'Iş';
    case 'other':
      return 'Başga';
    default:
      return name;
  }
}

IconData _addressTypeIcon(String name) {
  switch (name) {
    case 'home_address':
      return Icons.home_outlined;
    case 'work_address':
      return Icons.work_outline;
    default:
      return Icons.location_on_outlined;
  }
}

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

  @override
  void initState() {
    super.initState();
    _addressCubit.fetchAddresses();
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Salgyny pozmalymy?'),
        content: Text(item.address),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Ýok'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Howa'),
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
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final rootContext = Navigator.of(context, rootNavigator: true).context;

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
          const Text(
            'Salgy ady',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Salgy ýok',
                    style: TextStyle(color: Colors.grey.shade400),
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
                                    _addressTypeIcon(item.addressTypeName),
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
                                        _addressTypeLabel(
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
                      color: const Color(0xFFE8F0FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColor.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Täze salgy goşmak',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
  String initialText = '', // ← добавь
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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialText,
    ); // ← инициализируй тут
    _selectedLocation = widget.initialText;
    _selectedType = widget.initialType;
    _typeCubit.fetchAddressTypes();
  }

  @override
  void dispose() {
    _controller.dispose();
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

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
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
              isEdit ? 'Salgyny üýtgetmek' : 'Salgy atiandyr',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),

            // Text field
            TextField(
              controller: _controller,
              onChanged: (val) => setState(() => _selectedLocation = val),
              decoration: InputDecoration(
                hintText: 'Howly jaý',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: const Color(0xFFF6F8FD),
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
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
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
                Navigator.pop(context);
                // Otkryvay map screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapScreen(
                      onLocationSelected: (locationName) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          showSalgyAtiandyrBottomSheet(
                            context,
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
                      color: const Color(0xFFE8F0FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColor.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Salgym',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Ýeriňizi giriziň',
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
            const Text(
              'Salgy görnüşi',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                          color: isSelected ? AppColor.primary : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primary
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          _addressTypeLabel(type.name),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black54,
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
                          isEdit ? 'Üýtgetmek' : 'Goşmak',
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
